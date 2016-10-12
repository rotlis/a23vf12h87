local FileUtils = {};
local uploadedFiles = {};
local tmpFileNamePostfix = "_newly_uploaded";

function FileUtils.createFileWithContents(fileName, fileContents)
    local tmpFileName = fileName .. tmpFileNamePostfix;
    if file.open(tmpFileName, "w") then
        file.write(fileContents);
        file.close();
        table.insert(uploadedFiles, tmpFileName);
        print("Uploaded file " .. fileName)
        return true
    else
        print("Unable to open/write file: " .. fileName);
        return false
    end
end

function FileUtils.removeFiles(filesToRemove)
    for fileName, fileSize in pairs(filesToRemove) do
        print(fileName .. " (" .. fileSize .. " bytes)");
        file.remove(fileName);
    end
end

function FileUtils.renameFiles(filesToRename)
    for fileName, fileSize in pairs(filesToRename) do
        file.rename(fileName, string.gsub(fileName, tmpFileNamePostfix, ""));
    end
end

function FileUtils.overwriteMemoryContents(files)
    if (#files < 1) then
        print("No files have been provided to overwrite the memory with")
        return false;
    end

    local isSuccess = true;
    local oldFiles = file.list();
    for index, fileContentsWithName in pairs(files) do
        isSuccess = isSuccess and FileUtils.createFileWithContents(fileContentsWithName.name, fileContentsWithName.contents);
        if (isSuccess ~= true) then
            break;
        end
    end
    if (isSuccess) then
        FileUtils.removeFiles(oldFiles);
        FileUtils.renameFiles(uploadedFiles);
    else
        FileUtils.removeFiles(uploadedFiles);
    end
    print("Upgrade successful " .. tostring(isSuccess))
    return isSuccess;
end

return FileUtils;