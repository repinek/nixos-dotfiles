{...}: {
  imports = [
    # These modules contain user-specific settings
    # For example, Git signing and identity
    # If the corresponding module is not enabled, no settings are generated
    # This is similar to lazy initialization
    ./settings/anki/user.nix
    ./settings/codex/user.nix
    ./settings/git/user.nix
    ./settings/obsidian/user.nix
    ./settings/sops/user.nix # sops has no corresponding module, so its settings are always generated

    ../../modules/core/packages/user.nix

    ../../modules/cli/fastfetch/user.nix
    ../../modules/cli/gh/user.nix
    ../../modules/cli/ssh/user.nix
    ../../modules/shell/starship/user.nix

    ../../modules/editors/codex/user.nix
    ../../modules/editors/opencode/user.nix
    ../../modules/editors/vim/user.nix

    ../../modules/shell/fish/user.nix
  ];

  modules.core = {
    packages.user.enable = true;
  };

  modules.cli = {
    fastfetch.user.enable = true;
    gh.user.enable = true;
    ssh.user.enable = true;
  };

  modules.editors = {
    codex.user.enable = true;
    opencode.user.enable = true;
    vim.user.enable = true;
  };

  modules.shell = {
    fish.user.enable = true;
    starship.user.enable = true;
  };

  home.stateVersion = "26.05";
}
