{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.desktop.theme.user;
in {
  # FIXME: maybe move something from noctalia here??
  # It's looks kinda messy idk
  options.modules.desktop.theme.user.enable = mkEnableOption "Desktop theming";

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      adw-gtk3
      qt6Packages.qt6ct
    ];

    # Configure GTK 3 / 4
    gtk = {
      enable = true;
      gtk3.extraConfig = {gtk-application-prefer-dark-theme = true;};
      gtk4.extraConfig = {gtk-application-prefer-dark-theme = true;};
    };

    dconf.settings."org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      gtk-theme = "adw-gtk3";
    };

    # Configure QT
    qt = {
      enable = true;
      platformTheme.name = "qtct";
    };

    # Use noctalia color scheme
    xdg.configFile = {
      "qt5ct/qt5ct.conf".text = ''
        [Appearance]
        color_palette=true
        color_scheme_path=${config.home.homeDirectory}/.config/qt5ct/colors/noctalia.conf
      '';

      "qt6ct/qt6ct.conf".text = ''
        [Appearance]
        custom_palette=true
        color_scheme_path=${config.home.homeDirectory}/.config/qt6ct/colors/noctalia.conf
      '';
    };

    # Setup cursor
    home.pointerCursor = {
      gtk.enable = true;
      x11.enable = true;
      name = "Bibata-Modern-Classic";
      package = pkgs.bibata-cursors;
      size = 20;
    };
  };
}
