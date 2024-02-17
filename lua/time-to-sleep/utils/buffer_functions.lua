local M = {}

M.close_tts = function(win_)
    if win_ then
        if not pcall(function() vim.api.nvim_win_close(win_, true) end) then
            print("No tts window to close")
        end
        win_ = nil
    end
end
return M
