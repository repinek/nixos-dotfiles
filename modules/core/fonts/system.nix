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
      google-sans # From custom packages

      corefonts # Microsoft Core Fonts (unfree)

      noto-fonts

      source-serif-pro
    ];
  };
}
