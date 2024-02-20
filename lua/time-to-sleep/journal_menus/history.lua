local tab = require("time-to-sleep.journal_menus.tabs")

local function splitString(inputString, separator)
    local result = {}
    for substring in inputString:gmatch("[^" .. separator .. "]+") do
        table.insert(result, substring)
    end
    return result
end
local function isInTable(tbl, item)
    for _, value in pairs(tbl) do
        if value == item then
            return true
        end
    end
    return false
end

local function isEveryDayInTable(tbl, super_tbl)
    local not_in_table = {}
    for _, value in pairs(tbl) do
        if not isInTable(super_tbl, value) then
            table.insert(not_in_table, value)
        end
    end
    if #not_in_table == 1 then
        return not_in_table[1]
    end
end

local function getRecentJournals()
    local recent_journals = {}
    local separated_date = splitString(os.date("%x"), '/')
    local max_days = 20
    local days = 0
    for i = 1, 10 do
        days = days + 1
        if days > max_days then
            break
        end
        separated_date[1] = separated_date[1] - 1
        local date = separated_date[1] .. '-' .. separated_date[2] .. '-' .. separated_date[3]
        local file = io.open("journals/" .. date .. ".md", "r")
        if file ~= nil then
            table.insert(recent_journals, date)
            file:close()
        else
            i = i - 1
        end
    end
    return recent_journals
end

local M = tab:new()

M.tab_content = getRecentJournals()
M.tab = require("time-to-sleep.config").mappings.journal.toggle_history .. 'm'
M.content = { M.tab }
function M:open_win()
    if self.win ~= nil or self.bufnr ~= nil then
        return
    end
    self.bufnr = vim.api.nvim_create_buf(false, true)

    vim.api.nvim_buf_set_name(self.bufnr, "History menu")

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
        row = vim.api.nvim_get_option("lines") - math.floor(26 / 42 * vim.api.nvim_get_option("lines")),
        col = vim.api.nvim_get_option("columns") - math.floor((vim.api.nvim_get_option("columns")) / 4) - 20,
        border = { "╭", "─", "+", "│", "╯", "─", "╰", "│" },
        focusable = true
    }
    self.win = vim.api.nvim_open_win(self.bufnr, true, opts)
end

function M:onToggle(journal)
    print("toggle")
    -- if not self.toggle then
    --     local sucess, lines = pcall(vim.api.nvim_buf_get_lines, self.bufnr, 0, -1, false)
    --     if not sucess then
    --         print("Failed to read buffer lines", lines)
    --         return
    --     end
    --     local day = isEveryDayInTable(lines, self.tab_content)
    --     print(day)
    --     if day then
    --         journal.open_specific_journal(day)
    --     end
    -- end
end

return M