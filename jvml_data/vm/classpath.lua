local class = {}
local stack_trace = {}

function findMethod(c,name)
    if not c then error("class expected, got nil",2) end
    if c.methodLookup[name] then
        return unpack(c.methodLookup[name])
    end
    for i=1, #c.methods do
        if c.methods[i].name == name then
            c.methodLookup[name] = {c.methods[i],i} -- when it's virtual, the index is needed
            return c.methods[i], i
        end
    end
    local mt
    if c.super then
        mt = findMethod(c.super, name)
        if mt then
            c.methodLookup[name] = {mt}
            return mt
        end
    end
    for i=0, c.interfaces_count-1 do
        mt = findMethod(c.interfaces[i], name)
        if mt then
            c.methodLookup[name] = {mt}
            return mt
        end
    end
end

function getObjectField(obj, name)
    return obj[2][obj[1].fieldIndexByName[name]]
end

function setObjectField(obj, name, val)
    obj[2][obj[1].fieldIndexByName[name]] = val
end

function newInstance(class)
    return { class, { }, class.methods }
end

local function implementsInterface(class, interface)
    if class.super and (class.super == interface or implementsInterface(class.super, interface)) then
        return 1
    end
    for i=0, class.interfaces_count-1 do
        local v = class.interfaces[i]
        if v == interface or implementsInterface(v, interface) then
            return 1
        end
    end
    return 0
end

local function _jInstanceof(obj, class)
    if bit.band(class.acc, CLASS_ACC.INTERFACE) == CLASS_ACC.INTERFACE then
        return implementsInterface(obj[1], class)
    else
        local oClass = obj[1]
        while oClass do
            if oClass == class then
                return 1
            end
            oClass = oClass.super
        end
    end
    return 0
end
function jInstanceof(obj, class)
    if not obj then
        return false
    end
    if not obj[1].instanceofCache[class] then
        obj[1].instanceofCache[class] = _jInstanceof(obj, class)
    end
    return obj[1].instanceofCache[class]
end

function resolvePath(name)
    for sPath in string.gmatch(jcp, "[^:]+") do
        local fullPath = fs.combine(sPath, name)
        if fs.exists(fullPath) then
            return fullPath
        end
    end
end

local jClasses = {}
function getJClass(name)
    if not jClasses[name] then
        jClasses[name] = newInstance(classByName("java.lang.Class"))
        setObjectField(jClasses[name], "name", toJString(name))
    end
    return jClasses[name]
end

function classByName(cn)
    local c = class[cn]
    if c then
        return c
    end
    local cd = cn:gsub("%.","/")

    local fullPath = resolvePath(cd..".class")
    if not fullPath then
        error("Cannot find class ".. cn, 0)
    end
    if not loadJavaClass(fullPath) then
        error("Cannot load class " .. cn, 0)
    else
        c = class[cn]
        return c
    end
end

-- TODO: Index numerically only
-- cls = { name, fields, methods, super }
function createClass(super_name, cn)
    local cls = {}
    class[cn] = cls
    cls.name = cn
    cls[1] = cn
    cls.fields = {}
    cls[2] = cls.fields
    cls.methods = {}
    cls[3] = cls.methods
    cls.methodLookup = {}
    cls.instanceofCache = {}
    if super_name then -- we have a custom Object class file which won't have a super
        local super = classByName(super_name)
        cls.super = super
        cls[4] = super
        for i,v in pairs(super.fields) do
            cls.fields[i] = v
            cls[2][i] = v
        end
        for i,v in pairs(super.methods) do
            cls.methods[i] = v
            cls[3][i] = v
        end
    end
    return cls
end

function pushStackTrace(s)
    table.insert(stack_trace, s)
end

function popStackTrace()
    table.remove(stack_trace)
end

function printStackTrace(isError)
    local reversedtable = {}
    for i,v in ipairs(stack_trace) do
        reversedtable[#stack_trace - i + 1] = v
    end
    ((isError and printError) or print)(table.concat(reversedtable,"\n"))
end