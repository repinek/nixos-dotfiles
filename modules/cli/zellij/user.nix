{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.cli.zellij.user;
in {
  options.modules.cli.zellij.user.enable = mkEnableOption "Zellij";

  config = mkIf cfg.enable {
    programs.zellij = {
      enable = true;
      # enableFishIntegration = true;

      settings = {
        theme = "noctalia";

        show_startup_tips = false;
      };
    };
  };
}
