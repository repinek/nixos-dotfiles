{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.editors.codex.user;
in {
  options.modules.editors.codex.user.enable = mkEnableOption "Codex coding agent";

  config = mkIf cfg.enable {
    # Keep config.toml mutable for directory approvals and local settings
    programs.codex.enable = true;
  };
}
