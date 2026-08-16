{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.programs.nemo.user;
in {
  options.modules.programs.nemo.user.enable = mkEnableOption "Nemo file manager";

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      nemo-with-extensions
      nemo-fileroller # File Roller integration
      file-roller # Archive manager
      ffmpegthumbnailer # Video thumbnails
      nemo-preview # File previews on Space
    ];

    # Nemo uses GTK bookmarks
    xdg.configFile."gtk-3.0/bookmarks".text = ''
      file:///home/repinek/Programming Programming
      file:///home/repinek/Personal Personal
      file:///home/repinek/Media Media
      file:///home/repinek/Games Games
      file:///mnt/Old Old
    '';

    dconf.settings = {
      "org/cinnamon/desktop/applications/terminal" = {
        exec = "alacritty";
        exec-arg = "-e";
      };

      "org/nemo/list-view".default-zoom-level = "standard";

      "org/nemo/plugins" = {
        # Hide unused context-menu actions
        disabled-actions = [
          "set-as-background.nemo_action"
          "mount-archive.nemo_action"
          "change-background.nemo_action"
          "add-desklets.nemo_action"
          "90_new-launcher.nemo_action"
          "set-resolution.nemo_action"
        ];
      };

      "org/nemo/preferences" = {
        # Views
        default-folder-viewer = "list-view";

        # Behaviour
        # Use the same view in every directory
        ignore-view-metadata = true;
        inherit-folder-viewer = true;

        # Display
        date-format = "iso"; # ISO 8601 date format

        # Toolbar
        show-compact-view-icon-toolbar = false;
        show-computer-icon-toolbar = true;
        show-edit-icon-toolbar = false;
        show-hidden-files = false;
        show-home-icon-toolbar = true;
        show-new-folder-icon-toolbar = true;
        show-open-in-terminal-toolbar = true;
        show-search-icon-toolbar = false;

        # Preview
        thumbnail-limit = hm.gvariant.mkUint64 1073741824; # 1 GiB
      };

      "org/nemo/preferences/menu-config".selection-menu-favorite = false;

      "org/nemo/search".search-sort-column = "name"; # Sort search results by name

      "org/nemo/window-state" = {
        network-expanded = false; # Keep Network collapsed
        sidebar-bookmark-breakpoint = 0; # Separate bookmarks from My Computer in sidebar
      };
    };
  };
}
