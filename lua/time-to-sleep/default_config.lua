local default_config = {}

default_config.tts_toggle = true
default_config.lualine_tts_toggle = true
default_config.default_pos = "x"
default_config.emojis = {
    "😊", "😀", "😅", "😂", "🤣", "😉", "😍", "😘", "😜", "😎",
    "😇", "🥰", "🤩", "😋", "😆", "😁", "😄", "😃", "😚", "😙",
    "👍", "👌", "👏", "🙌", "🤝", "🎉", "🎊", "🌟", "🌈", "🎈",
    "🎁", "🎀", "🥳", "🍾", "🎶", "🎵", "🍀", "🌺", "🌸",
    "✏️", "📝", "📖", "📚", "📔", "📓", "📒", "📕", "📗", "📘",
    "📙", "📚", "📖", "📜", "📄", "📃", "📑", "📊", "📈", "📉",
}

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
return default_config
