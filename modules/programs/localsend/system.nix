{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.programs.localsend.system;
in {
  options.modules.programs.localsend.system.enable = mkEnableOption "LocalSend";

  config = mkIf cfg.enable {
    programs.localsend = {
      enable = true;
      openFirewall = true;
    };
  };
}
