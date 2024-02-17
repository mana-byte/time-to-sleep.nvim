local M = {}


M.name = function()
    return "Mana"
end

M.night_emotes = {
    "🌙", "🌚", "🌑", "🌒", "🌓", "🌔", "🌕", "🌖", "🌗", "🌘", "🌜", "🌛", "🌝", "🌚", "🌑", "🌒", "🌓", "🌔", "🌕", "🌖", "🌗", "🌘", "🌜",
    "🌛", "🌝", "⭐", "🌟", "💫", "✨", "🌠", "🎇", "🎆", "🌌", "🌃", "🌉", "🌆", "🚀", "🛸"
}
M.highnoon_emotes = {
    "🌞", "🌝", "🌈", "🌄", "🌅", "🌼", "🌻", "🌺", "🌸", "🏵️", "💐", "🌷", "🌹", "🥀", "🌾", "🌿", "🍀", "🍁", "🍂", "🍃", "🌲", "🌳", "🌴",
    "🍔",
    "🍟", "🍕", "🍝", "🍜", "🍲", "🍛", "🍣", "🍤", "🍙", "🍚", "🍘", "🍥", "🍢", "🍡", "🍧", "🍨", "🍦", "🍰", "🎂", "🍮", "🍭", "🍬", "🍫",
    "🍩", "🍪",
}
M.day_emotes = {
    "🌞", "🌝", "🌈", "🌄", "🌅", "🌼", "🌻", "🌺", "🌸", "🏵️", "💐", "🌷", "🌹", "🥀", "🌾", "🌿", "🍀", "🍁", "🍂", "🍃", "🌲", "🌳", "🌴",
    "🌵", "🌱", "🌿", "☘️", "🍀", "🎍", "🎋", "🍃", "🍂", "🍁", "🍄", "🌾", "🌺", "🌻", "🌼", "🌷", "🌹", "🥀", "🌸", "💐", "🏵️"
}
M.time_to_sleep = function()
    if tonumber(os.date("%H")) >= 23 or tonumber(os.date("%H")) <= 5 then
        return "🚫🚫🚫🚫🚫🚫 GO TO SLEEP 🚫🚫🚫🚫🚫🚫               "
    else
        if tonumber(os.date("%H")) >= 20 or tonumber(os.date("%H")) <= 5 then
            return M.night_emotes[math.random(1, #M.night_emotes)] .. " Day is over, don't forget to sleep!"
        else
            if tonumber(os.date("%H")) >= 14 and tonumber(os.date("%H")) <= 11 then
                return M.highnoon_emotes[math.random(1, #M.highnoon_emotes)] .. " It is a good day! don't forget to eat !"
            end
            return M.day_emotes[math.random(1, #M.day_emotes)] .. " Today is a great day, so Have a nice day!"
        end
    end
end

return M
