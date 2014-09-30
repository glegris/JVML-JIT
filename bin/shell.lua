local shell =  {}

fs = require("fs")

function shell.resolve(path)
    return fs.getFullPath(path)
end

function shell.getRunningProgram()
    return "jvml.lua"
end

function shell.run(program, ...)
    command = program
    for i,v in ipairs(arg) do
        command = command.." "..v
    end
    print("command="..command)
    os.execute(command)
end

return shell
