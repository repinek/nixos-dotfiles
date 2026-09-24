{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.games.osu-lazer.user;
in {
  options.modules.games.osu-lazer.user.enable = mkEnableOption "osu!lazer";

  config = mkIf cfg.enable {
    home.packages = [
      # Play with Double Time
      (pkgs.gammastep.overrideAttrs (old: {
        postInstall =
          (old.postInstall or "")
          + ''
            rm -f $out/share/applications/gammastep-indicator.desktop
          '';
    }))];

    programs.osu-lazer = {
      enable = true;

      nativeWayland = true;
      extraShellArgs = [ 
        "--set" "OSU_SDL3" "1"
        "--set" "SDL_VIDEO_DOUBLE_BUFFER" "1"
      ];
      channel = "tachyon";

      storagePath = "/home/repinek/Games/osu!";

      # files."Games/osu!" = {
      # };
    };
  };
}
