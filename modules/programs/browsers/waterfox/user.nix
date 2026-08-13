{
  inputs,
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.programs.browsers.waterfox.user;
in {
  options.modules.programs.browsers.waterfox.user.enable = mkEnableOption "Waterfox";

  config = mkIf cfg.enable {
    # Third-party flake
    home.packages = [inputs.waterfox-bin.packages.x86_64-linux.waterfox-bin];
  };
}
