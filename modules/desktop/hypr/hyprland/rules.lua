-- special_scale_factor deprecated since 0.57.0
-- Not sure how I need to implement this for 90%
hl.workspace_rule({ workspace = "special:magic", gaps_out = { top = 72, right = 128, bottom = 72, left = 128 } })

-- 1 Workspace for browser
hl.window_rule({ match = { class = "librewolf" }, workspace = "1 silent" })

-- 2 Workspace for messengers
hl.window_rule({ match = { class = "org.telegram.desktop" }, workspace = "2 silent" })
hl.window_rule({ match = { class = "vesktop" }, workspace = "2 silent" })

-- 3 Workspace for games and code editors
hl.window_rule({ match = { class = "osu!" }, workspace = "3 silent" })
hl.window_rule({ match = { class = "osu!" }, immediate = true }) -- Allow tearing
hl.window_rule({ match = { class = "com.mojang.minecraft" }, workspace = "3 silent" })

hl.window_rule({ match = { class = "codium" }, workspace = "3 silent" }) -- I don't use vscode anymore but ok
hl.window_rule({ match = { class = "dev.zed.Zed" }, workspace = "3 silent" })

-- Run OBS Studio silently on the magic (scratchpad) workspace, float, size, and center it
hl.window_rule({ match = { class = "com.obsproject.Studio" }, workspace = "special:magic silent" })
hl.window_rule({ match = { class = "com.obsproject.Studio" }, float = true })
hl.window_rule({ match = { class = "com.obsproject.Studio" }, size = { 1200, 700 } })
hl.window_rule({ match = { class = "com.obsproject.Studio" }, center = true })
