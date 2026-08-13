{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.shell.starship.user;
in {
  options.modules.shell.starship.user.enable = mkEnableOption "Starship";

  config = mkIf cfg.enable {
    # home-manager configuration applies only to the user
    #
    programs.starship = {
      enable = true;
      enableInteractive = true;
      presets = ["plain-text-symbols"];
    };
  };
}
