{pkgs, ...}: {
  home.packages = [
    (pkgs.writeShellScriptBin "toggle-float" ''
      width=''${1:-1200}
      height=''${2:-700}

      is_floating=$(hyprctl activewindow -j | ${pkgs.jq}/bin/jq 'floating')
      if [ "$is_floating" = "true" ]; then
        hyprctl dispatch togglefloating
      else
        hyprctl --batch "dispatch togglefloating; dispatch resizeactive exact $width $height; dispatch centerwindow"
      fi
    '')
  ];
}
