local Upgrader = {};
local fileUtils = require("fileUtils");
local username = "admin";
local password = "password";

function Upgrader.upgrade(url)
    url = "http://192.168.2.200:1880/firmware";
    local ip, port, path = string.gmatch(url, 'http://([0-9.]+):?([0-9]*)(/.*)')()
    local connection = net.createConnection(net.TCP, false)
    connection:connect(port, ip)
    connection:on('connection', send)
    connection:on('receive', processResponse)
    connection:on('disconnection', processDisconnection)
end

function send(connection)
    connection:send("GET " .. path .. " HTTP/1.0\r\n" ..
            "Host: " .. ip .. "\r\n" ..
            "Connection: close\r\n" ..
            "Accept-Encoding: \r\n" ..
            "Accept-Charset: utf-8\r\n" ..
            "Authorization: Basic " .. encoder.toBase64(username .. ":" .. password) .. "\r\n" ..
            "Accept: */*\r\n\r\n")
end

function processResponse(code, data)
    print("code:" .. code);
    if (code < 0) then
        print("HTTP request to " .. url .. " failed");
    else
        upgradeFirmware(data);
    end
end

function processDisconnection(connection, response)
    -- TODO implement properly
    print(connection)
    print(response)
end

function upgradeFirmware(data)
    local isJsonMessage, jsonMsg = pcall(cjson.decode, data);
    if isJsonMessage then
        local isFirmwareUpgraded = fileUtils.overwriteMemoryContents(jsonMsg);
        if (isFirmwareUpgraded) then
            node.restart();
        end
    else
        print("Unable to convert data to JSON: " .. data);
    end
end

return Upgrader;