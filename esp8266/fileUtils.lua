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
    --    file.format() vs below removal?
    for fileName, fileSize in pairs(file.list()) do
        print(fileName .. " (" .. fileSize .. " bytes)");
        file.remove(fileName);
    end
end

function FileUtils.overwriteMemoryContents(files)
    self.removeAllFiles();
    for index, fileContentsWithName in pairs(files) do
        self.createFileWithContents(fileContentsWithName.name, fileContentsWithName.contents);
    end
    file.flush();
end

return FileUtils