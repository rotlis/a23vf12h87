local M = {};
local patterns = require("patterns");

function M.colorified(buildStatus, pattern, pixels)
    local maxBright = 255;
    local colorChar = string.char(0, 0, 0);
    local lowerCasedBuildStatus = string.lower(buildStatus);
    if lowerCasedBuildStatus == "successful" then
        colorChar = string.char(maxBright, 0, 0);
    elseif lowerCasedBuildStatus == "failed" then
        colorChar = string.char(0, maxBright, 0);
    elseif lowerCasedBuildStatus == "inprogress" then
        colorChar = string.char(0, 0, maxBright);
    end
    patterns.apply(pattern, colorChar, pixels)
end

function M.rainbow()
    ws2812.init();
    local bu = ws2812.newBuffer(15, 3);
    bu:fill(0, 0, 0);

    local Violet = { 0, 148, 211 };
    local Indigo = { 0, 75, 130 };
    local Blue = { 0, 0, 255 };
    local Green = { 255, 0, 0 };
    local Yellow = { 255, 255, 0 };
    local Orange = { 127, 255, 0 };
    local Red = { 0, 255, 0 };

    bu:set(1, Red);
    bu:set(2, Orange);
    bu:set(3, Yellow);
    bu:set(4, Green);
    bu:set(5, Blue);
    bu:set(6, Indigo);
    bu:set(7, Violet);

    tmr.alarm(0, 50, 1, function()
        bu:shift(1, ws2812.SHIFT_CIRCULAR)
        ws2812.write(bu)
    end);
end

return M;

