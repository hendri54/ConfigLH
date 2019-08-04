
# Path to my github repo
githubUrl = "https://github.com/hendri54/";


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

# ------------