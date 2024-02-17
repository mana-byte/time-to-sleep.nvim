local M = {}

local lualine = nil
M.sucess, lualine = pcall(require, "lualine")
if not M.sucess then
    return M
end

local time_to_sleep = require("time-to-sleep.status-bar-assistant").time_to_sleep

local positions = {
    a = { lualine_a = { time_to_sleep } },
    b = { lualine_b = { time_to_sleep } },
    c = { lualine_c = { time_to_sleep } },
    x = { lualine_x = { time_to_sleep } },
    y = { lualine_y = { time_to_sleep } },
    z = { lualine_z = { time_to_sleep } }
}

M.inegrate_at = function(position)
    if not positions[position] then
        print("Invalid position: " .. position)
        return
    end
    lualine.setup({
        sections = positions[position]
    })
end

return M
