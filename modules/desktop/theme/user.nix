{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.desktop.theme.user;
in {
  # FIXME: Consider moving shared settings from Noctalia here
  # The current split between theme and Noctalia settings is unclear
  options.modules.desktop.theme.user.enable = mkEnableOption "Theme";

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      adw-gtk3
      qt6Packages.qt6ct
    ];

    # Configure GTK 3 and GTK 4
    gtk = {
      enable = true;
      gtk3.extraConfig = {gtk-application-prefer-dark-theme = true;};
      gtk4.extraConfig = {gtk-application-prefer-dark-theme = true;};
    };

    dconf.settings."org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      gtk-theme = "adw-gtk3";
    };

    # Configure Qt
    qt = {
      enable = true;
      platformTheme.name = "qtct";
    };

    # Use the Noctalia color scheme
    xdg.configFile = {
      # FIXME: Broken
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

    # Configure the cursor
    home.pointerCursor = {
      enable = true;
      gtk.enable = true;
      x11.enable = true;
      name = "Bibata-Modern-Classic";
      package = pkgs.bibata-cursors;
      size = 20;
    };
  };
}
