{ pkgs, lib, config, ... }: with lib; 
let 
  cfg = config.modules.cli.platform-tools.system;
in {
  options.modules.cli.platform-tools.system.enable = mkEnableOption "platform-tools (adb and fastboot)";

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      androidenv.androidPkgs.platform-tools
    ];
  };
} 
