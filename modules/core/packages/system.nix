{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.core.packages.system;
in {
  # Put system-level packages here:
  # 1. Needed before user session 
  # 2. Needed when running as root
  # 3. Works with hardware
  # 4. No home-manager module available
  options.modules.core.packages.system.enable = mkEnableOption "Base system packages";

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      strace # Sys calls tracer
      lsof # List open files
      pciutils # Inspect and manipulate PCI devices (e.g. lspci)
      psmisc # Utilities that use the proc fs (killall, pstree, fuser)
      parted # Disks utils
      file # Shows the type of files
      usbutils # USB devices (lsusb)
      btop # Monitor of resources

      git
      wget
      curl
      zip
      unzip
      p7zip
      rsync
      ffmpeg

      # vim: Remove gvim .desktop
      (vim.overrideAttrs (old: {
        postInstall =
          (old.postInstall or "")
          + ''
            rm -f $out/share/applications/gvim.desktop
          '';
      }))
    ];
  };
}
