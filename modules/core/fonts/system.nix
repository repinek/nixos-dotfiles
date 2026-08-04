{
  pkgs,
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.core.fonts.system;
in {
  options.modules.core.fonts.system.enable = mkEnableOption "Fonts";

  config = mkIf cfg.enable {
    fonts.packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      iosevka

      inter
      roboto
      plus-jakarta-sans
      liberation_ttf
      dejavu_fonts
      google-sans # from custom pkgs

      corefonts # Microsoft core fonts - unfree

      noto-fonts
      noto-fonts-extra
      noto-fonts-cjk-sans
      noto-fonts-color-emoji

      source-serif-pro
    ];
  };
}
