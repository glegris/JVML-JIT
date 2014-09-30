local fs =  {}


--
-- Remove any leading slash from a pathname.
--
function fs.remove_leading_slash(path)
	if string.sub(path, 1, 1) == "/" then
		return string.sub(path, 2)
	else
		return path
	end
end

--
-- Remove the trailing slash of a pathname, if present.
--
function fs.remove_trailing_slash(path)
	if string.sub(path, -1) == "/" then
		return string.sub(path, 1, string.len(path) - 1)
	else
		return path
	end
end

function fs.combine(a,b)
   return a.."/"..b
end

function fs.exists(name)
    local f = io.open(name,"r")
    if f~=nil then io.close(f) return true else return false end
end

function fs.execute(cmd)
    f = assert (io.popen (cmd))
    for line in f:lines() do
        f:close()
        return line
    end -- for loop
            
  --  f:close()
end

function fs.getDir(path)
    dirName = fs.execute("dirname "..path)
    --print("dirName="..dirName)
    fullDirPath = fs.execute("cd "..dirName.." && pwd")
    print("fs.getDir("..path..")="..fullDirPath)
    --return fs.remove_leading_slash(fullDirPath)
    return fullDirPath
--    return fullDirPath
end

function fs.getFullPath(path)
    baseName = fs.execute("basename "..path)
    fullDirPath = fs.getDir(path);
    if string.sub(path, 1, 1) == "/" then
        return fullDirPath.."/"..baseName
    else
        return "/"..fullDirPath.."/"..baseName
    end
end

function fs.getName(path)
    return fs.execute("basename "..path)
end

function fs.list(dirname)
        callit = os.tmpname()
        os.execute("ls -a1 "..dirname .. " >"..callit)
        f = io.open(callit,"r")
        rv = f:read("*all")
        f:close()
        os.remove(callit)

        tabby = {}
        local from = 1
        local delim_from, delim_to = string.find( rv, "\n", from )
        while delim_from do
                table.insert( tabby, string.sub( rv, from , delim_from-1 ) )
                from = delim_to + 1
                delim_from, delim_to = string.find( rv, "\n", from )
                end
        -- table.insert( tabby, string.sub( rv, from ) )
        -- Comment out eliminates blank line on end!
        return tabby
end

function fs.open(path, mode)
	local f = io.open(path, mode)
	
    local handle = {}
	function handle.readAll()
    	local content = f:read("*all")
		return content
	end
    function handle.read()
        local r = f:read(1)
        --print(byte)
        --print("handle.read(): "..string.char(byte))
        return string.byte(r)
    end
    function handle.close()
        f:close()    
    end
    
    return handle
end

return fs
