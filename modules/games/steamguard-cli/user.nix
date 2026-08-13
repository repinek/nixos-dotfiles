{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.games.steamguard-cli.user;
in {
  options.modules.games.steamguard-cli.user.enable = mkEnableOption "Steam Guard CLI code generator";

  config = mkIf cfg.enable {
    home.packages = [pkgs.steamguard-cli];
  };
}
