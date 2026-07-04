{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.programs.vesktop.user;
in {
  options.modules.programs.vesktop.user.enable = mkEnableOption "Vesktop (Discord)";

  config = mkIf cfg.enable {
    programs.vesktop.enable = true;
  };
}
