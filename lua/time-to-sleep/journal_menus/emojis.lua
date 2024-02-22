local tab = require("time-to-sleep.journal_menus.tabs")
local config = require("time-to-sleep.config")
local getIndex = require("time-to-sleep.utils.table").getIndex

local M = tab:new()

M.tab_content = {
    "😊", "😀", "😅", "😂", "🤣", "😉", "😍", "😘", "😜", "😎",
    "😇", "🥰", "🤩", "😋", "😆", "😁", "😄", "😃", "😚", "😙",
    "👍", "👌", "👏", "🙌", "🤝", "🎉", "🎊", "🌟", "🌈", "🎈",
    "🎁", "🎀", "🥳", "🍾", "🎶", "🎵", "🍀", "🌺", "🌸",
    "✏️", "📝", "📖", "📚", "📔", "📓", "📒", "📕", "📗", "📘",
    "📙", "📚", "📖", "📜", "📄", "📃", "📑", "📊", "📈", "📉",
}
M.tab = '😄'
M.content = { M.tab }

function M:open_win()
    if self.win ~= nil or self.bufnr ~= nil then
        return
    end
    self.bufnr = vim.api.nvim_create_buf(false, true)

    vim.api.nvim_buf_set_name(self.bufnr, "Emoji menu")

    vim.api.nvim_buf_set_option(self.bufnr, 'bufhidden', 'unload')
    vim.api.nvim_buf_set_option(self.bufnr, 'buftype', 'nofile')
    vim.api.nvim_buf_set_lines(self.bufnr, 0, -1, false, self.content)
    vim.api.nvim_buf_set_option(self.bufnr, 'modifiable', true)
    self.default_opts.width = #self.tab
    self.default_opts.row = vim.api.nvim_get_option("lines") -
    math.floor(config.journal_tabs_spacing[getIndex(config.journal_tabs, "emojis")] / 42 *
    vim.api.nvim_get_option("lines"))
    self.win = vim.api.nvim_open_win(self.bufnr, true, self.default_opts)
end

return M
