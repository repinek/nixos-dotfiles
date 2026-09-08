{
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.modules.cli.git.user.enable {
    programs.git = {
      signing = {
        key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIF/HPg31ljATQIHzqtBIvsStdENH57A3CxgstnWnUlxg repinek";
        format = "ssh";
        signByDefault = true;
      };

      settings.user = {
        name = "repinek";
        email = "137826826+repinek@users.noreply.github.com";
      };
    };
  };
}
