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
      google-sans # From custom packages

      corefonts # Microsoft Core Fonts (unfree)

      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-color-emoji

      source-serif-pro
    ];
  };
}
