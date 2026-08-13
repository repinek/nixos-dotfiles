{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.cli.fastfetch.user;
in {
  options.modules.cli.fastfetch.user.enable = mkEnableOption "Fastfetch";

  # Noctalia generates the Fastfetch configuration
  config = mkIf cfg.enable {
    programs.fastfetch.enable = true;
  };
}
