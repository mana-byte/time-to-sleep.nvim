local M = {}
M.status_bar_assistant = require("time-to-sleep.chearup.status-bar-assistant")
M.floating_buffer = require("lua.time-to-sleep.utils.floating-buffer")
M.lualine = require("lualine.lualine_intergration")
M.close_tts = require("time-to-sleep.utils.buffer_functions").close_tts

local clock = require("time-to-sleep.utils.clock")
local win = nil


M.open_tts = function()
    M.close_tts(win)
    win = M.floating_buffer.open({ M.status_bar_assistant.time_to_sleep() })
    vim.cmd("silent wincmd p")
end

M.start_tts = function()
    if not win then
        clock.refresh(M.open_tts)
    end
end


M.stop_tts = function()
    clock.stop()
    M.close_tts(win)
end

M.boot_tts = function(config)
    if M.lualine.sucess and config.lualine_tts_toggle then
        M.lualine.inegrate_at(config.default_pos)
    end
    if config.tts_toggle and not config.lualine_tts_toggle then
        M.start_tts()
    end
end

return M
