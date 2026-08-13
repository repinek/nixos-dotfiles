{
  lib,
  config,
  ...
}: with lib;
let 
  cfg = config.modules.editors.codex.user;
in {
  options.modules.editors.codex.user.enable = mkEnableOption "codex - coding agent";

  config = mkIf cfg.enable {
    # No settings here because config.toml must stay mutable for directory approvals and other stuff
    programs.codex.enable = true;
  };
}
