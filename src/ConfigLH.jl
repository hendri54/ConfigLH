module ConfigLH

using Pkg, Printf

export add_to_path!, remove_from_path!, shared_dir, test_dir

include("computer.jl")
include("package.jl")


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

include("projectLH.jl")

end # module
