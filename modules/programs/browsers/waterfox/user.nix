{
  inputs,
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.programs.browsers.waterfox.user;
in {
  options.modules.programs.browsers.waterfox.user.enable = mkEnableOption "Waterfox Browser";

  config = mkIf cfg.enable {
    # 3-rd-party flake, be aware
    home.packages = [inputs.waterfox-bin.packages.x86_64-linux.waterfox-bin];
  };
}
