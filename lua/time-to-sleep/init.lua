local M = {}

M.status_bar_assistant = require("time-to-sleep.status-bar-assistant")
M.floating_buffer = require("time-to-sleep.floating-buffer")
M.lualine = require("lualine_intergration")
M.default_pos = "x"
M.lualine_toggle = false

local clock = require("time-to-sleep.utils.clock")
local win = nil

if M.lualine.sucess and M.lualine_toggle then
    M.lualine.inegrate_at(M.default_pos)
end

M.open_tts = function()
    M.close_tts()
    win = M.floating_buffer.open({ M.status_bar_assistant.time_to_sleep() })
    vim.cmd("silent wincmd p")
end

M.start_tts = function()
    if not win then
        clock.refresh(M.open_tts)
    end
end

M.close_tts = function()
    if win then
        if not pcall(function() vim.api.nvim_win_close(win, true) end) then
            print("No tts window to close")
        end
        win = nil
    end
end

M.stop_tts = function()
    clock.stop()
    M.close_tts()
end


return M
