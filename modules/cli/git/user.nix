{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.cli.git.user;
in {
  options.modules.cli.git.user.enable = mkEnableOption "Git";

  config = mkIf cfg.enable {
    programs.git = {
      enable = true;
      signing = {
        key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIF/HPg31ljATQIHzqtBIvsStdENH57A3CxgstnWnUlxg repinek";
        signByDefault = true;
      };
      settings = {
        user.name = "repinek";
        user.email = "137826826+repinek@users.noreply.github.com";
        gpg.format = "ssh";
      };
    };
  };
}
