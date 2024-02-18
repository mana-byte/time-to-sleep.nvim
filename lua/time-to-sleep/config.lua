local default_config = {}

default_config.default_pos = "x"
default_config.tts_toggle = true
default_config.lualine_tts_toggle = false
default_config.mappings = {
    journal = {
        open = "<leader>j",
        save_and_quit = "<Esc>",
        toggle_emojis = "1",
        toggle_titles = "2"
    },
    tts = {
        stop = "<leader>t"
    }
}

default_config.configure = function(config)
    for key, value in pairs(config) do
        default_config[key] = value
    end
end

return default_config
