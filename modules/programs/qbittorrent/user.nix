{
  pkgs,
  lib,
  config,
  ...
}: with lib;
let 
  cfg = config.modules.programs.qbittorrent.user;
in {
  options.modules.programs.qbittorrent.user.enable = mkEnableOption "qBittorrent";

  config = mkIf cfg.enable {
    home.packages = [pkgs.qbittorrent];
  };
}
