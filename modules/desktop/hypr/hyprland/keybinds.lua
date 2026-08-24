local helpers = require("config.helpers")
local vars = require("config.variables")

local main_mod = vars.main_mod

-- Open applications with mainMod + key
hl.bind(main_mod .. " + Q", hl.dsp.exec_cmd(vars.terminal))
hl.bind(main_mod .. " + E", hl.dsp.exec_cmd(vars.file_manager))
hl.bind(main_mod .. " + B", hl.dsp.exec_cmd(vars.browser))

-- Manage windows with mainMod + key
hl.bind(main_mod .. " + C", hl.dsp.window.close())
hl.bind(main_mod .. " + F", hl.dsp.window.fullscreen())
hl.bind(main_mod .. " + Y", hl.dsp.window.pin())
hl.bind(main_mod .. " + P", hl.dsp.window.pseudo())
hl.bind(main_mod .. " + V", helpers.toggle_float(1200, 700))
hl.bind(main_mod .. " + J", hl.dsp.layout("togglesplit"))

-- Quit Hyprland with mainMod + M
hl.bind(main_mod .. " + M", hl.dsp.exit())

-- Noctalia IPC with mainMod + key
hl.bind(main_mod .. " + R", hl.dsp.exec_cmd("noctalia msg panel-toggle launcher"))
hl.bind(main_mod .. " + L", hl.dsp.exec_cmd("noctalia msg session lock"))
hl.bind(main_mod .. " + SHIFT + V", hl.dsp.exec_cmd("noctalia msg panel-toggle clipboard"))
hl.bind(main_mod .. " + SHIFT + P", hl.dsp.exec_cmd("noctalia msg panel-toggle session"))

-- Take screenshots with Print
hl.bind("Print", hl.dsp.exec_cmd(vars.hyprshot_region))
hl.bind("CTRL + Print", hl.dsp.exec_cmd(vars.hyprshot_full))
hl.bind("SHIFT + Print", hl.dsp.exec_cmd(vars.hyprshot_satty))
hl.bind("CTRL + SHIFT + Print", hl.dsp.exec_cmd(vars.hyprpicker))

-- Switch workspaces or move the active window and follow it with mainMod + [1/9]
for workspace = 1, 9 do
    local key = tostring(workspace)
    hl.bind(main_mod .. " + " .. key, hl.dsp.focus({ workspace = workspace }))
    hl.bind(main_mod .. " + SHIFT + " .. key, hl.dsp.window.move({
        workspace = workspace,
        follow = true,
    }))
end

-- Scroll through existing workspaces with mainMod + scroll wheel [up/down]
hl.bind(main_mod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(main_mod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))

local directions = {
    { key = "left", direction = "l" },
    { key = "right", direction = "r" },
    { key = "up", direction = "u" },
    { key = "down", direction = "d" },
}

for _, direction in ipairs(directions) do
    -- Move focus with mainMod + arrow keys
    hl.bind(main_mod .. " + " .. direction.key, hl.dsp.focus({ direction = direction.direction }))

    -- Move windows with mainMod + Shift + arrow keys
    hl.bind(main_mod .. " + SHIFT + " .. direction.key, hl.dsp.window.move({
        direction = direction.direction,
    }))
end

-- Magic workspace with mainMod + S
hl.bind(main_mod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(main_mod .. " + SHIFT + S", hl.dsp.window.move({
    workspace = "special:magic",
    follow = true,
}))

-- Mouse bindings
hl.bind(main_mod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(main_mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Locked bindings for Noctalia OSD
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("noctalia msg volume-up"), { locked = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("noctalia msg volume-down"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("noctalia msg media toggle"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("noctalia msg media toggle"), { locked = true })
