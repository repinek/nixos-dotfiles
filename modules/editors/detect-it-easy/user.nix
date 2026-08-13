{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.editors.detect-it-easy.user;
in {
  options.modules.editors.detect-it-easy.user.enable = mkEnableOption "Detect It Easy file type analysis";

  # Set Options -> Scan -> Change paths to
  # `/etc/profiles/per-user/$USER/lib/die`
  # where `$USER` is the output of `echo $USER`
  # https://github.com/NixOS/nixpkgs/issues/539259
  config = mkIf cfg.enable {
    home.packages = [pkgs.detect-it-easy];
  };
}
