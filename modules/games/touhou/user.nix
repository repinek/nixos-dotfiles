{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.games.touhou.user;
  thcrapProton = pkgs.thcrap-steam-proton-wrapper.overrideAttrs (old: {
    postPatch =
      (old.postPatch or "")
      + ''
        substituteInPlace thcrap_proton \
          --replace-fail "run '\$THPRAC_FOLDER/thprac.exe'" "run '\$THPRAC_FOLDER/thprac.exe' --attach"
      '';
  });
in {
  options.modules.games.touhou.user.enable = mkEnableOption "Touhou Steam Proton wrapper";

  config = mkIf cfg.enable {
    home.packages = [
      thcrapProton
      pkgs.zenity # Required by thcrap_proton for setup and error dialogs
    ];
  };
}
