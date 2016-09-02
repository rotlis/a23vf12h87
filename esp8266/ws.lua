ws2812.init()

local i , bu =0, ws2812.newBuffer(15, 3);

bu:fill(0, 0, 0);

--tmr.alarm(0, 55, 1, function()
--        i=i+1
--        bu:fade(3, ws2812.FADE_OUT)
--        -- g r b / r g b
--        bu:set((i % 15) + 1, 0, 150, 255)
--        ws2812.write(bu)
--end)



--                 g   r   b

local Violet	={0,   148, 211 }
local Indigo	={0,   75,  130 }
local Blue	=    {0,   0,   255 }
local Green	=    {255, 0,   0   }
local Yellow	={255, 255, 0   }
local Orange	={127, 255, 0   }
local Red	    ={0 ,  255, 0   }


bu:set(1, Red)
bu:set(2, Orange)
bu:set(3, Yellow)
bu:set(4, Green)
bu:set(5, Blue)
bu:set(6, Indigo)
bu:set(7, Violet)

tmr.alarm(0, 50, 1, function()
        bu:shift(1, ws2812.SHIFT_CIRCULAR)
        ws2812.write(bu)
end)