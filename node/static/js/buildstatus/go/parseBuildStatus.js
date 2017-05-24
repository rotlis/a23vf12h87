var isNull = function (obj) {
    return (obj === null || obj === undefined || obj === "");
};

var getBuildStatus = function (pipelineToMonitor) {
    var buildStatus = "";
    for (var i = 0; i < msg.payload.Projects.Project.length; i++) {
        var project = msg.payload.Projects.Project[i];
        var pipelineName = project.$.name;
        if (pipelineName.indexOf(pipelineToMonitor) === 0) {
            if (project.$.activity === "Building") {
                buildStatus = "inprogress";
                break;
            } else if (project.$.activity === "Sleeping" && project.$.lastBuildStatus === "Failure") {
                buildStatus = "failed";
                break;
            } else {
                buildStatus = "successful";
            }
        }
    }
    return buildStatus;
};

var payload = [];
if (isNull(msg.payload.Projects) || isNull(msg.payload.Projects.Project)) {
    return [];
}
for (var mac in msg.devices) {
    var device = msg.devices[mac];
    var buildStatus = getBuildStatus(device.pipeline);
    payload.push(
        {
            "ip": device.ip,
            "port": device.port,
            "pattern": device.pattern,
            "buildStatus": buildStatus
        }
    );
}

msg.payload = payload;
return msg;