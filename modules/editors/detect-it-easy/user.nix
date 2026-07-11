{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.editors.detect-it-easy.user;
in {
  options.modules.editors.detect-it-easy.user.enable = mkEnableOption "Detect it Easy (DiE) - Program for determining types of files";

  # Options -> Scan -> Change paths to
  # `/etc/profiles/per-user/$USER/lib/die`
  # where `$USER` is `echo $USER`
  # https://github.com/NixOS/nixpkgs/issues/539259
  config = mkIf cfg.enable {
    home.packages = [pkgs.detect-it-easy];
  };
}
