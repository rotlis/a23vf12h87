msg.topic = msg.payload.mac + "/cmd";
msg.payload = JSON.stringify({
    'command': 'triggerUpgrade',
    'upgradeUrl': 'http://' + msg.payload.serverHostname + ':' + msg.payload.serverPort + '/firmware'
}, null, 0);
return msg;