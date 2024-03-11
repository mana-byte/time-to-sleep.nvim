local modules = {
    tts = require("lua.time-to-sleep.chearup.tts"),
}

local config = require("lua.time-to-sleep.config.config")
modules.tts.boot_tts(config)
vim.keymap.set('n', config.mappings.tts.stop, modules.tts.stop_tts)
