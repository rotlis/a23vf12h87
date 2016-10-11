local strip = require("strip")
local upgrader = require("upgrader")


function init_udp()
    udpconnection = net.createConnection(net.UDP)
    udpconnection:on("receive", function(udpconnection, message)
        print("UDP in: "..message)

        local isJsonMessage, jsonMsg = pcall(cjson.decode, message)
        if isJsonMessage and jsonMsg.triggerUpload then
            print("upgradeUrl:"..jsonMsg.upgradeUrl)
            upgrader.upgrade(jsonMsg.upgradeUrl)
        else
            strip.colorified(message)
        end
    end)
    udpconnection:connect(9001, "255.255.255.255")
end

function beaconcycle()
    local msgText = EspId..":{'v':'0.1alpha'}"
    print(msgText)
    udpconnection:send(msgText)
end

strip.rainbow()

EspId = string.gsub(wifi.sta.getmac(),':','')
print('EspId: ',EspId)

init_udp()

beaconcycle()
tmr.alarm(2, 5000, 1, beaconcycle)
