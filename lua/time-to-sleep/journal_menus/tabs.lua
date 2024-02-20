local utils = require("time-to-sleep.utils.buffer_functions")

local function maxStringLength(strings)
    local maxLen = 0
    for _, str in ipairs(strings) do
        local len = #str
        if len > maxLen then
            maxLen = len
        end
    end
    return maxLen
end
local M = {}

function M:new()
    local o = {}
    setmetatable(o, self)
    self.__index = self
    return o
end

M.max_height = 20
M.height = 1
M.width = 2
M.win = nil
M.toggled = false
M.bufnr = nil
M.tab_content = {}
M.tab = ""
M.content = { M.tab }

function M:open()
end

function M:calculate_width()
    if self.toggled then
        self.width = maxStringLength(self.tab_content)
    else
        self.width = #self.tab
    end
end

function M:calculate_height()
    if self.toggled then
        if #self.tab_content < self.max_height then
            self.height = #self.tab_content
        else
            self.height = self.max_height
        end
    else
        self.height = 1
    end
end

function M:close_win()
    self.toggled = false
    self.content = { self.tab }
    self.calculate_height(self)
    self.calculate_width(self)
    pcall(vim.api.nvim_win_set_height, self.win, self.height)
    pcall(vim.api.nvim_win_set_width, self.win, self.width)
    self.win = utils.close_tts(self.win)
    self.bufnr = utils.close_buf(self.bufnr)
end

function M:close_tab(win_)
    self.toggled = false
    pcall(vim.api.nvim_set_current_win, win_)
    local sucess, _ = pcall(vim.api.nvim_win_set_cursor, self.win, { 1, 1 })
    if sucess then
        self.content = { self.tab }
        self:calculate_tab_content()
    end
end

function M:open_tab()
    self.toggled = true
    pcall(vim.api.nvim_set_current_win, self.win)
    local sucess, _ = pcall(vim.api.nvim_win_set_cursor,self.win, { 1, 1 })
    if sucess then
        self.content = self.tab_content
        self:calculate_tab_content()
    end
end

function M:calculate_tab_content()
    self.calculate_height(self)
    self.calculate_width(self)
    vim.api.nvim_win_set_width(self.win, self.width)
    vim.api.nvim_win_set_height(self.win, self.height)
    vim.api.nvim_buf_set_lines(self.bufnr, 0, -1, false, self.content)
end

function M:toggle_menu(journal)
    self:onToggle(journal)
    if self.toggled then
        self:close_tab(journal.win)
    else
        self:open_tab()
    end
end

function M:onToggle(journal)
end

return M
