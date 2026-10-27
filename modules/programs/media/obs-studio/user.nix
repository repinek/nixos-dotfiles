{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.programs.media.obs-studio.user;
in {
  options.modules.programs.media.obs-studio.user.enable = mkEnableOption "OBS Studio";

  config = mkIf cfg.enable {
    programs.obs-studio.enable = true;
  };
}
