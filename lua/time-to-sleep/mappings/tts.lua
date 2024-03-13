local modules = {
    tts = require("time-to-sleep.chearup.tts"),
}

local config = require("time-to-sleep.config.config")
modules.tts.boot_tts(config)
vim.keymap.set('n', config.mappings.tts.stop, modules.tts.stop_tts)
