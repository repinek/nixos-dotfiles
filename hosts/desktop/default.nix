{
  pkgs,
  modulesPath,
  hostname,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    ./hardware-configuration.nix

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
    ../../modules/hardware/hid/system.nix

    ../../modules/programs/throne/system.nix

    ../../modules/shell/fish/system.nix
  ];

  modules.cli = {
    platform-tools.enable = true;
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
    audio.system.enable = true;
    nvidia.system.enable = true;
    hid.system.enable = true;
  };

  modules.programs.throne.system.enable = true;
  modules.shell.fish.system.enable = true;

  networking.hostName = hostname;
  networking.networkmanager.enable = true;

  # FIXME: move to different place
  virtualisation.vmVariant = {
    users.users.repinek.password = "123";
    users.users.root.password = "123";
  };

  system.stateVersion = "26.05";
}
