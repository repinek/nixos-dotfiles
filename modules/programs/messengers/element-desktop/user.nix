{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.programs.messengers.element-desktop.user;
in {
  options.modules.programs.messengers.element-desktop.user.enable = mkEnableOption "element-desktop";

  config = mkIf cfg.enable {
    # FIXME: If there's any way to fix
    # First run use --password-store=gnome-libsecret
    programs.element-desktop.enable = true;
  };
}
