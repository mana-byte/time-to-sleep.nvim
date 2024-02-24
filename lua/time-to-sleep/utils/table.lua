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
    for key, value in pairs(source) do
        if type(value) == "table" then
            dest[key] = {}
            M.setValues(dest[key], value)
        else
            dest[key] = value
        end
    end
end

return M
