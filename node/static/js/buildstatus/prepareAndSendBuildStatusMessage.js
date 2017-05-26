msg.topic = msg.payload.mac + "/cmd";
msg.payload = JSON.stringify({
    "command": "buildStatus",
    "pattern": msg.payload.pattern,
    "brightness": msg.payload.brightness,
    "buildStatus": msg.payload.status
}, null, 0);

return msg;