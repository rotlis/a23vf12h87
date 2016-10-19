local M = {};
local patterns = require("patterns");
colorChar = string.char(0, 0, 0);
maxBright = 100
state = 0
tickCounter = 0
bu = nil

function M.setState(s)
    state = s
    if s == 10 then
        colorChar = string.char(0, 0, 0)
    else

    end
end

function M.setBuildStatus(buildStatus)
    local lowerCasedBuildStatus = string.lower(buildStatus);
    if lowerCasedBuildStatus == "successful" then
        colorChar = string.char(maxBright, 0, 0);
    elseif lowerCasedBuildStatus == "failed" then
        colorChar = string.char(0, maxBright, 0);
    elseif lowerCasedBuildStatus == "inprogress" then
        colorChar = string.char(0, 0, maxBright);
    end
end

function M.setPattern(p)

end

function M.onTick()
    tickCounter = tickCounter+1
    if (state==10) then
        bu:set(1, colorChar)
        bu:shift(1, ws2812.SHIFT_CIRCULAR)
    else
        bu:fill(0, 0, 0)
        print("state:"..state)
        bu:set(state+1, string.char(maxBright, maxBright, maxBright))
    end
    ws2812.write(bu)
end

function M.start(pix)
    pixels = pix
    bu = ws2812.newBuffer(pixels, 3)
    ws2812.init()
    bu:fill(0, 0, 0)
    ws2812.write(bu)

    tmr.alarm(0, 50, 1, M.onTick);
end

return M;

