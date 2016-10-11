FileToExecute="bbl.lua"
l = file.list();
for k,v in pairs(l) do
    if k == FileToExecute then
        print("*** You've got 2 sec to stop timer 0 (e.g. tmr.stop(0))***")
        tmr.alarm(0, 2000, 0, function()
            print("Executing ".. FileToExecute)
            dofile(FileToExecute)
        end)
    end
end
