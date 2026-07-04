{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.core.system;
in {
  options.modules.core.system.enable = mkEnableOption "Base system packages, locale and other defaults";

  config = mkIf cfg.enable {
    # Locales
    i18n = {
      defaultLocale = "en_GB.UTF-8";
      extraLocales = ["ru_RU.UTF-8/UTF-8"];
      extraLocaleSettings = {
        LC_ADDRESS = "ru_RU.UTF-8";
        LC_MEASUREMENT = "ru_RU.UTF-8";
        LC_MESSAGES = "en_GB.UTF-8";
        LC_MONETARY = "ru_RU.UTF-8";
        LC_NAME = "ru_RU.UTF-8";
        LC_NUMERIC = "ru_RU.UTF-8";
        LC_PAPER = "ru_RU.UTF-8";
        LC_TELEPHONE = "ru_RU.UTF-8";
        LC_TIME = "en_GB.UTF-8";
      };
    };

    time.timeZone = mkDefault "Asia/Yekaterinburg";

    services = {
      gvfs.enable = true; # File pickers, trash, mount in file manager
      udisks2.enable = true; # Storage daemon for udiskie
    };

    programs = {
      dconf.enable = true; # Required for GTK apps
      fish.enable = true; # Use fish always
      nix-ld.enable = true; # Run unpatched dynamic libs on NixOS
    };

    gtk.iconCache.enable = true;

    systemd = {
      services.networkManager-wait-online.enable = false;
      settings.Manager.DefaultTimeoutStopSec = "4s";
    };
  };
}
