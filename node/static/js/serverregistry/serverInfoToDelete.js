var payload = msg.payload;
msg.topic =
    "update Devices set " +
    "pipelineId=NULL " +
    "where pipelineId in (select id from PipeLines where serverId="+payload.id+"); "+

    "delete from PipeLines where serverId="+payload.id+"; "+
    "delete from CiServers where id=" + payload.id + ";";
return msg;