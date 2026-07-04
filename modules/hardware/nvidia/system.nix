{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.hardware.nvidia.system;
in {
  options.modules.hardware.nvidia.system = {
    enable = mkEnableOption "Nvidia drivers";
    powerManagement.enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    boot.kernelParams = [
      "nvidia_drm.fbdev=1"
      "nvidia.NVreg_PreserveVideoMemoryAllocations=1"
    ];

    services.xserver.videoDrivers = ["nvidia"];

    hardware = {
      graphics = {
        enable = true;
        enable32Bit = true;
        extraPackages = with pkgs; [
          egl-wayland
          libvdpau-va-gl
        ];
      };

      nvidia = {
        modesetting.enable = true;
        nvidiaSettings = false; # We don't need them since we on wayland
        powerManagement.enable = cfg.powerManagement.enable;
        open = true;
        package = config.boot.kernelPackages.nvidiaPackages.stable;
      };
    };

    environment.variables = {
      LIBVA_DRIVER_NAME = "nvidia";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
      NIXOS_OZONE_WL = "1";
      ELECTRON_OZONE_PLATFORM_HINT = "auto";
    };

    environment.systemPackages = with pkgs; [
      libva
      libva-utils
      mesa-demos
    ];
  };
}
