local modules = {
    journal = require("time-to-sleep.journal"),
}
local config = require("time-to-sleep.config.config")

vim.keymap.set('n', config.mappings.journal.save_and_quit, modules.journal.save_and_quit)
vim.keymap.set('n', config.mappings.journal.open, modules.journal.open)
vim.keymap.set('v', config.mappings.journal.open_with_code, modules.journal.open_and_copy)

for i, tab in ipairs(config.journal_tabs) do
    vim.keymap.set('n', config.toggle_tabs_mappings[i],
        function() pcall(modules.journal.toggle_tab, tab) end)
end
for i, tab in ipairs(config.custom_journal_tabs) do
    vim.keymap.set('n', config.toggle_tabs_mappings[i+#config.journal_tabs],
        function() pcall(modules.journal.toggle_tab, tab) end)
end
