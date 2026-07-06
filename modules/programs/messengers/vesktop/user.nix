{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.programs.messengers.vesktop.user;
in {
  options.modules.programs.messengers.vesktop.user.enable = mkEnableOption "Vesktop (Discord)";

  config = mkIf cfg.enable {
    programs.vesktop.enable = true;
  };
}
