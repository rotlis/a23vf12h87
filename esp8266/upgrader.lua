local Upgrader = {};
local fileUtils = require("fileUtils");

function Upgrader.upgrade(url)
    url = "http://192.168.2.200:1880/firmware";
    local headers = { "Authorization: Basic " .. encoder.toBase64("admin:admin") };
    print(headers);
    http.get(url, headers, processResponse);
end

local function processResponse(code, data)
    print("code:" .. code);
    if (code < 0) then
        print("HTTP request to " .. url .. " failed");
    else
        upgradeFirmware(data);
    end
end

local function upgradeFirmware(data)
    local isJsonMessage, jsonMsg = pcall(cjson.decode, data);
    if isJsonMessage then
        fileUtils.overwriteMemoryContents(jsonMsg);
        dofile("bbl.lua");
        -- do I need to restart?
    else
        print("Unable to convert data to JSON: " .. data);
    end
end

return Upgrader