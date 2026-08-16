{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.programs.krita.user;
in {
  options.modules.programs.krita.user.enable = mkEnableOption "Krita";

  config = mkIf cfg.enable {
    home.packages = [
      (pkgs.krita.overrideAttrs (old: {
        nativeBuildInputs = (old.nativeBuildInputs or []) ++ [pkgs.makeWrapper];
        postFixup =
          (old.postFixup or "")
          + ''
            wrapProgram $out/bin/krita --set QT_QPA_PLATFORM wayland
          '';
      }))
    ];
  };
}
