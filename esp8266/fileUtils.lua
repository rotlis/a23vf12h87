local FileUtils = {}

function FileUtils.createFileWithContents(fileName, fileContents)
    if file.open(fileName, "w") then
        file.write(fileContents);
        file.close();
    else
        print("Unable to open/write file: " .. fileName);
    end
end

function FileUtils.removeAllFiles()
    for fileName, fileSize in pairs(file.list()) do
        print(fileName .. " (" .. fileSize .. " bytes)");
        file.remove(fileName);
    end
end

function FileUtils.overwriteMemoryContents(files)
    FileUtils.removeAllFiles();
    for index, fileContentsWithName in pairs(files) do
        FileUtils.createFileWithContents(fileContentsWithName.name, fileContentsWithName.contents);
    end
end

return FileUtils