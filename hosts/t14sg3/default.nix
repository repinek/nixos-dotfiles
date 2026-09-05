
{hostname, ...}: {
  imports = [
    ./hardware-configuration.nix
    ./disko.nix

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

    ../../modules/hardware/audio/system.nix

    ../../modules/programs/localsend/system.nix
    ../../modules/programs/loupe/system.nix
    ../../modules/programs/showtime/system.nix

    ../../modules/shell/fish/system.nix
    ../../modules/shell/starship/system.nix

    ../../services/btrfs-scrub/system.nix
    ../../services/gnome-keyring/system.nix
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

  modules.hardware = {
    audio.system = {
      enable = true;
      audio_buffer = 256;
    };
  };

  modules.programs = {
    localsend.system.enable = true;
    loupe.system.enable = true;
    showtime.system.enable = true;
  };

  modules.shell = {
    fish.system.enable = true;
    starship.system.enable = true;
  };

  services = {
    btrfs-scrub.system.enable = true;
    gnome-keyring.system.enable = true;
    nix-gc.system.enable = true;

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

  services.openssh = {
    enable = true;
    openFirewall = true;
    settings = {
      PasswordAuthentication = true;
      PermitRootLogin = "no";
    };
  };

  # Networking
  networking.hostName = hostname;
  networking.networkmanager.enable = true;

  system.stateVersion = "26.05";
}
