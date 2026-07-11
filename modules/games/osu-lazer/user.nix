{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.games.osu-lazer.user;
in {
  options.modules.games.osu-lazer.user.enable = mkEnableOption "osu-lazer-bin";

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      # We are playing DT :fire:
      (gammastep.overrideAttrs (old: {
        postInstall =
          (old.postInstall or "")
          + ''
            rm -f $out/share/applications/gammastep-indicator.desktop
          '';
      }))
      osu-lazer-bin
    ];

    # Audio buffer settings stored in hardware/audio
    home.sessionVariables = {
      OSU_SDL3 = "1";
      SDL_VIDEO_DOUBLE_BUFFER = "1";
    };
  };
}
