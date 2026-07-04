{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.cli.ssh.user;
in {
  # FIXME: I quite don't understand how it's works... Add using ssh-add for now...
  options.modules.cli.ssh.user.enable = mkEnableOption "ssh";

  config = mkIf cfg.enable {
    programs.ssh = {
      enable = true;
      enableDefaultConfig = false;

      settings = {
        "*" = {
          AddKeysToAgent = "yes";
          IdentityFile = "~/.ssh/id_ed25519";
        };

        "github.com" = {
          HostName = "github.com";
          User = "git";
          IdentityFile = "~/.ssh/id_ed25519";
        };
      };
    };

    services.ssh-agent.enable = true;
  };
}
