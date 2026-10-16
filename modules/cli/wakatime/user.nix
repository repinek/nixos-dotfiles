{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.cli.wakatime.user;
in {
  options.modules.cli.wakatime.user.enable = mkEnableOption "wakatime home-manager";

  config = mkIf cfg.enable {
    sops.secrets."repinek/wakatime/wakatime" = {
      format = "binary";
      sopsFile = ../../../secrets/repinek/wakatime/wakatime.cfg;
      path = "${config.home.homeDirectory}/.wakatime.cfg";
    };
  };
}
