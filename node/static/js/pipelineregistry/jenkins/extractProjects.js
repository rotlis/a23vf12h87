var projectNames = [];
var projects = [];

var getBuildStatus = function (color) {
	if("blue"==color){
		return "inprogress";
	}else if("red"==color){
		return "successful";
	}else if("green"==color){
		return "failed";
	}else {
		return "failed";
	}
};

for (var i = 0; i < msg.payload.workflowMultiBranchProject.job.length; i++) {
    var job = msg.payload.workflowMultiBranchProject.job[i];
    var projectName = job.name;
    var buildStatus = getBuildStatus(job.color);	
  
    projects.push({
        projectName: projectName,
        status: buildStatus,
        lastBuildStatus:buildStatus
    })
}

msg.payload = projects;
return msg;
