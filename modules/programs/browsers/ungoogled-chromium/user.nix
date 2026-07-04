{
  pkgs,
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.programs.browsers.ungoogled-chromium.user;
in {
  options.modules.programs.browsers.ungoogled-chromium.user.enable = mkEnableOption "Ungoogled Chromium";

  config = mkIf cfg.enable {
    home.packages = [pkgs.ungoogled-chromium];
  };
}
