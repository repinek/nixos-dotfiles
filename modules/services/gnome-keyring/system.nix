{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.services.gnome-keyring.system;
in {
  options.modules.services.gnome-keyring.system.enable = mkEnableOption "GNOME Keyring daemon, take care user's security credentials";

  config = mkIf cfg.enable {
    services.gnome.gnome-keyring.enable = true; # gnome.gnome-keyring is system one
    services.gnome.gcr-ssh-agent.enable = false; # We don't need it since we have openssh agent
  };
}
