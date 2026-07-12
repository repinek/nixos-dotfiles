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
    git.user.enable = true;
    starship.user.enable = true;
  };

  modules.editors.opencode.user.enable = true;
  
  modules.shell.fish.user.enable = true;

  home.stateVersion = "26.05";
}
