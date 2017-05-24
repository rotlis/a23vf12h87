

var projects=[];

for (var i = 0; i < msg.payload.Projects.Project.length; i++) {
    var project = msg.payload.Projects.Project[i];
    var projectName = project.$.name;
    projectName = projectName.substr(projectName.indexOf("::")).trim();
    if (projects.indexOf(projectName)<0){
        projects.push(project.$.name);
    }
}

msg.payload = projects;
return msg;