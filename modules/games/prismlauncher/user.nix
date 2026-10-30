{
  config,
  lib,
}:
with lib; let
  cfg = config.modules.games.prismlauncher.user;
in {
  options.modules.games.prismlauncher.user.enable = mkEnableOption "Prism Launcher";

  config = mkIf cfg.enable {
    programs.prismlauncher = {
      enable = true;
    };
  };
}
