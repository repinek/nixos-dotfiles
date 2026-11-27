{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.cli.scrcpy.user;
  mkHiddenDesktopFile = import ../../../lib/mkHiddenDesktopFile.nix;
in {
  options.modules.cli.scrcpy.user.enable = mkEnableOption "scrcpy display and control Android devices";

  config = mkIf cfg.enable {
    home.packages = [pkgs.scrcpy];

    # Desktop entries are not needed for this package
    xdg.dataFile =
      mkHiddenDesktopFile "scrcpy.desktop" "scrcpy"
      // mkHiddenDesktopFile "scrcpy-console.desktop" "scrcpy console";
  };
}
