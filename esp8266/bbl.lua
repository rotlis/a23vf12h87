local strip = require("strip")
local upgrader = require("upgrader")
local patterns = require("patterns")
local mqttClient = require("mqtt_client")

local currentStatusLifeExpectancy = 0
local defaultStatusLifeExpectancy = 60 -- seconds
pixels = 8

EspId = string.gsub(wifi.sta.getmac(), ':', '');
print('EspId: ', EspId);
-- TODO: make it dynamic
local MqttBrokerIp = "192.168.2.203"

function init_udp()
    udpconnection = net.createUDPSocket()
    udpconnection:on("receive", processUdpMessage)
    udpconnection:listen(9001)
end

function processUdpMessage(s, data, port, ip)
    print(string.format("received '%s' from %s:%d", data, ip, port))
    if MqttBrokerIp~=ip then
        MqttBrokerIp = ip
        mqttClient.init(MqttBrokerIp, processMqttMessage)
    end
end


function processMqttMessage(client, topic, message)
    print("MQTT topic:" .. topic .. ", message:" .. message)

    local isJsonMessage, jsonMsg = pcall(cjson.decode, message)
    if isJsonMessage then
        local command = jsonMsg.command;
        if command == 'triggerUpgrade' then
            upgrader.upgrade(jsonMsg.upgradeUrl);
        elseif command == 'buildStatus' then
            strip.setState(10)
            strip.setBuildStatus(jsonMsg.buildStatus)
            currentStatusLifeExpectancy = defaultStatusLifeExpectancy
        elseif command == 'getPatterns' then
            mqttClient:send(EspId..'/patterns', cjson.encode(patterns.getAll()))
        elseif command == 'configure' then
            mqttClient:subscribe('pipeline/'..jsonMsg.pipelineId)
            strip.setPattern(jsonMsg.patternId)
            strip.setBrightness(jsonMsg.brightness)
        else
            print("Unknown command: " .. command);
        end
    else
        print("Unable to convert MQTT message to JSON: " .. message);
    end
end

--
tmr.alarm(3, 1000, 1, function()
    currentStatusLifeExpectancy = currentStatusLifeExpectancy - 1
    if currentStatusLifeExpectancy < 0 then
        if state == 10 then
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
wifi.sta.eventMonReg(wifi.STA_GOTIP, function() print("wifi.STA_GOTIP")
    strip.setState(6)
--    init_udp() TODO enable this line and remove the next
    mqttClient.init(MqttBrokerIp, processMqttMessage)
end)

wifi.sta.eventMonStart()
strip.start(pixels)
