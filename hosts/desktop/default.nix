{hostname, ...}: {
  imports = [
    ./hardware-configuration.nix

    ../../modules/cli/platform-tools/system.nix
    ../../modules/cli/ssh/system.nix

    ../../modules/core/boot/system.nix
    ../../modules/core/btrfs/system.nix
    ../../modules/core/fonts/system.nix
    ../../modules/core/nix/system.nix
    ../../modules/core/packages/system.nix
    ../../modules/core/security/system.nix
    ../../modules/core/sops/system.nix
    ../../modules/core/system/system.nix

    ../../modules/desktop/hypr/system.nix
    ../../modules/desktop/ly/system.nix

    ../../modules/games/gamemode/system.nix
    ../../modules/games/steam/system.nix

    ../../modules/hardware/audio/system.nix
    ../../modules/hardware/nvidia/system.nix

    ../../modules/programs/localsend/system.nix
    ../../modules/programs/loupe/system.nix
    ../../modules/programs/showtime/system.nix
    ../../modules/programs/throne/system.nix

    ../../modules/shell/fish/system.nix
    ../../modules/shell/starship/system.nix

    ../../services/backup/system.nix
    ../../services/btrfs-scrub/system.nix
    ../../services/gnome-keyring/system.nix
    ../../services/libretranslate/system.nix
    ../../services/nix-gc/system.nix
    ../../services/syncthing/system.nix
  ];

  modules.cli = {
    platform-tools.system.enable = true;
    ssh.system.enable = true;
  };

  modules.core = {
    boot.system = {
      enable = true;
      grub.enable = true;
    };
    btrfs.system.enable = true;
    fonts.system.enable = true;
    nix.system.enable = true;
    packages.system.enable = true;
    security.system.enable = true;
    sops.system.enable = true;
    system.enable = true;
  };

  modules.desktop = {
    hypr.system.enable = true;
    ly.system = {
      enable = true;
      remove_brightness_keys = true;
    };
  };

  modules.games = {
    gamemode.system.enable = true;
    steam.system.enable = true;
  };

  modules.hardware = {
    audio.system = {
      enable = true;
      audio_buffer = 256;
    };
    nvidia.system.enable = true;
  };

  modules.programs = {
    localsend.system.enable = true;
    loupe.system.enable = true;
    showtime.system.enable = true;
    throne.system.enable = true;
  };

  modules.shell = {
    fish.system.enable = true;
    starship.system.enable = true;
  };

  services = {
    backup.system.enable = true;
    btrfs-scrub.system.enable = true;
    gnome-keyring.system.enable = true;
    libretranslate.system.enable = true;
    nix-gc.system.enable = true;
    syncthing = {
      system.enable = true;
      overrideDevices = true;
      overrideFolders = true;

      settings = {
        devices.android = {
          id = "24MBTHJ-N23DFEZ-GVAP5FD-5B7ISLU-G4MJSEH-Y3LXWA4-6RWH2AW-3YXJEQM";
          name = "OnePlus 13 (PJZ110)";
        };

        folders.obsidian = {
          id = "nejof-v2ivg";
          label = "Obsidian Vault";
          path = "~/Personal/Obsidian";
          type = "sendreceive";
          devices = ["android"];
          ignorePerms = true;

          versioning = {
            type = "trashcan";
            params.cleanoutDays = "14";
          };

          ignorePatterns = [
            ".obsidian"
            ".trash"
          ];
        };
      };
    };

    # HID devices
    udev.extraRules = ''
      # Identified with lsusb from usbutils
      # 352d:2383 Drunkdeer A75 Pro ANSI
      KERNEL=="hidraw*", ATTRS{idVendor}=="352d", ATTRS{idProduct}=="2383", MODE="0660", GROUP="users", TAG+="uaccess"

      # 3554:f5f7 Compx SCYROX V8 Dongle
      KERNEL=="hidraw*", ATTRS{idVendor}=="3554", ATTRS{idProduct}=="f5f7", MODE="0660", GROUP="users", TAG+="uaccess"

      # 3554:f5f6 Compx SCYROX V8
      KERNEL=="hidraw*", ATTRS{idVendor}=="3554", ATTRS{idProduct}=="f5f6", MODE="0660", GROUP="users", TAG+="uaccess"
    '';

    # DNS
    resolved = {
      enable = true;
      settings.Resolve = {
        DNS = "194.242.2.4#base.dns.mullvad.net";
        DNSOverTLS = true;
        Domains = "~.";
      };
    };
  };

  # Networking
  networking.hostName = hostname;
  networking.networkmanager.enable = true;
  networking.firewall.checkReversePath = "loose"; # Fixes Throne TUN UDP traffic

  system.stateVersion = "26.05";
}
