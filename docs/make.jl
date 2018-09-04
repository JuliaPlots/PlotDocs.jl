using Documenter, Plots, PlotDocs


for be in (:gr, :pyplot, :plotlyjs)
    generate_markdown(be)
end
save_attr_html_files()
create_support_tables()


# makedocs(modules=[Plots], doctest=false)


makedocs(
    format = :html,
    sitename = "Plots",
    authors = "Thomas Breloff",
    pages = Any[
        "Home" => "index.md",
        "Tutorial" => "tutorial.md",
        "Getting Started" => [
            "Installation" => "install.md",
            "Basics" => "basics.md",
            "Input Data" => "input_data.md",
            "Attributes" => "attributes.md",
            "Output" => "output.md",
            "Backends" => "backends.md",
            "Colors" => "colors.md",
            "Animations" => "animations.md",
        ],
        "Learning" => "learning.md",
        "Contributing" => "contributing.md",
        "Advanced Topics" => [
            "Internals" => "pipeline.md",
            "Layouts" => "layouts.md",
            "Recipes" => "recipes.md",
            "Plots v0.7" => "plots_v0.7.md",
        ],
        "Ecosystem" => "ecosystem.md",
        "Supported Attributes" => "supported.md",
        "Examples" => [
            "PyPlot" => "examples/pyplot.md",
            "GR" => "examples/gr.md",
            "PlotlyJS" => "examples/plotlyjs.md",
            "PGFPlots" => "examples/pgfplots.md",
            "UnicodePlots" => "examples/unicodeplots.md",
            "InspectDR" => "examples/inspectdr.md",
        ],
    ],
    )


# deploydocs(
#     deps = Deps.pip("mkdocs==0.17.5",
#         "mkdocs-material==2.9.4" ,"python-markdown-math", "pygments", "pymdown-extensions"),
#     repo   = "github.com/JuliaPlots/PlotDocs.jl.git",
#     julia  = "1.0",
#     osname = "linux"
# )
