{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.editors.jadx.user;
in {
  options.modules.editors.jadx.user.enable = mkEnableOption "JADX Dex-to-Java decompiler";

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.jadx
    ];

    # https://github.com/NixOS/nixpkgs/blob/nixos-unstable/pkgs/by-name/ja/jadx/package.nix
    # _JAVA_AWT_WM_NONREPARENTING=1 is required for the GUI to work
    xdg.desktopEntries.jadx = {
      name = "JADX";
      exec = "env _JAVA_AWT_WM_NONREPARENTING=1 jadx-gui %F";
      icon = "jadx";
      comment = "Dex to Java decompiler";
      type = "Application";
      categories = ["Development" "Utility"];
    };
  };
}
