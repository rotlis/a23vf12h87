msg.topic="delete from PipeLines where serverId="+msg.payload.serverId+" AND pipeline='"+msg.payload.pipeline+"'; " +
    "insert into PipeLines " +
    "(serverId,pipeline,status,lastBuildStatus,lastUpdateAt) " +
    "values " +
    "("+
    msg.payload.serverId+"," +
    "'"+msg.payload.pipeline+"'," +
    "'"+msg.payload.status+"'," +
    "'"+msg.payload.lastBuildStatus+"'," +
    "now()"+
    ")";

