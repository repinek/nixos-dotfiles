{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.core.btrfs.system;
in {
  options.modules.core.btrfs.system = {
    enable = mkEnableOption "Btrfs snapshots and maintenance tools";
    scrub.enable = mkEnableOption "Btrfs scrub";
    backup.enable = mkEnableOption "Btrfs and imperative backups";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      btrfs-progs # Btrfs utilities
      btrfs-list # Tree-style Btrfs subvolume viewer
    ];

    services.btrfs.autoScrub = mkIf cfg.scrub.enable {
      enable = true;
      interval = "monthly";
      fileSystems = ["/" "/mnt/Old"];
    };

    systemd.tmpfiles.rules = mkIf cfg.backup.enable [
      "d /btrfs/.snapshots 0755 root root -"
      "d /mnt/Old/backups 0700 root root -"
      "d /mnt/Old/backups/btrbk 0700 root root -"
      "d /mnt/Old/backups/imperative 0700 root root -"
    ];

    # Create daily backups on /mnt/Old and retain snapshots for seven days
    services.btrbk.instances = mkIf cfg.backup.enable {
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

    systemd.services.imperative-backup = mkIf cfg.backup.enable {
      description = "Backup imperative files";
      after = ["local-fs.target"];
      unitConfig.RequiresMountsFor = ["/mnt/Old"];
      serviceConfig = {
        Type = "oneshot";
        ExecStart = "${pkgs.bash}/bin/bash ${./imperative-backup.sh}";
      };
      path = [pkgs.coreutils pkgs.rsync];
    };

    systemd.timers.imperative-backup = mkIf cfg.backup.enable {
      wantedBy = ["timers.target"];
      timerConfig = {
        OnCalendar = "daily";
        Persistent = true;
      };
    };
  };
}
