{
  pkgs,
  lib,
  config,
  ...
}: with lib;
let 
  cfg = config.modules.cli.scrcpy.user;
in {
  options.modules.cli.scrcpy.user.enable = mkEnableOption "scrcpy - display and control Android devices";

  config = mkIf cfg.enable {
    home.packages = [
      # We don't need .desktop files for these
      (pkgs.scrcpy.overrideAttrs (old: {
        postInstall = (old.postInstall or "") + ''
          rm -f $out/share/applications/scrcpy.desktop
          rm -f $out/share/applications/scrcpy-console.desktop
        ''; 
      }))
    ];
  };
}
