msg.payload=JSON.stringify({
        "command": "buildStatus",
        "pattern": msg.payload.pattern,
        "brightness": msg.payload.brightness,
        "buildStatus": msg.payload.status
    }, null, 0);

msg.topic="bbl/"+msg.payload.mac;
return msg;