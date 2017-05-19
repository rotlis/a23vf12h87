msg.topic="delete from Devices where mac='"+msg.payload.mac+"'; " +
    "insert into Devices " +
    "(patternId,pipelineId,mac,brightness,firmware,lastMessage,lastSeen,lastUpdateAt) " +
    "values " +
    "("+
    msg.payload.patternId+"," +
    msg.payload.pipelineId+"," +
    "'"+msg.payload.mac+"'," +
    "'"+msg.payload.brightness+"'," +
    "'"+msg.payload.firmware+"'," +
    "'"+msg.payload.lastMessage+"'," +
    "now()," +
    "now()" //TODO firmware update time
    +")";
