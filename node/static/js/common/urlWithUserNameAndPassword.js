msg.serverInfo=msg.payload;
msg.url=msg.payload.cctrayUrl.replace("://", "://"+
    msg.payload.username+":"+
    msg.payload.password+"@"
);
return msg;