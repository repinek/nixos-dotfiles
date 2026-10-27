{
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.modules.editors.agents.codex.user.enable {
    sops.secrets."repinek/codex/agents" = {
      format = "binary";
      sopsFile = ../../../../secrets/repinek/codex/AGENTS.md;
      path = "${config.home.homeDirectory}/.codex/AGENTS.md";
    };
  };
}
