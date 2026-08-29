{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.programs.messengers.element-desktop.user;
in {
  options.modules.programs.messengers.element-desktop.user.enable = mkEnableOption "Element";

  config = mkIf cfg.enable {
    # On first run, use --password-store=gnome-libsecret
    programs.element-desktop.enable = true;
  };
}
