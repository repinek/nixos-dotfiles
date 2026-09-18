{
  lib,
  config,
  ...
}: with lib;
let 
  cfg = config.modules.programs.keepassxc.user;
in {
  options.modules.programs.keepassxc.user.enable = mkEnableOption "KeePassXC";

  config = mkIf cfg.enable {
    programs.keepassxc = {
      enable = true;
    };
  };
}
