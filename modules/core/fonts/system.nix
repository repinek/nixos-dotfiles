{
  pkgs,
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.core.fonts.system;
in {
  options.modules.core.fonts.system.enable = mkEnableOption "Basic fonts";

  # FIXME: add Google Fonts
  config = mkIf cfg.enable {
    fonts.packages = with pkgs; [
      nerd-fonts.jetbrains-mono
    ];
  };
}
