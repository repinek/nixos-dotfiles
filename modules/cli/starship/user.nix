{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.cli.starship.user;
in {
  options.modules.cli.starship.user.enable = mkEnableOption "Starship";

  config = mkIf cfg.enable {
    programs.starship = {
      enable = true;
      presets = ["plain-text-symbols"];
    };
  };
}
