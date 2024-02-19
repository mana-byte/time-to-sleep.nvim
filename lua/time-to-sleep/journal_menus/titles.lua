local tab = require("time-to-sleep.journal_menus.tabs")

local M = tab:new()

M.tab_content = {
    "# Journal for " .. string.gsub(tostring(os.date("%x")), '/', '-'),
    "## What i did today",
    "## What i learned today",
    "## What i will do tomorrow",
    "## What i need too add",
    "## Improvements",
    "## Ideas",
    "## Thoughts",
    "## Quotes",
    "## Links",
    "## Resources",
    "## TODO",
    "## Notes",
}
M.tab = require("time-to-sleep.config").mappings.journal.toggle_titles .. 'm'
M.content = { M.tab }

function M:open_win()
    if self.win ~= nil or self.bufnr ~= nil then
        return
    end
    self.bufnr = vim.api.nvim_create_buf(false, true)

    vim.api.nvim_buf_set_name(self.bufnr, "Titles menu")

    vim.api.nvim_buf_set_option(self.bufnr, 'bufhidden', 'unload')
    vim.api.nvim_buf_set_option(self.bufnr, 'filetype', 'markdown')
    vim.api.nvim_buf_set_option(self.bufnr, 'buftype', 'nofile')
    vim.api.nvim_buf_set_lines(self.bufnr, 0, -1, false, self.content)
    vim.api.nvim_buf_set_option(self.bufnr, 'modifiable', true)
    local opts = {
        style = "minimal",
        relative = "editor",
        width = #self.tab,
        height = self.height,
        row = vim.api.nvim_get_option("lines") - math.floor(30 / 42 * vim.api.nvim_get_option("lines")),
        col = vim.api.nvim_get_option("columns") - math.floor((vim.api.nvim_get_option("columns")) / 4) - 20,
        border = { "╭", "─", "+", "│", "╯", "─", "╰", "│" },
        focusable = true
    }
    self.win = vim.api.nvim_open_win(self.bufnr, true, opts)
end
return M
