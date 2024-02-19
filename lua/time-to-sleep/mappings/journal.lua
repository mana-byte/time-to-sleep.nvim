local modules = {
    journal = require("time-to-sleep.journal"),
}
local config = require("time-to-sleep.config")

vim.keymap.set('n', config.mappings.journal.save_and_quit, modules.journal.save_and_quit)
vim.keymap.set('n', config.mappings.journal.open, modules.journal.open)
vim.keymap.set('n', config.mappings.journal.toggle_emojis,function() modules.journal.toggle_tab('emojis') end)
vim.keymap.set('n', config.mappings.journal.toggle_titles,function() modules.journal.toggle_tab('titles') end)
