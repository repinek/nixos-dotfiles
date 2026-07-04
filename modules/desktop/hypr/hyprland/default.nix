{...}: {
  imports = [
    ./scripts/toggle-float.nix

    ./rules.nix
    ./env.nix
    ./variables.nix

    ./execs.nix

    ./general.nix
    ./keybinds.nix
    ./input.nix

    ./monitors.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    configType = "hyprlang"; # FIXME: again move to .lua
  };
}
