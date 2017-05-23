var payload = msg.payload;
msg.topic = "delete from CiServers" +
    " where cctrayUrl='" + payload.cctrayUrl + "';" +
    "insert into CiServers " +
    "(" +
    "serverTypeId," +
    "username," +
    "password," +
    "cctrayUrl" +
    ") " +
    "values " +
    "(" +
    payload.serverTypeId + "," +
    "'" + payload.username + "'," +
    "'" + payload.password + "'," +
    "'" + payload.cctrayUrl + "'" +
    ")";
return msg;