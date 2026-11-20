{
  ...
}: {
  imports = [
    ../../modules/cli/zellij/user.nix
  ];

  modules.cli.zellij.user.enable = true;

  home.stateVersion = "26.05";
}
