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

M.max_height = 20
M.height = 1
M.width = 2
M.win = nil
M.toggled = false
M.bufnr = nil
M.titles = {
    "## Journal",
    "# What i did today",
    "# What i learned today",
    "# What i will do tomorrow",
    "# What i need too add",
    "# Improvements",
    "# Ideas",
    "# Thoughts",
    "# Quotes",
    "# Links",
    "# Resources",
    "# TODO",
    "# Notes",
}
M.tab = require("time-to-sleep.config").mappings.journal.toggle_titles .. 'm'
M.content = { M.tab }
M.calculate_width = function()
    if M.toggled then
        M.width = maxStringLength(M.titles)
    else
        M.width = 2
    end
end

M.calculate_height = function()
    if M.toggled then
        if #M.titles < M.max_height then
            M.height = #M.titles
        else
            M.height = M.max_height
        end
    else
        M.height = 1
    end
end

M.open = function()
    if M.win ~= nil or M.bufnr ~= nil then
        return
    end
    M.bufnr = vim.api.nvim_create_buf(false, true)

    vim.api.nvim_buf_set_name(M.bufnr, "Titles menu")

    vim.api.nvim_buf_set_option(M.bufnr, 'bufhidden', 'unload')
    vim.api.nvim_buf_set_option(M.bufnr, 'filetype', 'markdown')
    vim.api.nvim_buf_set_option(M.bufnr, 'buftype', 'nofile')
    vim.api.nvim_buf_set_lines(M.bufnr, 0, -1, false, M.content)
    vim.api.nvim_buf_set_option(M.bufnr, 'modifiable', true)
    local opts = {
        style = "minimal",
        relative = "editor",
        width = 2,
        height = M.height,
        row = vim.api.nvim_get_option("lines") - math.floor(30 / 42 * vim.api.nvim_get_option("lines")),
        col = vim.api.nvim_get_option("columns") - math.floor((vim.api.nvim_get_option("columns")) / 4) - 20,
        border = { "╭", "─", "+", "│", "╯", "─", "╰", "│" },
        focusable = true
    }
    M.win = vim.api.nvim_open_win(M.bufnr, true, opts)
end

M.close_win = function()
    M.toggled = false
    M.content = { M.tab }
    M.calculate_height()
    M.calculate_width()
    pcall(vim.api.nvim_win_set_width,M.win, M.width)
    pcall(vim.api.nvim_win_set_height,M.win, M.height)
    M.win = utils.close_tts(M.win)
    M.bufnr = utils.close_buf(M.bufnr)
end

M.close_tab = function(win_)
    M.toggled = false
    pcall(vim.api.nvim_set_current_win,win_)
    local sucess, _ = pcall(vim.api.nvim_win_set_cursor,M.win, { 1, 1 })
    if sucess then
        M.content = { M.tab }
        M.calculate_height()
        M.calculate_width()
        vim.api.nvim_win_set_width(M.win, M.width)
        vim.api.nvim_win_set_height(M.win, M.height)
        vim.api.nvim_buf_set_lines(M.bufnr, 0, -1, false, M.content)
    end
end

M.toggle_menu = function(win_)
    vim.api.nvim_win_set_cursor(M.win, { 1, 1 })
    if M.toggled then
        M.content = { M.tab }
        vim.api.nvim_set_current_win(win_)
        M.toggled = false
    else
        M.content = M.titles
        vim.api.nvim_set_current_win(M.win)
        M.toggled = true
    end
    M.calculate_height()
    M.calculate_width()
    vim.api.nvim_win_set_width(M.win, M.width)
    vim.api.nvim_win_set_height(M.win, M.height)
    vim.api.nvim_buf_set_lines(M.bufnr, 0, -1, false, M.content)
end

return M
