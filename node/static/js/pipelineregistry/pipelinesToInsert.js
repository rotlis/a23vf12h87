var payload = msg.payload;
msg.topic = "delete from PipeLines" +
    " where serverId=" + payload.serverId +
    " AND pipeline='" + payload.pipeline + "';" +
    "insert into PipeLines " +
    "(" +
    "serverId," +
    "pipeline," +
    "status," +
    "lastBuildStatus," +
    "lastUpdateAt" +
    ") " +
    "values " +
    "(" +
    payload.serverId + "," +
    "'" + payload.pipeline + "'," +
    "'" + payload.status + "'," +
    "'" + payload.lastBuildStatus + "'," +
    "now()" +
    ")";