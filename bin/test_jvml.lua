shell = require("shell")

local args = {...}
local jcd = shell.resolve(fs.combine(fs.getDir(shell.getRunningProgram()), ".."))
local program = fs.combine(jcd, "bin/jvml")
local tests = fs.combine(jcd, "tests/build")

shell.run(program, "-cp", tests, "-g", "-d")
local vm = jvml.popVM()

local testsToRun

if #args > 0 then
	testsToRun = args
else
	testsToRun = {}
	for i,v in ipairs(fs.list(tests)) do
		if v:sub(-6) == ".class" and not v:find("^%.") then
			table.insert(testsToRun, v:sub(1,-7))
		end
	end
end

for i,v in ipairs(testsToRun) do
	local ok, err = pcall(function()
		local jArray = vm.newArray(vm.getArrayClass("[Ljava.lang.String;"), 0)
	    local m = vm.findMethod(vm.classByName(v), "main([Ljava/lang/String;)V")
	    if m then
			term.setTextColor(colors.yellow)
			print(v)
			term.setTextColor(colors.white)
			local ret, exc = m[1](jArray)
			if exc then
				vm.findMethod(exc[1], "printStackTrace()V")[1](exc)
			end
			assert(not exc)
			return true
		end
	end)
	if not ok then
    	printError(err)
    	print()
        vm.printStackTrace(printError)
        print()

        term.setTextColor(colors.orange)
        print(v, " Failed")
        term.setTextColor(colors.white)
        return
    elseif err then
    	term.setTextColor(colors.lime)
    	print(v, " Succeded\n")
    	term.setTextColor(colors.white)
    end
    sleep(0)
end
