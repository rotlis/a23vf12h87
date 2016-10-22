msg.ip = msg.payload.ip;
msg.port = msg.payload.port;

var tickleMessage = {
    'ip': msg.payload.ip,
    'port': msg.payload.port,
    'payload': JSON.stringify({
        "command": "buildStatus",
        "pattern": msg.payload.pattern,
        "buildStatus": msg.payload.buildStatus
    }, null, 0)
};
node.send(tickleMessage);
return null;