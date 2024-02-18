local utils = require("time-to-sleep.utils.buffer_functions")
local M = {}

M.max_height = 20
M.height = 1
M.win = nil
M.toggled = false
M.bufnr = nil
M.emojis = {
    "😊", "😀", "😅", "😂", "🤣", "😉", "😍", "😘", "😜", "😎",
    "😇", "🥰", "🤩", "😋", "😆", "😁", "😄", "😃", "😚", "😙",
    "👍", "👌", "👏", "🙌", "🤝", "🎉", "🎊", "🌟", "🌈", "🎈",
    "🎁", "🎀", "🥳", "🍾", "🎶", "🎵", "🍀", "🌺", "🌸",
    "✏️", "📝", "📖", "📚", "📔", "📓", "📒", "📕", "📗", "📘",
    "📙", "📚", "📖", "📜", "📄", "📃", "📑", "📊", "📈", "📉",
}
M.tab = require("time-to-sleep.config").mappings.journal.toggle_emojis .. 'm'
M.content = { M.tab }

M.calculate_height = function()
    if M.toggled then
        M.height = M.max_height
    else
        M.height = 1
    end
end

M.open = function()
    if M.win ~= nil or M.bufnr ~= nil then
        return
    end
    M.bufnr = vim.api.nvim_create_buf(false, true)

    vim.api.nvim_buf_set_name(M.bufnr, "Emoji menu")

    vim.api.nvim_buf_set_option(M.bufnr, 'bufhidden', 'delete')
    vim.api.nvim_buf_set_option(M.bufnr, 'buftype', 'nofile')
    vim.api.nvim_buf_set_lines(M.bufnr, 0, -1, false, M.content)
    vim.api.nvim_buf_set_option(M.bufnr, 'modifiable', true)
    local opts = {
        style = "minimal",
        relative = "editor",
        width = 2,
        height = M.height,
        row = vim.api.nvim_get_option("lines") - math.floor(35 / 42 * vim.api.nvim_get_option("lines")),
        col = vim.api.nvim_get_option("columns") - math.floor((vim.api.nvim_get_option("columns")) / 4) - 20,
        border = { "╭", "─", "+", "│", "╯", "─", "╰", "│" },
        focusable = true
    }
    M.win = vim.api.nvim_open_win(M.bufnr, true, opts)
end

M.close = function()
    M.toggled = false
    M.content = { M.tab }
    M.calculate_height()
    vim.api.nvim_win_set_height(M.win, M.height)
    M.win = utils.close_tts(M.win)
    M.bufnr = utils.close_buf(M.bufnr)
end

M.toggle_menu = function(win_)
    vim.api.nvim_win_set_cursor(M.win, {1, 1})
    if M.toggled then
        M.content = { M.tab }
        vim.api.nvim_set_current_win(win_)
        M.toggled = false
    else
        M.content = M.emojis
        vim.api.nvim_set_current_win(M.win)
        M.toggled = true
    end
    M.calculate_height()
    vim.api.nvim_win_set_height(M.win, M.height)
    vim.api.nvim_buf_set_lines(M.bufnr, 0, -1, false, M.content)
end



return M
