module ConfigLH

using Pkg, Printf

export add_to_path!, remove_from_path!, shared_dir, test_dir

include("computer.jl")


## --------- Github related

# Paths to my unregistered packages
const githubUrl = "https://github.com/hendri54/";

"""
get_pkg_spec

Make a `PackageSpec` for one of my packages
"""
function get_pkg_spec(pkgName :: String)
    return PackageSpec(name = pkgName,  url = githubUrl * pkgName);
end

"""
add_package

Apply `Pkg.add` for one of my packages
"""
function add_package(pkgName :: String)
    Pkg.add(get_pkg_spec(pkgName))
end


"""
add_to_path!

Add a directory to the LOAD_PATH without duplication
"""
function add_to_path!(newDir :: String)
	if !in(newDir, LOAD_PATH)
		push!(LOAD_PATH, newDir);
	end
	return nothing
end


"""
remove_from_path!

Remove a directory to the LOAD_PATH, if it exists
"""
function remove_from_path!(newDir :: String)
	idx = findfirst(x -> x == newDir, LOAD_PATH);
	if !isnothing(idx)
		deleteat!(LOAD_PATH, idx);
	end
	return nothing
end

end # module
