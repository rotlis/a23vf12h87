msg.url=msg.serverInfo.cctrayUrl.replace("://", "://"+
    msg.serverInfo.username+":"+
    msg.serverInfo.password+"@"
);
return msg;