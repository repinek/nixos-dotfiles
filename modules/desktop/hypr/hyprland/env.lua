local home = assert(os.getenv("HOME"), "HOME is not set")
local cache_home = os.getenv("XDG_CACHE_HOME") or (home .. "/.cache")

-- Cursor
hl.env("XCURSOR_SIZE", "20")
hl.env("HYPRCURSOR_SIZE", "20")

-- NVIDIA shader disk cache; system environment variables are in nvidia/system.nix
hl.env("__GL_SHADER_DISK_CACHE", "1")
hl.env("__GL_SHADER_DISK_CACHE_PATH", cache_home .. "/nv")

-- Dark theme for Qt 6
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")

-- Set GDK and XDG variables
hl.env("GDK_BACKEND", "wayland,x11,*")
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
hl.env("WINIT_UNIX_BACKEND", "wayland")
