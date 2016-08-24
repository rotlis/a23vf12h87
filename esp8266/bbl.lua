local strip = require("strip")

function init_udp()
    udpconnection = net.createConnection(net.UDP)
    udpconnection:on("receive", function(udpconnection, message)
        print("UDP in: "..message)
        strip.colorified(message)
    end)
    udpconnection:connect(9001, "255.255.255.255")
end

function beaconcycle()
    local msgText = EspId..":{'v':'0.1alpha'}"
    print(msgText)
    udpconnection:send(msgText)
end

EspId = string.gsub(wifi.sta.getmac(),':','')
print('EspId: ',EspId)

init_udp()

tmr.alarm(2, 5000, 1, beaconcycle)
