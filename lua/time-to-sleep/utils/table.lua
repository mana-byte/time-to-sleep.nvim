local M = {}

M.getIndex = function(array, value)
    for i, v in ipairs(array) do
        if v == value then
            return i
        end
    end
    return nil
end

M.setValues = function(dest, source)
    if source == nil then
        return
    end
    for key, value in pairs(source) do
        if type(value) == "table" then
            dest[key] = {}
            M.setValues(dest[key], value)
        else
            dest[key] = value
        end
    end
end

M.mergeValues = function(dest, source)
    for key, value in pairs(source) do
        if type(value) == "table" then
            -- If the value is a table, recursively call mergeValues
            if type(dest[key]) ~= "table" then
                dest[key] = {}
            end
            M.mergeValues(dest[key], value)
        else
            -- If the key already exists in the destination table, do not overwrite it
            if dest[key] == nil then
                dest[key] = value
            end
        end
    end
end

M.appendTable = function(dest, source)
    for _, value in ipairs(source) do
        table.insert(dest, value)
    end
    return dest
end

M.add_table = function(target_table, source_table)
    for key, value in pairs(source_table) do
        target_table[key] = value
    end
end

M.printTable = function(tbl, indent)
    indent = indent or 0
    for k, v in pairs(tbl) do
        if type(v) == "table" then
            print(string.rep(" ", indent) .. tostring(k) .. " (table):")
            M.printTable(v, indent + 2)
        else
            print(string.rep(" ", indent) .. tostring(k) .. ": " .. tostring(v))
        end
    end
end

return M
