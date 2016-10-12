local FileUtils = {}

function FileUtils.createFileWithContents(fileName, fileContents)
    if file.open(fileName, "w") then
        file.write(fileContents);
        file.close();
        print("Uploaded file "..fileName)
        return true
    else
        print("Unable to open/write file: " .. fileName);
        return false
    end
end

function FileUtils.removeAllFiles()
    for fileName, fileSize in pairs(file.list()) do
        print(fileName .. " (" .. fileSize .. " bytes)");
        file.remove(fileName);
    end
end

function FileUtils.overwriteMemoryContents(files)
    local isSuccess = true
    FileUtils.removeAllFiles();
    for index, fileContentsWithName in pairs(files) do
        isSuccess = isSuccess and FileUtils.createFileWithContents(fileContentsWithName.name, fileContentsWithName.contents);
    end
    print("Upgrade successful "..tostring(isSuccess))
    return isSuccess
end

return FileUtils