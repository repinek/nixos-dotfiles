{...}: {
  imports = [
    ../../modules/core/packages/user.nix

    ../../modules/cli/fastfetch/user.nix
    ../../modules/cli/git/user.nix
    ../../modules/cli/starship/user.nix

    ../../modules/editors/opencode/user.nix

    ../../modules/shell/fish/user.nix
  ];

  modules.core.packages.user.enable = true;

  modules.cli = {
    fastfetch.user.enable = true;
    git.user = {
      enable = true;
      signing = {
        key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIF/HPg31ljATQIHzqtBIvsStdENH57A3CxgstnWnUlxg repinek";
        format = "ssh";
        signByDefault = true;
      };
      user = {
        name = "repinek";
        email = "137826826+repinek@users.noreply.github.com";
      };
    };
    starship.user.enable = true;
  };

  modules.editors.opencode.user.enable = true;

  modules.shell.fish.user.enable = true;

  home.stateVersion = "26.05";
}
