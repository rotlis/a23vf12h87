var projectNames = [];
var projects = [];

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

var getLastBuildStatus = function (pipelineToMonitor) {
    var lastBuildStatus = "successful";
    for (var i = 0; i < msg.payload.Projects.Project.length; i++) {
        var project = msg.payload.Projects.Project[i];
        var pipelineName = project.$.name;
        if (pipelineName.indexOf(pipelineToMonitor) === 0) {
            if (project.$.lastBuildStatus === "Failure") {
                lastBuildStatus = "failed";
                break;
            }
        }
    }
    return lastBuildStatus;
};


for (var i = 0; i < msg.payload.Projects.Project.length; i++) {
    var project = msg.payload.Projects.Project[i];
    var projectName = project.$.name;
    projectName = projectName.substr(0, projectName.indexOf("::")).trim();
    if (projectNames.indexOf(projectName) < 0) {
        projectNames.push(projectName);
    }
}

for (var i = 0; i < projectNames.length; i++) {
    var projectName = projectNames[i];
    var status = getBuildStatus(projectName);
    var lastBuildStatus = getLastBuildStatus(projectName);
    projects.push({
        projectName: projectName,
        status: status,
        lastBuildStatus:lastBuildStatus
    })
}


msg.payload = projects;
return msg;