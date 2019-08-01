using Documenter, ConfigLH

makedocs(
    modules = [ConfigLH],
    format = :html,
    checkdocs = :exports,
    sitename = "ConfigLH.jl",
    pages = Any["index.md"]
)

deploydocs(
    repo = "github.com/hendri54/ConfigLH.jl.git",
)
