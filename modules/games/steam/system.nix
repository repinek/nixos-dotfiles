{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.games.steam.system;
in {
  options.modules.games.steam.system.enable = mkEnableOption "Steam";

  config = mkIf cfg.enable {
    programs.steam = {
      enable = true;
      protontricks.enable = true;
    };
  };
}
