hl.config({
    input = {
        -- Switch the US/RU layout with Shift + Alt
        kb_layout = "us,ru",
        kb_options = "grp:alt_shift_toggle",

        repeat_rate = 50,
        repeat_delay = 250,

        follow_mouse = 1,

        accel_profile = "flat", -- raw input
        force_no_accel = true, -- no accel: sens 1:1
        sensitivity = 0,
    },
})
