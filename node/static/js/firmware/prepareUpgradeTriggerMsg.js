msg.ip = msg.payload.deviceIp;
msg.port = msg.payload.devicePort;
msg.payload = JSON.stringify({
    'command': 'triggerUpgrade',
    'upgradeUrl': 'http://' + msg.payload.serverHostname + ':' + msg.payload.serverPort + '/firmware'
}, null, 0);
return msg;