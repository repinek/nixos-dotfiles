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
      gammastep # We are playing DT :fire:
      osu-lazer-bin
    ];

    # FIXME: maybe move latency to host specific
    home.sessionVariables = {
      OSU_SDL3 = "1";
      SDL_VIDEO_DOUBLE_BUFFER = "1";
      SDL_AUDIODRIVER = "pipewire";
      SDL_AUDIO_DEVICE_SAMPLE_FRAMES = "128";
      PIPEWIRE_LATENCY = "128/48000";
    };
  };
}
