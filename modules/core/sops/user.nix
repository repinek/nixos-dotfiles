{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.core.sops.user;
in {
  options.modules.core.sops.user.enable =
    mkEnableOption "sops-nix secret management for Home Manager";

  config = mkIf cfg.enable {
    sops = {
      defaultSopsFile = ../../../secrets/secrets.yaml;
      defaultSopsFormat = "yaml";

      age.keyFile = "/home/repinek/.config/sops/age/keys.txt";
    };
  };
}
