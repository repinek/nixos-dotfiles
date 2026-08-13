_: {
  wayland.windowManager.hyprland.settings.env = [
    # Cursor
    "XCURSOR_SIZE,20"
    "HYPRCURSOR_SIZE,20"

    # NVIDIA shader disk cache; system environment variables are in nvidia/system.nix
    "__GL_SHADER_DISK_CACHE,1"
    "__GL_SHADER_DISK_CACHE_PATH,$XDG_CACHE_HOME/nv"

    # Dark theme for Qt 6
    "QT_QPA_PLATFORMTHEME,qt6ct"

    # Set GDK and XDG variables
    "GDK_BACKEND,wayland,x11,*"
    "XDG_CURRENT_DESKTOP,Hyprland"
    "XDG_SESSION_TYPE,wayland"
    "XDG_SESSION_DESKTOP,Hyprland"
    "WINIT_UNIX_BACKEND,wayland"
  ];
}
