msg.payload = {
    'url': msg.payload.url,
    'username': msg.payload.username,
    'password': msg.payload.password
};
msg.datapath = '/servers/' + msg.payload.url;
return msg;