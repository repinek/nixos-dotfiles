{
  pkgs,
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.programs.proton-authenticator.user;
in {
  options.modules.programs.proton-authenticator.user.enable = mkEnableOption "Proton Authenticator";

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.proton-authenticator
    ];
  };
}
