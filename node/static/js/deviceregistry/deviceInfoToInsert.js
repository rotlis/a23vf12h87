var nullOrValue = function (obj) {
    return (obj === null || obj === undefined) ? null : obj;
};
var nullOrValueWithQuotes = function (obj) {
    return (obj === null || obj === undefined) ? null : "'" + obj + "'";
};

var payload = msg.payload;
msg.topic = "insert into Devices " +
    "(" +
    "patternId," +
    "pipelineId," +
    "mac," +
    "brightness," +
    "firmware," +
    "lastMessage," + // TODO where do I belong?
    "lastSeen," +
    "lastUpdateAt" + // TODO where do I belong?
    ") " +
    "values " +
    "(" +
    nullOrValue(payload.patternId) + "," +
    nullOrValue(payload.pipelineId) + "," +
    "'" + payload.mac + "'," +
    nullOrValueWithQuotes(payload.brightness) + "," +
    nullOrValueWithQuotes(payload.firmware) + "," +
    nullOrValueWithQuotes(payload.lastMessage) + "," +
    "now()," +
    "now()" //TODO firmware update time
    + ")" +
    "ON DUPLICATE KEY UPDATE lastSeen=now(), " +
    "firmware=" + nullOrValueWithQuotes(payload.firmware) + ";";
return msg;