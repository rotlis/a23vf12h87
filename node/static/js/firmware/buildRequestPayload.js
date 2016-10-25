var payload = [];
for (var mac in msg.payload.devices) {
    var device = msg.payload.devices[mac];
    payload.push(
        {
            "deviceIp": device.ip,
            "devicePort": device.port,
            "serverPort": msg.callbackUrl.serverPort,
            "serverHostname": msg.callbackUrl.serverHostname
        }
    );
}
msg.payload = payload;
return msg;