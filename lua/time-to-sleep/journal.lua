local utils = require("time-to-sleep.utils.buffer_functions")
local config = require("time-to-sleep.config")
local tips = require("time-to-sleep.floating-buffer")

local tips_win = nil
local content = {}

local function create_journals_if_not_exist()
    local success, error_message = vim.fn.mkdir("journals/", "p")
    if not success then
        print("Failed to create directory:", error_message)
    end
end

local function close_tabs_win(tabs)
    for _, tab in pairs(tabs) do
        tab:close_win()
    end
end
local function open_tabs_win(tabs)
    for _, tab in pairs(tabs) do
        tab:open_win()
    end
end

local function read_journal(date)
    local journal = "journals/" .. date .. ".md"
    local sucess, file = pcall(io.open, journal, "r")
    if sucess and file then
        for line in file:lines() do
            table.insert(content, line)
        end
        file:close()
    else
        create_journals_if_not_exist()
        file = io.open(journal, "w")
        if file then
            file:close()
        end
        table.insert(content, "# 📝 Journal for " .. date)
    end
end

local M = {}

M.win = nil
M.date = string.gsub(tostring(os.date("%x")), '/', '-')
M.tabs = {
    emojis = require("time-to-sleep.journal_menus.emojis"):new(),
    titles = require("time-to-sleep.journal_menus.titles"):new(),
    history = require("time-to-sleep.journal_menus.history"):new()
}
M.bufnr = nil


M.toggle_tab = function(tab)
    if utils.is_buffer_displayed(M.bufnr) then
        M.tabs[tab]:toggle_menu(M)
    else
        M.tabs[tab]:close_win()
    end
end

M.close_all_tabs = function()
    local state = false
    for _, tab in pairs(M.tabs) do
        state = state or tab.toggled
        tab:close_tab(M.win)
    end
    return state
end

M.open_specific_journal = function(date)
    M.close_all_tabs()
    M.save_and_quit()
    M.date = date
    M.open()
end

M.save_and_quit = function()
    if M.bufnr == nil then
        return
    end
    if M.close_all_tabs() then
        if not utils.is_window_open(M.win) then
            M.save_and_quit()
        end
        return
    end
    local sucess_l, lines = pcall(vim.api.nvim_buf_get_lines, M.bufnr, 0, -1, false)
    if not sucess_l then
        print("Failed to read buffer lines", lines)
        return
    end
    local journal = "journals/" .. M.date .. ".md"
    local sucess, file = pcall(io.open, journal, "w")
    if sucess and file then
        for _, line in ipairs(lines) do
            file:write(line .. "\n")
        end
        file:close()
        M.win = utils.close_tts(M.win)
        tips_win = utils.close_tts(tips_win)
        close_tabs_win(M.tabs)
        content = {}
        M.bufnr = utils.close_buf(M.bufnr)
        M.date = string.gsub(tostring(os.date("%x")), '/', '-')
    else
        print("Failed to open file for writing")
    end
end

M.open = function()
    if M.bufnr ~= nil then
        M.save_and_quit()
    end
    M.bufnr = vim.api.nvim_create_buf(false, true)

    vim.api.nvim_buf_set_name(M.bufnr, "Journal for " .. M.date .. '.md')

    read_journal(M.date)

    vim.api.nvim_buf_set_option(M.bufnr, 'bufhidden', 'hide')
    vim.api.nvim_buf_set_option(M.bufnr, 'filetype', 'markdown')
    vim.api.nvim_buf_set_option(M.bufnr, 'buftype', 'acwrite')
    vim.api.nvim_buf_set_option(M.bufnr, 'modifiable', true)
    local opts = {
        style = "minimal",
        relative = "editor",
        width = math.floor(50 / 154 * vim.api.nvim_get_option("columns")),
        height = math.floor(30 / 42 * vim.api.nvim_get_option("lines")),
        row = vim.api.nvim_get_option("lines") - math.floor(35 / 42 * vim.api.nvim_get_option("lines")),
        col = vim.api.nvim_get_option("columns") - math.floor((vim.api.nvim_get_option("columns")) / 4),
        border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
        focusable = true
    }
    -- menu windows and tips
    tips_win = tips.open_at({ "📝 Use " .. config.mappings.journal.save_and_quit .. " to save and quit the journal" },
        { row = opts.row - 1, col = opts.col - 8 })
    open_tabs_win(M.tabs)
    -- open the journal
    vim.api.nvim_buf_set_lines(M.bufnr, 0, -1, false, content)
    M.win = vim.api.nvim_open_win(M.bufnr, true, opts)
end

return M
