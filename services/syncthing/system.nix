{
  config,
  lib,
  username,
  ...
}:
with lib; let
  cfg = config.services.syncthing.system;
  user = config.users.users.${username};
in {
  options.services.syncthing.system.enable = mkEnableOption "Syncthing";

  config = mkIf cfg.enable {
    services.syncthing = {
      enable = true;
      openDefaultPorts = true; # NOTE: this will not open syncthing gui port

      user = username;
      inherit (user) group;

      dataDir = user.home;
      configDir = "${user.home}/.config/syncthing";

      settings.options = {
        globalAnnounceEnabled = false;
        localAnnounceEnabled = true;
        relaysEnabled = false;
        natEnabled = false;
      };
    };
  };
}
