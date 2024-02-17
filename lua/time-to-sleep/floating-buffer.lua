local M = {}


M.opts = {
    style = "minimal",
    relative = "editor",
    width = 50,
    height = 1,
    row = vim.api.nvim_get_option("lines") - 2,
    col = vim.api.nvim_get_option("columns"),
    border = "none",
    focusable = false
}

-- Create and Open the floating window
M.open = function(content)
    M.bufnr = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_option(M.bufnr, 'bufhidden', 'wipe')
    -- vim.api.nvim_buf_set_option(M.bufnr, 'modifiable', false)
    vim.api.nvim_buf_set_lines(M.bufnr, 0, -1, false, content)


    M.win = vim.api.nvim_open_win(M.bufnr, true, M.opts)
end

return M
