{hostname, pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix
    ./file-system.nix

    ../../modules/cli/platform-tools/system.nix
    ../../modules/cli/ssh/system.nix

    ../../modules/core/boot/system.nix
    ../../modules/core/btrfs/system.nix
    ../../modules/core/fonts/system.nix
    ../../modules/core/nix/system.nix
    ../../modules/core/packages/system.nix
    ../../modules/core/security/system.nix
    ../../modules/core/system/system.nix

    ../../modules/desktop/hypr/system.nix
    ../../modules/desktop/ly/system.nix

    ../../modules/games/gamemode/system.nix
    ../../modules/games/steam/system.nix

    ../../modules/hardware/audio/system.nix
    ../../modules/hardware/nvidia/system.nix

    ../../modules/programs/localsend/system.nix
    ../../modules/programs/throne/system.nix

    ../../modules/services/gnome-keyring/system.nix

    ../../modules/shell/fish/system.nix
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
    throne.system.enable = true;
  };

  modules.services.gnome-keyring.system.enable = true;

  modules.shell.fish.system.enable = true;

  # HID devices
  services.udev.extraRules = ''
    # Explored by usbutils lsusb
    # 352d:2383 Drunkdeer A75 Pro ANSI
    KERNEL=="hidraw*", ATTRS{idVendor}=="352d", ATTRS{idProduct}=="2383", MODE="0660", GROUP="users", TAG+="uaccess"

    # 3554:f5f7 Compx SCYROX V8 Dongle
    KERNEL=="hidraw*", ATTRS{idVendor}=="3554", ATTRS{idProduct}=="f5f7", MODE="0660", GROUP="users", TAG+="uaccess"

    # 3554:f5f6 Compx SCYROX V8
    KERNEL=="hidraw*", ATTRS{idVendor}=="3554", ATTRS{idProduct}=="f5f6", MODE="0660", GROUP="users", TAG+="uaccess"
  '';

  networking.hostName = hostname;
  networking.networkmanager.enable = true;

  system.stateVersion = "26.05";
}
