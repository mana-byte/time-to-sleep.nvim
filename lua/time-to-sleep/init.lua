local M = {}

M.status_bar_assistant = require("time-to-sleep.status-bar-assistant")
M.floating_buffer = require("time-to-sleep.floating-buffer")

M.floating_buffer.open( { M.status_bar_assistant.time_to_sleep() })


return M
