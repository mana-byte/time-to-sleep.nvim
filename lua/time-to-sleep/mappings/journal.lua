local modules = {
    journal = require("time-to-sleep.journal"),
}
local config = require("time-to-sleep.config")

vim.keymap.set('n', config.mappings.journal.save_and_quit, modules.journal.save_and_quit)
vim.keymap.set('n', config.mappings.journal.open, modules.journal.open)

for i, tab in ipairs(config.journal_tabs) do
    vim.keymap.set('n', config.toggle_tabs_mappings[i],
        function() pcall(modules.journal.toggle_tab, tab) end)
end

-- vim.keymap.set('n', config.mappings.journal.toggle_tab_1,
--     function() modules.journal.toggle_tab(config.journal_tabs[1]) end)
-- vim.keymap.set('n', config.mappings.journal.toggle_tab_2,
--     function() modules.journal.toggle_tab(config.journal_tabs[2]) end)
-- vim.keymap.set('n', config.mappings.journal.toggle_tab_3,
--     function() modules.journal.toggle_tab(config.journal_tabs[3]) end)
