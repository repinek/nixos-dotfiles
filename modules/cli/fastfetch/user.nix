{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.cli.fastfetch.user;
in {
  options.modules.cli.fastfetch.user.enable = mkEnableOption "Fastfetch";

  # Config in config.jsonc
  # If home-manager it's probably won't work with template
  # FIXME: maybe try rewrite this as home-manager??
  config = mkIf cfg.enable {
    programs.fastfetch.enable = true;
  };
}
