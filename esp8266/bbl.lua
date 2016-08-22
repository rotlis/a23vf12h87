local strip = require("strip")

function init_udp()
    udpconnection = net.createConnection(net.UDP)
    udpconnection:on("receive", function(udpconnection, message)
        print("UDP: "..message)
        strip.colorified(message)
    end)
    udpconnection:connect(9001, "255.255.255.255")
end

function beaconcycle()
    print("UDP out")
    udpconnection:send(EspId)
end

--local ips = wifi.sta.getip()
--if ips ~= nil then
--    local ip = string.sub(ips, string.find(ips, "([^ ]+)"))
--    print(ip)
--end
EspId = string.gsub(wifi.sta.getmac(),':','')
print('====> EspId: ',EspId)

init_udp()

tmr.alarm(2, 3000, 1, beaconcycle)
