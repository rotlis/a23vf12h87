local strip = require("strip")
local upgrader = require("upgrader")
local patterns = require("patterns")
local udpconnection

local currentStatusLifeExpectancy = 0
local defaultStatusLifeExpectancy = 60 -- seconds
pixels = 8

local function init_udp()
    udpconnection = net.createConnection(net.UDP)
    udpconnection:on("receive", processUdpMessage)
    udpconnection:connect(9001, "255.255.255.255")
end

function processUdpMessage(udpconnection, message)
    print("UDP in: " .. message)

    local isJsonMessage, jsonMsg = pcall(cjson.decode, message)
    if isJsonMessage then
        local command = jsonMsg.command;
        if command == 'triggerUpgrade' then
            upgrader.upgrade(jsonMsg.upgradeUrl);
        elseif command == 'buildStatus' then
            strip.setState(10)
            strip.setBuildStatus(jsonMsg.buildStatus)
            strip.setPattern(jsonMsg.pattern)
            currentStatusLifeExpectancy = defaultStatusLifeExpectancy
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

strip.start(pixels)

--
tmr.alarm(3, 1000, 1, function()
    currentStatusLifeExpectancy = currentStatusLifeExpectancy - 1
    if currentStatusLifeExpectancy < 0 then
        if state==10 then
            print("state timeout elapsed")
            strip.setState(6)
        end
    end
end)

connectionState = 0

wifi.sleeptype(wifi.NONE_SLEEP)
wifi.setphymode(wifi.PHYMODE_G)
wifi.setmode(wifi.STATION)

wifi.sta.connect()

wifi.sta.eventMonReg(wifi.STA_IDLE, function() print("wifi.STA_IDLE") strip.setState(1) end)
wifi.sta.eventMonReg(wifi.STA_CONNECTING, function() print("wifi.STA_CONNECTING") strip.setState(2) end)
wifi.sta.eventMonReg(wifi.STA_WRONGPWD, function() print("wifi.STA_WRONGPWD") strip.setState(3) end)
wifi.sta.eventMonReg(wifi.STA_APNOTFOUND, function() print("wifi.STA_APNOTFOUND") strip.setState(4) end)
wifi.sta.eventMonReg(wifi.STA_FAIL, function() print("wifi.STA_FAIL") strip.setState(5) end)
wifi.sta.eventMonReg(wifi.STA_GOTIP, function()
    print("wifi.STA_GOTIP")
    strip.setState(6)
    init_udp()
    beaconcycle()
    tmr.alarm(2, 5000, 1, beaconcycle)
end)

wifi.sta.eventMonStart()

