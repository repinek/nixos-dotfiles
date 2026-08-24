hl.window_rule({ match = { class = "osu!" }, immediate = true }) -- Allow tearing

hl.window_rule({ match = { class = "waterfox" }, workspace = "1 silent" })
hl.window_rule({ match = { class = "org.telegram.desktop" }, workspace = "2 silent" })
hl.window_rule({ match = { class = "osu!" }, workspace = "3 silent" })
hl.window_rule({ match = { class = "codium" }, workspace = "3 silent" })

-- Run OBS Studio silently on the magic workspace; float, size, and center it
hl.window_rule({ match = { class = "com.obsproject.Studio" }, workspace = "special:magic silent" })
hl.window_rule({ match = { class = "com.obsproject.Studio" }, float = true })
hl.window_rule({ match = { class = "com.obsproject.Studio" }, size = { 1200, 700 } })
hl.window_rule({ match = { class = "com.obsproject.Studio" }, center = true })
