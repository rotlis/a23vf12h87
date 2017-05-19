msg.topic="delete from CiServers where cctrayUrl='"+msg.payload.cctrayUrl+"'; " +
    "insert into CiServers " +
    "(serverTypeId,username,password,cctrayUrl) " +
    "values " +
    "("+
    msg.payload.serverTypeId+"," +
    "'"+msg.payload.username+"'," +
    "'"+msg.payload.password+"'," +
    "'"+msg.payload.cctrayUrl+"'"+
    ")";


