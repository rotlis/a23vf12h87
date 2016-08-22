local M = {}

function M.colorified(color)
    local stripPin = 2 -- Comment: GPIO4
    local maxBright = 50
    local color_code = string.lower(color)
    local colorChar = string.char(0, 0, 0)
    if color_code == "red" then
        colorChar = string.char(maxBright, 0, 0)
    elseif color_code == "green" then
        colorChar = string.char(0, maxBright, 0)
    elseif color_code == "blue" then
        colorChar = string.char(0, 0, maxBright)
    end
    ws2812.writergb(stripPin, colorChar:rep(10))
end

return M

