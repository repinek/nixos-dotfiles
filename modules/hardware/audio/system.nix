{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.hardware.audio.system;
in {
  options.modules.hardware.audio.system = {
    enable = mkEnableOption "Audio defaults";
    audio_buffer = mkOption {
      type = types.ints.unsigned;
      default = 1024;
      description = "Audio buffer size for pipewire and SDL";
    };
  };

  config = mkIf cfg.enable {
    # Mic
    security.rtkit.enable = true;

    # Pipewire
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
      jack.enable = true;
      wireplumber.enable = true;
    };

    environment.sessionVariables = {
      SDL_AUDIODRIVER = "pipewire";
      SDL_AUDIO_DEVICE_SAMPLE_FRAMES = toString cfg.audio_buffer;
      PIPEWIRE_LATENCY = "${toString cfg.audio_buffer}/48000";
    };
  };
}
