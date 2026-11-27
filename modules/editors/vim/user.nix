{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.editors.vim.user;
  mkHiddenDesktopFile = import ../../../lib/mkHiddenDesktopFile.nix;
in {
  options.modules.editors.vim.user.enable = mkEnableOption "Vi IMproved";

  config = mkIf cfg.enable {
    programs.vim = {
      enable = true;
      # The GUI is not needed
      packageConfigurable = pkgs.vim;

      defaultEditor = true;

      settings = {
        number = true;
        relativenumber = true;

        tabstop = 4;
        shiftwidth = 4;
        expandtab = true;

        smartcase = true;
        hidden = true;
      };

      extraConfig = ''
        set clipboard=unnamedplus

        imap jj <Esc>
      '';
    };

    xdg.dataFile =
      mkHiddenDesktopFile "vim.desktop" "Vim"
      // mkHiddenDesktopFile "gvim.desktop" "GVim";
  };
}
