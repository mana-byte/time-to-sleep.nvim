local M = {}
local timer = vim.loop.new_timer()

M.interval = 150000

M.refresh = function(refresh)
    timer:start(0, M.interval, vim.schedule_wrap(refresh))
end

M.stop = function()
    timer:stop()
end
return M
