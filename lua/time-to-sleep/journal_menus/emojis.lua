local tab = require("time-to-sleep.journal_menus.tabs")

local M = tab:new()

M.tab_content = {
    "😊", "😀", "😅", "😂", "🤣", "😉", "😍", "😘", "😜", "😎",
    "😇", "🥰", "🤩", "😋", "😆", "😁", "😄", "😃", "😚", "😙",
    "👍", "👌", "👏", "🙌", "🤝", "🎉", "🎊", "🌟", "🌈", "🎈",
    "🎁", "🎀", "🥳", "🍾", "🎶", "🎵", "🍀", "🌺", "🌸",
    "✏️", "📝", "📖", "📚", "📔", "📓", "📒", "📕", "📗", "📘",
    "📙", "📚", "📖", "📜", "📄", "📃", "📑", "📊", "📈", "📉",
}
M.tab = require("time-to-sleep.config").mappings.journal.toggle_emojis .. 'm'
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
    local opts = {
        style = "minimal",
        relative = "editor",
        width = #self.tab,
        height = self.height,
        row = vim.api.nvim_get_option("lines") - math.floor(35 / 42 * vim.api.nvim_get_option("lines")),
        col = vim.api.nvim_get_option("columns") - math.floor((vim.api.nvim_get_option("columns")) / 4) - 20,
        border = { "╭", "─", "+", "│", "╯", "─", "╰", "│" },
        focusable = true
    }
    self.win = vim.api.nvim_open_win(self.bufnr, true, opts)
end

return M
