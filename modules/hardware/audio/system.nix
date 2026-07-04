{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.hardware.audio.system;
in {
  options.modules.hardware.audio.system.enable = mkEnableOption "Audio defaults";

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
  };
}
