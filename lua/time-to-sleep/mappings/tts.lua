local modules = {
    tts = require("time-to-sleep.tts"),
}

local config = require("time-to-sleep.config")
vim.keymap.set('n', config.mappings.tts.stop, modules.tts.stop_tts)
