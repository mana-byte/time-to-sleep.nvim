local M = {}
local config_ = require("lua.time-to-sleep.config.config")
local custom_tabs_ = require("time-to-sleep.journal_menus.custom_tabs")
M.default_tab = require("time-to-sleep.journal_menus.default_tab")

M.create_tab = function(tab_name, tab_id, tab_filetype, tab, content)
    custom_tabs_.add(M.default_tab:new(tab_name, tab_id, tab_filetype, tab, content))
end

M.setup = function(config)
    config_.configure(config)
    require("time-to-sleep.mappings.journal")
    require("time-to-sleep.mappings.tts")
end

return M
