local table_utils = require("time-to-sleep.utils.table")

local default_config = {}

default_config.default_pos = "x"
default_config.tts_toggle = true
default_config.lualine_tts_toggle = false
default_config.telescope_integration = true

default_config.journal_tabs = {
    "emojis",
    "titles",
    "history",
}
default_config.journal_tabs_spacing = {
    35,
    30,
    25,
    20,
    15,
    10,
    5
}
default_config.toggle_tabs_mappings = {
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7"
}
default_config.mappings = {
    journal = {
        open = "<leader>j",
        save_and_quit = "<Esc>",
    },
    tts = {
        stop = "<leader>t"
    }
}

default_config.configure = function(config)
    table_utils.setValues(default_config, config)
end

return default_config
