{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.shell.starship.system;
in {
  options.modules.shell.starship.system.enable = mkEnableOption "Starship";

  config = mkIf cfg.enable {
    # NixOS options also apply to root
    programs.starship = {
      enable = true;
      interactiveOnly = true;
      presets = ["plain-text-symbols"];
    };
  };
}
