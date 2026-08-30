{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.core.sops.system;
in {
  options.modules.core.sops.system.enable = mkEnableOption "sops-nix secrets management";

  config = mkIf cfg.enable {
    sops = {
      defaultSopsFile = ../../../secrets/secrets.yaml;
      defaultSopsFormat = "yaml";

      age.keyFile = "/home/repinek/.config/sops/age/keys.txt"; # FIXME
    };
  };
}
