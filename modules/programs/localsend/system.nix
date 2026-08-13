{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.programs.localsend.system;
in {
  options.modules.programs.localsend.system.enable = mkEnableOption "LocalSend";

  # FIXME: Investigate why LocalSend uses a light theme
  config = mkIf cfg.enable {
    programs.localsend = {
      enable = true;
      openFirewall = true;
    };
  };
}
