{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.cli.ssh.user;
in {
  options.modules.cli.ssh.user.enable = mkEnableOption "SSH client configuration";

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

    # Load the SSH key at startup when the agent has no identities
    programs.fish.interactiveShellInit = ''
      if not ssh-add -l >/dev/null 2>&1
        ssh-add -q ~/.ssh/id_ed25519
      end
    '';
  };
}
