CREATE TABLE CiServerTypes (
  id int(11) NOT NULL AUTO_INCREMENT,
  serverType VARCHAR(20),
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE CiServers (
  id int(11) NOT NULL AUTO_INCREMENT,
  serverTypeId int(11) NOT NULL,
  username VARCHAR(20) NOT NULL,
  password VARCHAR(20) NOT NULL,
  cctrayUrl VARCHAR(20) NOT NULL,
  PRIMARY KEY (id, cctrayUrl),
  FOREIGN KEY (serverTypeId) REFERENCES CiServerTypes(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE PipeLines (
  id int(11) NOT NULL AUTO_INCREMENT,
  serverId int(11) NOT NULL,
  pipeline VARCHAR(20) NOT NULL,
  status VARCHAR(20) NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (serverId) REFERENCES CiServers(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE Patterns (
  id int(11) NOT NULL AUTO_INCREMENT,
  pattern VARCHAR(20) NOT NULL,
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE Devices (
  id int(11) NOT NULL AUTO_INCREMENT,
  patternId int(11),
  pipelineId int(11) NOT NULL,
  mac VARCHAR(20) NOT NULL,
  brightness VARCHAR(20),
  firmware VARCHAR(20),
  lastMessage VARCHAR(20),
  lastSeen DATE,
  lastUpdateAt DATE,
  PRIMARY KEY (id),
  FOREIGN KEY (patternId) REFERENCES Patterns(id),
  FOREIGN KEY (pipelineId) REFERENCES PipeLines(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;