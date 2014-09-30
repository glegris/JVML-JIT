function assert(condition, errMsg, level)
    if condition then return condition end
    if type(level) ~= "number" then
        level = 2
    elseif level <= 0 then
        level = 0
    else
        level = level + 1
    end
    error(errMsg or "Assertion failed!", level)
end

local jarCache = {}
local function forEach(fsF, jarFsF)
    for sPath in string.gmatch(jcp, "[^:]+") do
        if sPath:find(".jar$") or sPath:find(".zip$") then
            if not jarCache[sPath] then
                local jarHandle = fs.open(sPath, "rb")
                jarCache[sPath] = zip.open(jarHandle)
            end
            jarFsF(jarCache[sPath])
        else
            fsF(sPath)
        end
    end
end

<<<<<<< HEAD
function resolvePath(name)
    for sPath in string.gmatch(jcp, "[^:]+") do
        local fullPath = fs.combine(sPath, name)
        print("resolvePath("..name..")="..fullPath)
        if fs.exists(fullPath) then
            return fullPath
        end
    end
end
=======
classpath = {}
>>>>>>> upstream/master

function classpath.exists(path)
    local ret = false
    forEach(function(sPath)
        ret = ret or fs.exists(fs.combine(sPath, path))
    end, function(jarFs)
        ret = ret or jarFs.exists(path)
    end)
    return ret
end

function classpath.isDir(path)
    local ret = false
    forEach(function(sPath)
        ret = ret or fs.isDir(fs.combine(sPath, path))
    end, function(jarFs)
        ret = ret or jarFs.isDir(path)
    end)
    return ret
end

function classpath.open(path, mode)
    local ret
    forEach(function(sPath)
        ret = ret or fs.open(fs.combine(sPath, path), mode)
    end, function(jarFs)
        ret = ret or jarFs.open(path, mode)
    end)
    return ret
end

function classpath.list(path)
    local list = {}
    forEach(function(sPath)
        local fullPath = fs.combine(sPath, path)
        if not fs.isDir(fullPath) then return end
        local addList = fs.list(fullPath)
        for i,v in ipairs(addList) do
            table.insert(list, v)
        end
    end, function(jarFs)
        local addList = jarFs.list(path)
        for i,v in ipairs(addList) do
            table.insert(list, v)
        end
<<<<<<< HEAD
    end
    return cls
end

function pushStackTrace(className, methodName, fileName, lineNumber)
    table.insert(stack_trace, {className=className, methodName=methodName, fileName=fileName, lineNumber=lineNumber})
end

function popStackTrace()
    table.remove(stack_trace)
end

function setStackTraceLineNumber(ln)
    stack_trace[#stack_trace].lineNumber = ln
end

function getStackTrace()
    local newTrace = {}
    for i,v in ipairs(stack_trace) do
        newTrace[i] = {className=v.className, methodName=v.methodName, fileName=v.fileName, lineNumber=v.lineNumber}
    end
    return newTrace
end

function printStackTrace(printer)
    local reversedtable = {}
    for i,v in ipairs(stack_trace) do
        reversedtable[#stack_trace - i + 1] = v.className .. "." .. v.methodName .. ":" .. (v.lineNumber or -1)
    end
    (printer or print)(table.concat(reversedtable,"\n"))
end
=======
    end)
    return list
end

function classpath.dofile(path, ...)
    local fh
    forEach(function(sPath)
        fh = fh or assert(fs.open(fs.combine(sPath, path), "r"), "File not found", 2)
    end, function(jarFs)
        fh = fh or assert(jarFs.open(path, "r"), "File not found", 2)
    end)
    local f = assert(loadstring(fh.readAll()))
    setfenv(f, getfenv())
    return f(...)
end
>>>>>>> upstream/master
