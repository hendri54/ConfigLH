# Info about computers code is supposed to run on
#=
Assumes that all computers only differ in a single base dir, such as '/Users/lutz'
=#
@enum Computer ComputerLocal = 1 ComputerLongleaf = 2

const localBaseDir = "/Users/lutz"
const longleafBaseDir = "/nas/longleaf"


# Computer we are running on
function current_computer()
    if isdir(localBaseDir)
        return ComputerLocal
    elseif isdir(longleafBaseDir)
        return ComputerLongleaf
    else
        error("Invalid computer")
    end
end


# Are we on the local computer?
function running_local()
    ci = computer_info()
    return ci.runLocal
end


# Container for info about computers that code may run on
mutable struct ComputerInfo
    compId  ::  Computer
    compName :: String
    runLocal  ::  Bool
    # Base directory that everything hangs off
    # Local: user home dir. Remote: prepend .../lhendri/
    baseDir :: String

    # Incomplete initialization is OK
    ComputerInfo(compId) = new(compId)
end
#

# Settings for each computer are collected here
function computer_info(compId  ::  Computer)
    cS = ComputerInfo(compId)
    cS.runLocal = false

    if compId == ComputerLocal
        cS.compName = "Local"
        cS.baseDir = localBaseDir;
        cS.runLocal = true
    elseif compId == ComputerLongleaf
        cS.compName = "Longleaf"
        cS.baseDir = longleafBaseDir;
    else
        error("invalid")
    end

    return cS
end

function computer_info()
    return computer_info(current_computer())
end


function docu_dir(compId :: Computer)
    ci = computer_info(compId)
    return joinpath(ci.baseDir, "Documents")
end

function docu_dir()
    comp = current_computer()
    return docu_dir(comp)
end


## Dirs hanging off Documents (at least on local)

# Repos live here
function julia_dir(compId :: Computer)
	ci = computer_info(compId);
	if ci.runLocal
	    return joinpath(docu_dir(compId), "julia")
	else
	    return joinpath(homedir(), "julia")
	end
end

function julia_dir()
    comp = current_computer()
    return julia_dir(comp)
end

function project_dir(year1)
    joinpath(docu_dir(), "projects", "p$year1");
end


## Dirs hanging off Julia

function shared_dir(compId :: Computer)
    return joinpath(julia_dir(compId), "shared")
end

function shared_dir()
    comp = current_computer()
    return shared_dir(comp)
end

function test_dir()
    return joinpath(julia_dir(), "test_files")
end
