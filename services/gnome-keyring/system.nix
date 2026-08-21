{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.services.gnome-keyring.system;
in {
  options.services.gnome-keyring.system.enable = mkEnableOption "GNOME Keyring daemon";

  config = mkIf cfg.enable {
    services.gnome.gnome-keyring.enable = true; # gnome.gnome-keyring is system one
    services.gnome.gcr-ssh-agent.enable = false; # We don't need it since we have openssh agent
  };
}
