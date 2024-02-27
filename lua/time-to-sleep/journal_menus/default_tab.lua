local tab = require("time-to-sleep.journal_menus.tabs")
local config = require("time-to-sleep.config")
local getIndex = require("time-to-sleep.utils.table").getIndex

local M = tab:new()

M.tab_name = "None"
M.tab_id = "none"
M.tab_filetype = "markdown"
-- M.content = {"# No tab selected"}
-- M.tab = "None"
-- M.tab_content = {}

function M:new(tab_name, tab_id, tab_filetype, tab_, content)
    local o = {}
    setmetatable(o, self)
    self.__index = self
    o.tab_name = tab_name
    o.tab_id = tab_id
    o.tab_filetype = tab_filetype
    o.tab = tab_
    o.content = {o.tab}
    o.tab_content = content
    return o
end

function M:open_win()
    if self.win ~= nil or self.bufnr ~= nil then
        return
    end
    self.bufnr = vim.api.nvim_create_buf(false, true)

    vim.api.nvim_buf_set_name(self.bufnr, self.tab_name .. " menu")

    vim.api.nvim_buf_set_option(self.bufnr, 'bufhidden', 'unload')
    vim.api.nvim_buf_set_option(self.bufnr, 'filetype', self.tab_filetype)
    vim.api.nvim_buf_set_option(self.bufnr, 'buftype', 'nofile')
    vim.api.nvim_buf_set_lines(self.bufnr, 0, -1, false, self.content)
    vim.api.nvim_buf_set_option(self.bufnr, 'modifiable', true)
    self.default_opts.width = #self.tab
    self.default_opts.row = vim.api.nvim_get_option("lines") -
        math.floor(config.journal_tabs_spacing[
            #config.journal_tabs + getIndex(config.custom_journal_tabs, self.tab_id)] / 42 *
            vim.api.nvim_get_option("lines"))
    self.win = vim.api.nvim_open_win(self.bufnr, true, self.default_opts)
end

return M
