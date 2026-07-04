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
      nemo-fileroller # Archives support
      nemo-preview # Previews on SPACE
    ];

    # FIXME: add bookmarks and mime types

    dconf.settings."org/nemo/preferences" = {
      show-hidden-files = true;
      default-folder-viewer = "list-view";
      sort-directories-first = true;
    };
  };
}
