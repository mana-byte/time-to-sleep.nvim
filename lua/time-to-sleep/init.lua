local M = {}
local config_ = require("time-to-sleep.config")

M.setup = function(config)
    config_.configure(config)
    require("time-to-sleep.mappings.journal")
    require("time-to-sleep.mappings.tts")
end

return M
