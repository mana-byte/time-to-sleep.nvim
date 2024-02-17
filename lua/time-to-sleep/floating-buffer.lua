local M = {}

M.content = {
    "This is a floating buffer opened using Lua in Neovim!",
    "You can add any content you want here.",
    "For example, you can display text, lists, or even UI elements.",
    "Have fun experimenting!"
}

-- Create the floating window
M.bufnr = vim.api.nvim_create_buf(false, true)
vim.api.nvim_buf_set_option(M.bufnr, 'bufhidden', 'wipe')
vim.api.nvim_buf_set_lines(M.bufnr, 0, -1, false, M.content)

-- Define the floating window options
M.opts = {
    style = "minimal",
    relative = "editor",
    width = 40,
    height = #M.content + 2,
    row = 10,
    col = 10,
    border = "single",
    focusable = false
}

-- Open the floating window
M.open = function()
    M.win = vim.api.nvim_open_win(M.bufnr, true, M.opts)
end

return M
