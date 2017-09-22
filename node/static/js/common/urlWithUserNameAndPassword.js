
if(msg.serverInfo.username!=''){
	msg.url=msg.serverInfo.cctrayUrl.replace("://", "://"+
	    msg.serverInfo.username+":"+
	    msg.serverInfo.password+"@"
	);
}else{
	msg.url=msg.serverInfo.cctrayUrl;
}
return msg;
