local Upgrader = {};
local fileUtils = require("fileUtils");

function Upgrader.upgrade(url)
    url = "http://192.168.2.200:1880/firmware";
    http.get(url, nil, processResponse);
end

function processResponse(code, data)
    print("code:" .. code);
    if (code < 0) then
        print("HTTP request to " .. url .. " failed");
    else
        upgradeFirmware(data);
    end
end

function upgradeFirmware(data)
    local isJsonMessage, jsonMsg = pcall(cjson.decode, data);
    if isJsonMessage then
        fileUtils.overwriteMemoryContents(jsonMsg);
        node.restart();
    else
        print("Unable to convert data to JSON: " .. data);
    end
end

return Upgrader