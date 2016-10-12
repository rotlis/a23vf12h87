local strip = require("strip");
local upgrader = require("upgrader");
local patterns = require("patterns");
local udpconnection;

local function init_udp()
    udpconnection = net.createConnection(net.UDP);
    udpconnection:on("receive", processUdpMessage);
    udpconnection:connect(9001, "255.255.255.255");
end

function processUdpMessage(udpconnection, message)
    print("UDP in: " .. message)

    local isJsonMessage, jsonMsg = pcall(cjson.decode, message)
    if isJsonMessage then
        local command = jsonMsg.command;
        if command == 'triggerUpgrade' then
            upgrader.upgrade(jsonMsg.upgradeUrl);
        elseif command == 'buildStatus' then
            strip.colorified(jsonMsg.buildStatus, jsonMsg.pattern, 8);
        elseif command == 'getPatterns' then
            udpconnection:send(cjson.encode(patterns.getAll()))
        else
            print("Unknown command: " .. command);
        end
    else
        print("Unable to convert UDP message to JSON: " .. message);
    end
end

function beaconcycle()
    local msgText = EspId .. ":{'v':'0.1alpha'}"
    print(msgText)
    udpconnection:send(msgText)
end

EspId = string.gsub(wifi.sta.getmac(), ':', '');
print('EspId: ', EspId);

strip.rainbow();
init_udp();
beaconcycle();
tmr.alarm(2, 5000, 1, beaconcycle);
