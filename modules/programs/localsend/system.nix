{
  config,
  lib,
  ...
}: with lib;
let 
  cfg = config.modules.programs.localsend.system;
in {
  options.modules.programs.localsend.system.enable = mkEnableOption "Localsend";

  # FIXME: why he is white theme
  config = mkIf cfg.enable {
    programs.localsend = {
      enable = true;
      openFirewall = true;
    };
  };
}
