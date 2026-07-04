{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.games.gamemode.system;
in {
  options.modules.games.gamemode.system.enable = mkEnableOption "GameMode daemon";

  config = mkIf cfg.enable {
    programs.gamemode = {
      enable = true;
      settings.custom = {
        start = "${pkgs.libnotify}/bin/notify-send 'GameMode started'";
        end = "${pkgs.libnotify}/bin/notify-send 'GameMode ended'";
      };
    };

    programs.steam.extraPackages = [pkgs.gamemode];
  };
}
