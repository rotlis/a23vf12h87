var payload = msg.payload;
msg.topic = "delete from Devices" +
    " where mac='" + payload.mac + "';" +
    "insert into Devices " +
    "(" +
    "patternId," +
    "pipelineId," +
    "mac," +
    "brightness," +
    "firmware," +
    "lastMessage," +
    "lastSeen," +
    "lastUpdateAt" +
    ") " +
    "values " +
    "(" +
    payload.patternId + "," +
    payload.pipelineId + "," +
    "'" + payload.mac + "'," +
    "'" + payload.brightness + "'," +
    "'" + payload.firmware + "'," +
    "'" + payload.lastMessage + "'," +
    "now()," +
    "now()" //TODO firmware update time
    + ")";