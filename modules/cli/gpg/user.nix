{
  lib,
  config,
  pkgs,
  ...
}: with lib;
let 
  cfg = config.modules.cli.gpg.user;
in {
  options.modules.cli.gpg.user.enable = mkEnableOption "Gnu Privacy Guard";

  config = mkIf cfg.enable {
    programs.gpg = {
      enable = true;
    };

    services.gpg-agent = {
      enable = true;

      pinentry.package = pkgs.pinentry-qt;
    };
  };
}
