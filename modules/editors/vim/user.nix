{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.editors.vim.user;
in {
  options.modules.editors.vim.user.enable = mkEnableOption "Vi IMproved";

  config = mkIf cfg.enable {
    programs.vim = {
      enable = true;
      # The GUI is not needed
      # Use vim instead of vim-full and remove the gvim .desktop entry
      packageConfigurable = pkgs.vim.overrideAttrs (old: {
        postInstall =
          (old.postInstall or "")
          + ''
            rm -f $out/share/applications/gvim.desktop
          '';
      });

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
  };
}
