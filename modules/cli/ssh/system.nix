{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.cli.ssh.system;
in {
  options.modules.cli.ssh.system.enable = mkEnableOption "SSH daemon";

  config = mkIf cfg.enable {
    programs.ssh = {
      startAgent = true;
    };
  };
}
