local M = {}

M.date = string.gsub(tostring(os.date("%x")), '/', '-')
local close_tts = require("time-to-sleep.utils.buffer_functions").close_tts
local config = require("time-to-sleep.config")
local tips = require("time-to-sleep.floating-buffer")
local tips_win = nil
local content = {}
local win = nil


local function create_journals_if_not_exist()
    local success, error_message = vim.fn.mkdir("journals/", "p")
    if not success then
        print("Failed to create directory:", error_message)
    end
end

local function is_buffer_displayed(bufnr)
    for _, winid in ipairs(vim.api.nvim_list_wins()) do
        if vim.api.nvim_win_get_buf(winid) == bufnr then
            return true
        end
    end
    return false
end
local function close_buf(bufnr)
    pcall(vim.api.nvim_buf_delete, bufnr, { force = true })
    return nil
end

local function read_journal()
    local journal = "journals/" .. M.date .. ".md"
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
        table.insert(content, "# Journal for " .. M.date)
    end
end

M.save_and_quit = function()
    if M.bufnr == nil then
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
        close_tts(win)
        close_tts(tips_win)
        content = {}
        M.bufnr = close_buf(M.bufnr)
    else
        print("Failed to open file for writing")
    end
end


M.open = function()
    if M.bufnr ~= nil then
        M.save_and_quit()
    end
    M.bufnr = vim.api.nvim_create_buf(false, true)

    vim.api.nvim_buf_set_name(M.bufnr, "Journal for" .. M.date .. '.md')

    read_journal()

    vim.api.nvim_buf_set_option(M.bufnr, 'bufhidden', 'hide')
    vim.api.nvim_buf_set_option(M.bufnr, 'filetype', 'text')
    vim.api.nvim_buf_set_option(M.bufnr, 'buftype', 'acwrite')
    vim.api.nvim_buf_set_option(M.bufnr, 'modified', true)
    local opts = {
        style = "minimal",
        relative = "editor",
        width = 50,
        height = 30,
        row = vim.api.nvim_get_option("lines") - 35,
        col = vim.api.nvim_get_option("columns") - math.floor((vim.api.nvim_get_option("columns")) / 4),
        border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
        focusable = true
    }

    tips_win = tips.open_at({ " Use " .. config.mappings.journal.save_and_quit .. " to save and quit the journal " },
        { row = opts.row - 1, col = opts.col - 7 })
    vim.api.nvim_buf_set_lines(M.bufnr, 0, -1, false, content)
    win = vim.api.nvim_open_win(M.bufnr, true, opts)
end

return M
