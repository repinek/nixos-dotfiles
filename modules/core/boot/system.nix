{
  lib,
  pkgs,
  config,
  ...
}:
with lib; let
  cfg = config.modules.core.boot.system;
in {
  options.modules.core.boot.system = {
    enable = mkEnableOption "Boot";

    grub = {
      enable = mkEnableOption "GRUB bootloader";
      device = mkOption {
        type = types.str;
        default = "nodev";
      };
      efiSupport = mkOption {
        type = types.bool;
        default = true;
      };
      useOSProber = mkOption {
        type = types.bool;
        default = true;
      };
    };
  };

  config = mkIf cfg.enable {
    boot = {
      kernelPackages = pkgs.linuxPackages_latest;
      tmp.cleanOnBoot = true; # Clear /tmp on every boot

      loader = {
        efi = {
          efiSysMountPoint = "/boot";
          canTouchEfiVariables = true; # Manage EFI boot entries automatically
        };

        grub = mkIf cfg.grub.enable {
          enable = true;
          device = cfg.grub.device;
          efiSupport = cfg.grub.efiSupport;
          useOSProber = cfg.grub.useOSProber; # Detect other operating systems
          configurationLimit = 10;
        };
      };
    };
  };
}
