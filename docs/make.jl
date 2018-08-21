using Documenter, Plots

makedocs(modules=[Plots], doctest=false)

deploydocs(
    deps = Deps.pip("mkdocs==0.17.5", 
        "mkdocs-material==2.9.4" ,"python-markdown-math", "pygments", "pymdown-extensions"),
    repo   = "github.com/JuliaPlots/PlotDocs.jl.git",
    julia  = "1.0",
    osname = "linux"
)
