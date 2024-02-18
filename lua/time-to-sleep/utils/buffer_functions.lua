local M = {}

M.close_tts = function(win_)
    if win_ then
        if not pcall(function() vim.api.nvim_win_close(win_, true) end) then
            print("No tts window to close")
        end
    end
    return nil
end

M.close_buf = function(bufnr)
    pcall(vim.api.nvim_buf_delete, bufnr, { force = true })
    return nil
end

M.is_buffer_displayed = function(bufnr)
    if bufnr == nil then
        return false
    end
    for _, winid in ipairs(vim.api.nvim_list_wins()) do
        if vim.api.nvim_win_get_buf(winid) == bufnr then
            return true
        end
    end
    return false
end
return M
