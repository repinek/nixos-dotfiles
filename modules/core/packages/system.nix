{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.core.packages.system;
in {
  # Put system-level packages here when they are:
  # 1. Needed before the user session starts
  # 2. Needed when running as root
  # 3. Used with hardware
  # 4. Not available as a Home Manager module
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

      # vim: Remove the gvim .desktop entry
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
