{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.cli.scrcpy.user;
in {
  options.modules.cli.scrcpy.user.enable = mkEnableOption "scrcpy display and control Android devices";

  config = mkIf cfg.enable {
    home.packages = [pkgs.scrcpy];

    # Desktop entries are not needed for this package
    xdg.dataFile = {
      "applications/scrcpy.desktop".text = ''
        [Desktop Entry]
        Type=Application
        Name=scrcpy
        Hidden=true
      '';
      "applications/scrcpy-console.desktop".text = ''
        [Desktop Entry]
        Type=Application
        Name=scrcpy console
        Hidden=true
      '';
    };
  };
}
