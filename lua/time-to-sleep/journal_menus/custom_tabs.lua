local M = {}

M.custom_tabs = {}
M.add = function(custom_tab)
    M.custom_tabs[custom_tab.tab_id] = custom_tab
end

return M
