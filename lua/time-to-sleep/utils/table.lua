local M = {}

M.getIndex =function(array, value)
    for i, v in ipairs(array) do
        if v == value then
            return i  -- Return the index of the value
        end
    end
    return nil  -- Return nil if the value is not found in the array
end
return M
