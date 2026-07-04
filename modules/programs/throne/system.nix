{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.programs.throne.system;
in {
  options.modules.programs.throne.system.enable = mkEnableOption "Throne VPN client";

  config = mkIf cfg.enable {
    programs.throne = {
      enable = true;

      # https://throneproj.github.io/get_started/configuration/#tun-mode
      tunMode.enable = true;
    };
  };
}
