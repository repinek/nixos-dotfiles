{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.services.backup.system;
in {
  options.modules.services.backup.system.enable = mkEnableOption "Btrfs and imperative backups";

  config = mkIf cfg.enable {
    systemd.tmpfiles.rules = [
      "d /btrfs/.snapshots 0755 root root -"
      "d /mnt/Old/backups 0700 root root -"
      "d /mnt/Old/backups/btrbk 0700 root root -"
      "d /mnt/Old/backups/imperative 0700 root root -"
    ];

    # Create daily backups on /mnt/Old and keep snapshots for seven days
    services.btrbk.instances = {
      local = {
        onCalendar = "daily";
        settings = {
          snapshot_preserve = "7d";
          snapshot_preserve_min = "7d";
          target_preserve = "7d";

          volume."/btrfs" = {
            snapshot_dir = "/btrfs/.snapshots";
            target = "/mnt/Old/backups/btrbk";
            subvolume = {
              "@home/repinek/Programming" = {};
              "@home/repinek/Personal" = {};
              "@home/repinek/Media" = {};
            };
          };
        };
      };
    };

    systemd.services.imperative-backup = {
      description = "Backup imperative files";
      after = ["local-fs.target"];
      unitConfig.RequiresMountsFor = ["/mnt/Old"];
      serviceConfig = {
        Type = "oneshot";
        ExecStart = "${pkgs.bash}/bin/bash ${./imperative-backup.sh}";
      };
      path = [pkgs.coreutils pkgs.rsync];
    };

    systemd.timers.imperative-backup = {
      wantedBy = ["timers.target"];
      timerConfig = {
        OnCalendar = "daily";
        Persistent = true;
      };
    };
  };
}
