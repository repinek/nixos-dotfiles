{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.programs.feather.user;
in {
  options.modules.programs.feather.user.enable = mkEnableOption "Feather Monero wallet";

  config = mkIf cfg.enable {
    home.packages = [pkgs.feather];
  };
}
