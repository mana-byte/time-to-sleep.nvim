local M = {}


M.setup = function(config)
    if config then
        require("time-to-sleep.config").configure(config)
    else
        require("time-to-sleep.config")
    end
    require("time-to-sleep.mappings.journal")
    require("time-to-sleep.mappings.tts")
end
M.journal = require("time-to-sleep.journal")
M.tts = require("time-to-sleep.tts")
M.mappings = require("time-to-sleep.mappings.journal")

M.setup()

return M
