#!/usr/bin/env bash

# Written entirely by AI

set -euo pipefail
umask 077

backup_root="/mnt/Old/backups/imperative"
completed_root="$backup_root/completed"
backup_date="$(date +%F)"
backup_path="$completed_root/$backup_date"
retention_count=7
source_directories=(
  "/home/repinek/.ssh"
  "/home/repinek/.gnupg"
  "/home/repinek/.config/sops/age"
)

list_completed_backups() {
  find "$completed_root" \
    -mindepth 1 \
    -maxdepth 1 \
    -type d \
    -name '????-??-??' \
    -printf '%f\n'
}

cleanup() {
  if [ -n "$staging_path" ]; then
    rm -rf -- "$staging_path"
  fi
}

backup_directory() {
  local source_path="$1"
  local source_name
  local -a rsync_options=(-aHAX)

  source_name="$(basename "$source_path")"

  if [ -n "$previous_backup" ] && [ -d "$completed_root/$previous_backup/$source_name" ]; then
    rsync_options+=("--link-dest=$completed_root/$previous_backup/$source_name")
  fi

  rsync "${rsync_options[@]}" "$source_path/" "$staging_path/$source_name/"
}

remove_expired_backups() {
  local -a backups
  local backup_index
  local backup_list

  backup_list="$(list_completed_backups | sort -r)"
  if [ -z "$backup_list" ]; then
    return
  fi
  mapfile -t backups <<< "$backup_list"

  for ((backup_index = retention_count; backup_index < ${#backups[@]}; backup_index++)); do
    rm -rf -- "$completed_root/${backups[$backup_index]}"
  done
}

install -d -m 0700 "$backup_root"
exec 9>"$backup_root/.lock"
if ! flock -n 9; then
  echo "Backup already running" >&2
  exit 1
fi

# Only this namespace contains backups published after all copies succeeded
# Legacy date-named directories remain untouched
install -d -m 0700 "$completed_root"

# Keep the first successful backup of each day immutable
if [ -e "$backup_path" ]; then
  remove_expired_backups
  exit 0
fi

previous_backup="$(list_completed_backups | sort | tail -n 1)"
staging_path="$(mktemp -d "$backup_root/.incomplete.XXXXXX")"
trap cleanup EXIT
trap 'exit 130' INT
trap 'exit 143' TERM

for source_directory in "${source_directories[@]}"; do
  backup_directory "$source_directory"
done

mv -T -- "$staging_path" "$backup_path"
staging_path=""
remove_expired_backups
