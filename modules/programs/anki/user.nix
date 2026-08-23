{
  config,
  lib,
  ...
}: with lib;
let 
  cfg = config.modules.programs.anki.user;
in {
  options.modules.programs.anki.user.enable = mkEnableOption "Anki";

  config = mkIf cfg.enable {
    programs.anki = {
      enable = true;
    };
  };
}
