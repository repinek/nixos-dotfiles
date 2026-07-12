_: {
  wayland.windowManager.hyprland.settings.env = [
    # Cursor
    "XCURSOR_SIZE,20"
    "HYPRCURSOR_SIZE,20"

    # Nvidia shader disk cache (system env vars in nvidia/system.nix)
    "__GL_SHADER_DISK_CACHE,1"
    "__GL_SHADER_DISK_CACHE_PATH,$XDG_CACHE_HOME/nv"

    # Dark Theme for qt6
    "QT_QPA_PLATFORMTHEME,qt6ct"

    # Specify GDK, XDG
    "GDK_BACKEND,wayland,x11,*"
    "XDG_CURRENT_DESKTOP,Hyprland"
    "XDG_SESSION_TYPE,wayland"
    "XDG_SESSION_DESKTOP,Hyprland"
    "WINIT_UNIX_BACKEND,wayland"
  ];
}
