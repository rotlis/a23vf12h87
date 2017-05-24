var pipeline = msg.payload.pipeline;
var payload = msg.serverInfo;
msg.topic = "delete from PipeLines" +
    " where serverId=" + payload.serverId +
    " AND pipeline='" + pipeline + "';" +
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
    "'" + pipeline + "'," +
    "'" + payload.status + "'," +
    "'" + payload.lastBuildStatus + "'," +
    "now()" +
    ")";
return msg;