args = { ... }
os.loadAPI("/api/libdir")
libdir.SetWorkingDirectory("/");
function Start()
    term.clear();
    term.setCursorPos(1,1)
    print ("XSH Shell by Daniel Jones (v1.0)");
    while (true) do
        write("[" .. libdir.GetWorkingDirectory() .. "] ");
        command = read();
        
        
        split = {}
        for word in command:gmatch("%S+") do table.insert(split, word) end
        
        --? = Does program exist
        if (#split > 1 and split[1] == "?") then
            print (DoesProgramExist(split[2]));
            
            elseif (#split > 0) then
            if (DoesProgramExist(split[1])) then

                arguments = {};
                --Copy the arguments into a new table
                for i=2,#split do
                    table.insert(arguments, split[i]);
                end
                
                --Execute the program with the arguments
                shell.run("/app/" .. split[1] .. "/" .. split[1], unpack(arguments));
            else
                --Program was not found in /app/, print out an error message to the user.
                print ("Program " .. split[1] .. " does not exist!");
            end
        end
    end
end

function DoesProgramExist(ProgramName)
    return fs.exists("/app/" .. ProgramName .. "/") and fs.exists("/app/" .. ProgramName .. "/" .. ProgramName);
end

Start();