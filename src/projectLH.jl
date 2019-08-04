import Base.show
export project_start

const initFile = "init.jl"

"""
## User interface
"""
function project_start(pName  ::  String)
    proj = get_project(pName);
    project_start(proj);
    return proj
end


"""
## Internals
"""
mutable struct Project
    name :: String
    progDir  ::  String
    # additional directories to put on LOAD_PATH. Empty by default.
    dirsOnPath :: Vector{String}
end


function show(proj :: Project)
    println("Project [$(proj.name)]");
    println("\tin: $(proj.progDir)")
end


## Default directories on path
function shared_dirs()
#    outV = ConfigLH.shared_dir();
	return Vector{String}();
end


function project_dir(pYear :: Integer)
    return joinpath(homedir(),  "Documents",  "projects",  "p$pYear")
end


## Development directory, where code should reside for unregistered packages
function dev_dir()
	return ENV["JULIA_PKG_DEVDIR"]
end


"""
Start a project

Keep in mind that this is executed from within a module. This limits changes 
to the environment.
"""
function project_start(proj :: Project)
    println("Starting project $(proj.name)");
    println("Dir:  $(proj.progDir)")
    @assert isdir(proj.progDir)  "Not found: $(proj.progDir)"
#    push!(LOAD_PATH, proj.progDir);
    add_to_path!(proj.dirsOnPath);
    cd(proj.progDir);
    initPath = joinpath(proj.progDir, initFile);
    if isfile(initPath)
        include(initPath);
    end
    return nothing
end

function add_to_path!(newDirV :: Vector{String})
	if !isempty(newDirV)
		for newDir in newDirV
			if !in(newDir, LOAD_PATH)
				push!(LOAD_PATH, newDir);
			end
		end
	end
	return nothing
end


"""
get_project

Project Definitions
Newest at the top
"""
function get_project(pName :: AbstractString)
    if pName == "test"
        progDir = shared_dir();
        proj = Project(pName, progDir, shared_dirs())
	elseif pName in ["ConfigLH", "CommonLH", "ModelParams", "EconLH"]
    	progDir = joinpath(dev_dir(), pName)
    elseif pName == "sampleModel"
        # Code to try out modeling code (setting parameters etc)
        progDir = joinpath(ConfigLH.julia_dir(), "SampleModel")
        proj = Project(pName, progDir, shared_dirs())
    elseif pName == "collegeQuality"
        # Model with college quality (Oksana, Tatyana)
        progDir = joinpath(project_dir(2019), "college_stratification", "CollegeStrat");
        proj = Project(pName, progDir, shared_dirs())
    else
        error("Invalid project $pName")
    end
    return proj
end


# ------------