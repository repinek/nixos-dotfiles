# Written entirely by AI

import fcntl
import os
from pathlib import Path
import shlex
import shutil
import stat
import subprocess
import tempfile
import unittest


SCRIPT = Path(__file__).with_name("imperative-backup.sh").read_text()
BASH = shutil.which("bash")
RSYNC = shutil.which("rsync")


class BackupTests(unittest.TestCase):
    def setUp(self):
        self.temporary = tempfile.TemporaryDirectory(prefix="imperative-backup-test-")
        self.addCleanup(self.temporary.cleanup)
        self.root = Path(self.temporary.name)
        self.home = self.root / "home"
        self.backups = self.root / "backups"
        self.bin = self.root / "bin"
        self.bin.mkdir()

        for directory, filename in [
            (".ssh", "id_ed25519"),
            (".gnupg", "private-key"),
            (".config/sops/age", "keys.txt"),
        ]:
            parent = self.home / directory
            parent.mkdir(parents=True, mode=0o700)
            source = parent / filename
            source.write_text("fixture-" + filename)
            source.chmod(0o600)

        # Redirect the production paths before running any backup commands
        script = SCRIPT.replace(
            'backup_root="/mnt/Old/backups/imperative"',
            "backup_root=" + shlex.quote(str(self.backups)),
            1,
        ).replace("/home/repinek/", str(self.home) + "/")
        self.assertNotIn("/mnt/Old", script)
        self.assertNotIn("/home/repinek/", script)
        self.script = self.root / "backup.sh"
        self.script.write_text(script)

        self.executable("date", 'printf "%s\\n" "$TEST_DATE"\n')
        self.executable(
            "rsync",
            '''for arg in "$@"; do
  if [[ "$arg" == */.gnupg/ ]]; then
    case "${TEST_FAILURE:-}" in
      copy) exit 23 ;;
      term) kill -TERM "$PPID"; exit 0 ;;
    esac
  fi
done
exec ''' + shlex.quote(RSYNC) + ' "$@"\n',
        )

    def executable(self, name, content):
        path = self.bin / name
        path.write_text("#!" + BASH + "\n" + content)
        path.chmod(0o755)

    def run_backup(self, date, failure=""):
        env = dict(
            os.environ,
            PATH=str(self.bin) + os.pathsep + os.environ["PATH"],
            TEST_DATE=date,
            TEST_FAILURE=failure,
        )
        return subprocess.run(
            [BASH, str(self.script)],
            env=env,
            capture_output=True,
            text=True,
            timeout=15,
        )

    def success(self, date):
        result = self.run_backup(date)
        self.assertEqual(result.returncode, 0, result.stderr)
        return self.backups / "completed" / date

    def test_age_key_can_be_restored_from_protected_backup(self):
        snapshot = self.success("2026-10-01")
        recovered = self.root / "recovered-keys.txt"
        shutil.copy2(snapshot / "age/keys.txt", recovered)
        self.assertEqual(
            recovered.read_bytes(),
            (self.home / ".config/sops/age/keys.txt").read_bytes(),
        )
        for directory in [self.backups, self.backups / "completed", snapshot]:
            self.assertEqual(stat.S_IMODE(directory.stat().st_mode), 0o700)
        self.assertEqual(stat.S_IMODE(recovered.stat().st_mode), 0o600)

    def test_incremental_copy_preserves_old_versions_and_source_deletions(self):
        (self.home / ".ssh/deleted").write_text("delete me")
        first = self.success("2026-10-01")
        (self.home / ".ssh/deleted").unlink()
        second = self.success("2026-10-02")
        for filename in [".ssh/id_ed25519", "age/keys.txt"]:
            self.assertEqual(
                (first / filename).stat().st_ino,
                (second / filename).stat().st_ino,
            )
        self.assertFalse((second / ".ssh/deleted").exists())
        self.assertTrue((first / ".ssh/deleted").exists())

        (self.home / ".ssh/id_ed25519").write_text("changed identity data")
        third = self.success("2026-10-03")
        self.assertEqual(
            (first / ".ssh/id_ed25519").read_text(), "fixture-id_ed25519"
        )
        self.assertEqual(
            (third / ".ssh/id_ed25519").read_text(), "changed identity data"
        )
        self.assertNotEqual(
            (second / ".ssh/id_ed25519").stat().st_ino,
            (third / ".ssh/id_ed25519").stat().st_ino,
        )

    def test_same_day_rerun_preserves_successful_snapshot(self):
        snapshot = self.success("2026-10-01")
        (self.home / ".ssh/id_ed25519").write_text("changed")
        self.success("2026-10-01")
        self.assertEqual(
            (snapshot / ".ssh/id_ed25519").read_text(), "fixture-id_ed25519"
        )
        self.assertEqual(len(list((self.backups / "completed").iterdir())), 1)

    def test_failed_copy_is_unpublished_and_can_be_retried(self):
        first = self.success("2026-10-01")
        result = self.run_backup("2026-10-02", "copy")
        self.assertEqual(result.returncode, 23, result.stderr)
        self.assertFalse((self.backups / "completed/2026-10-02").exists())
        self.assertEqual(list(self.backups.glob(".incomplete.*")), [])
        self.assertTrue(first.is_dir())
        self.success("2026-10-02")

    def test_missing_age_key_directory_prevents_publication(self):
        shutil.rmtree(self.home / ".config/sops/age")
        result = self.run_backup("2026-10-01")
        self.assertEqual(result.returncode, 23, result.stderr)
        self.assertEqual(list((self.backups / "completed").iterdir()), [])
        self.assertEqual(list(self.backups.glob(".incomplete.*")), [])

    def test_termination_does_not_publish_partial_backup(self):
        self.success("2026-10-01")
        result = self.run_backup("2026-10-02", "term")
        self.assertEqual(result.returncode, 143, result.stderr)
        self.assertFalse((self.backups / "completed/2026-10-02").exists())
        self.assertEqual(list(self.backups.glob(".incomplete.*")), [])

    def test_retention_ignores_failures_legacy_and_abandoned_staging(self):
        legacy = self.backups / "2026-09-01"
        legacy.mkdir(parents=True)
        (legacy / "preserve").write_text("legacy data")
        abandoned = self.backups / ".incomplete.abandoned"
        abandoned.mkdir()
        for day in range(1, 10):
            self.success(f"2026-10-{day:02d}")
            if day == 7:
                self.assertEqual(self.run_backup("2026-10-08", "copy").returncode, 23)
                self.assertEqual(len(list((self.backups / "completed").iterdir())), 7)
        self.assertEqual(
            sorted(path.name for path in (self.backups / "completed").iterdir()),
            [f"2026-10-{day:02d}" for day in range(3, 10)],
        )
        self.assertTrue((legacy / "preserve").is_file())
        self.assertTrue(abandoned.is_dir())

    def test_concurrent_invocation_cannot_modify_backups(self):
        self.backups.mkdir()
        with (self.backups / ".lock").open("w") as lock:
            fcntl.flock(lock, fcntl.LOCK_EX | fcntl.LOCK_NB)
            result = self.run_backup("2026-10-01")
            self.assertNotEqual(result.returncode, 0)
            self.assertIn("Backup already running", result.stderr)
            self.assertFalse((self.backups / "completed").exists())


if __name__ == "__main__":
    unittest.main(verbosity=2)
