{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.desktop.mime.user;
in {
  options.modules.desktop.mime.user.enable = mkEnableOption "MIME type associations";

  config = mkIf cfg.enable {
    xdg.mimeApps = {
      enable = true;

      defaultApplications = {
        # Web and browsing
        "text/html" = ["waterfox.desktop"];
        "application/xhtml+xml" = ["waterfox.desktop"];
        "x-scheme-handler/http" = ["waterfox.desktop"];
        "x-scheme-handler/https" = ["waterfox.desktop"];
        "x-scheme-handler/chrome" = ["waterfox.desktop"];
        "x-scheme-handler/about" = ["waterfox.desktop"];
        "x-scheme-handler/unknown" = ["waterfox.desktop"];

        # Files
        "inode/directory" = ["nemo.desktop"];
        "application/x-gnome-saved-search" = ["nemo.desktop"];

        # Archives
        "application/zip" = ["org.gnome.FileRoller.desktop"];
        "application/x-zip-compressed" = ["org.gnome.FileRoller.desktop"];
        "application/x-7z-compressed" = ["org.gnome.FileRoller.desktop"];
        "application/vnd.rar" = ["org.gnome.FileRoller.desktop"];
        "application/x-rar" = ["org.gnome.FileRoller.desktop"];
        "application/x-tar" = ["org.gnome.FileRoller.desktop"];
        "application/gzip" = ["org.gnome.FileRoller.desktop"];
        "application/x-gzip" = ["org.gnome.FileRoller.desktop"];
        "application/bzip2" = ["org.gnome.FileRoller.desktop"];
        "application/x-bzip" = ["org.gnome.FileRoller.desktop"];
        "application/x-xz" = ["org.gnome.FileRoller.desktop"];

        # Documents
        "application/pdf" = ["draw.desktop"];

        # Social
        "x-scheme-handler/discord" = ["vesktop.desktop"];
        "x-scheme-handler/tg" = ["org.telegram.desktop.desktop"];
        "x-scheme-handler/tonsite" = ["org.telegram.desktop.desktop"];

        # Gaming
        "application/x-osu-beatmap" = ["osu!.desktop"];
        "application/x-osu-beatmap-archive" = ["osu!.desktop"];
        "application/x-osu-skin" = ["osu!.desktop"];
        "application/x-osu-skin-archive" = ["osu!.desktop"];
        "x-scheme-handler/osu" = ["osu!.desktop"];
      };
    };
  };
}
