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

-- Create and Open the floating window
M.open = function(content)
    M.bufnr = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_option(M.bufnr, 'bufhidden', 'delete')
    local opts = {
        style = "minimal",
        relative = "editor",
        width = maxStringLength(content),
        height = #content,
        row = vim.api.nvim_get_option("lines") - 2,
        col = vim.api.nvim_get_option("columns"),
        border = "none",
        focusable = false
    }
    vim.api.nvim_buf_set_lines(M.bufnr, 0, -1, false, content)
    local win =vim.api.nvim_open_win(M.bufnr, true, opts)

    return win
end

return M
