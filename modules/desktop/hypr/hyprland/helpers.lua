local M = {}

function M.toggle_float(width, height)
    return function()
        local window = hl.get_active_window()
        if window == nil then
            return
        end

        local was_tiled = not window.floating
        hl.dispatch(hl.dsp.window.float({ action = "toggle" }))

        if was_tiled then
            hl.dispatch(hl.dsp.window.resize({
                x = width,
                y = height,
                relative = false,
            }))
            hl.dispatch(hl.dsp.window.center())
        end
    end
end

return M
