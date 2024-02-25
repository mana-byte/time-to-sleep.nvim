local modules = {
    tts = require("time-to-sleep.tts"),
}

local config = require("time-to-sleep.config")
modules.tts.boot_tts(config)
vim.keymap.set('n', config.mappings.tts.stop, modules.tts.stop_tts)
