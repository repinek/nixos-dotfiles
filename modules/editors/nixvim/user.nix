{
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.editors.nixvim.user;
in {
  options.modules.editors.nixvim.user.enable = mkEnableOption "nixvim - neovim for nix";

  config = mkIf cfg.enable {
    programs.nixvim = {
      enable = true;

      extraPlugins = with pkgs; [
        vimPlugins.base16-nvim
      ];

      extraConfigLua = ''
        local ok, matugen = pcall(require, 'matugen')
        if ok then matugen.setup() end
      '';

      imports = [
        ./keymaps.nix

        ./plugins/obsidian.nix
        ./plugins/transparency.nix
      ];
    };
  };
}
