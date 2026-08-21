{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.services.gnome-keyring.user;
in {
  options.services.gnome-keyring.user.enable = mkEnableOption "GNOME Keyring client";

  config = mkIf cfg.enable {
    services.gnome-keyring.enable = true;
  };
}
