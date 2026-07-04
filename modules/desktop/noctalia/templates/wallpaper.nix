{
  pkgs,
  config,
  ...
}: let
  cfgDir = "${config.xdg.configHome}/noctalia/wallpaper";
in {
  home.packages = [pkgs.librsvg];

  programs.noctalia.settings.theme.templates.user.wallpaper = {
    input_path = "templates/nix-wallpaper.svg";
    output_path = "wallpaper/noctalia-wallpaper.svg";

    # Generate unique .png from template .svg on each templates-apply
    # wallpaper-set with the same path skips reload
    # So we append a timestamp to force a unique path every time
    # Keep last 2 files so latest.png always has a valid target on startup
    post_hook = ''
      stamp=$(date +%s%N) && \
      rsvg-convert "${cfgDir}/noctalia-wallpaper.svg" -o "${cfgDir}/generated-wallpaper-$stamp.png" && \
      ln -sf "generated-wallpaper-$stamp.png" "${cfgDir}/latest.png" && \
      ls -t "${cfgDir}"/generated-wallpaper-*.png 2>/dev/null | tail -n +3 | xargs rm -f -- && \
      noctalia msg wallpaper-set "${cfgDir}/generated-wallpaper-$stamp.png"
    '';
  };

  xdg.configFile."noctalia/templates/nix-wallpaper.svg".source =
    ../../../../assets/wallpapers/nix-wallpaper.svg;
}
