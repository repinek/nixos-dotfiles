{
  pkgs,
  lib,
  config,
  inputs,
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
      }))
      (inputs.osu-lazer.packages.x86_64-linux.osu-lazer-tachyon-bin.override {
        nativeWayland = true;
      })
    ];

    # Audio buffer settings are defined in hardware/audio
    home.sessionVariables = {
      OSU_SDL3 = "1";
      SDL_VIDEO_DOUBLE_BUFFER = "1";
    };
  };
}
