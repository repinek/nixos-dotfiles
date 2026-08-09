{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.editors.zed.user;
in {
  options.modules.editors.zed.user.enable = mkEnableOption "Zed - editor";

  config = mkIf cfg.enable {
    programs.zed-editor = {
      enable = true;

      # FIXME: Add settings
    };
  };
}
