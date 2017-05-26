var nullOrValue = function (obj) {
    return (obj === null || obj === undefined) ? null : obj;
};
var nullOrValueWithQuotes = function (obj) {
    return (obj === null || obj === undefined) ? null : "'" + obj + "'";
};

var payload = msg.payload;
msg.topic = "update Devices " +
    "set " +
    "patternId=" + nullOrValue(payload.patternId) + "," +
    "pipelineId=" + nullOrValue(payload.pipelineId) + "," +
    "brightness=" + nullOrValueWithQuotes(payload.brightness) +
    " where mac='" + payload.mac + "';";
return msg;