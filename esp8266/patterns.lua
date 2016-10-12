local M = {};

function M.getAll()
    return {"steady", "scroll"}
end

function M.steady(colorChar, pixels)
    tmr.stop(0)
    ws2812.write(colorChar:rep(pixels))
end

function M.scroll(colorChar, pixels)
    local i, bu = 0, ws2812.newBuffer(pixels, 3);

    tmr.alarm(0, 100, 1, function()
        i = i + 1
        bu:fade(2, ws2812.FADE_OUT)
        bu:set((i % pixels) + 1, colorChar)
        ws2812.write(bu)
    end);
end

function M.apply(pattern, colorChar, pixels)
    ws2812.init();
    if ("steady" == pattern) then
        M.steady(colorChar, pixels)
    elseif ("scroll"==pattern) then
        M.scroll(colorChar, pixels)
    else
        M.steady(colorChar, pixels)
    end
end

return M;

