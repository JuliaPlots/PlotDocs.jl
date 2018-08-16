using Documenter, Plots

makedocs(modules=[Plots], doctest=false)

deploydocs(
    deps   = Deps.pip("mkdocs",
    "mkdocs-material" ,"python-markdown-math", "pygments", "pymdown-extensions"),
    repo   = "github.com/JuliaPlots/PlotDocs.jl.git",
    julia  = "0.7",
    osname = "linux"
)
