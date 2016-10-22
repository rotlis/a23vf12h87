var fs = context.global.fs;
var path = context.global.path;
var firmwareDirPath = context.global.firmwareDirPath;
var firmwareFileType = context.global.firmwareFileType;

var filelist = {};
var fileEncoding = 'utf8';
var getListOfFiles = function (dir) {
    fs.readdirSync(dir).forEach(function (file) {
        var fileWithPath = dir + '/' + file;
        if (fs.statSync(fileWithPath).isDirectory()) {
            filelist = getListOfFiles(fileWithPath);
        } else if (path.extname(fileWithPath) === firmwareFileType) {
            var contents = fs.readFileSync(fileWithPath, fileEncoding, function (err, data) {
                if (err) {
                    return console.log(err);
                }
                return data;
            });
            var fileToPush = {name: file, contents: contents};
            filelist[file] = fileToPush;
        }
    });
    return filelist;
};
msg.payload = getListOfFiles(firmwareDirPath, []);
return msg;