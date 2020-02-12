using Documenter, PlotDocs, Plots

const PAGES = Any[
    "Home" => "index.md",
    "Getting Started" => [
        "Installation" => "install.md",
        "Basics" => "basics.md",
        "Tutorial" => "tutorial.md",
    ],
    "Manual" => [
        "Input Data" => "input_data.md",
        "Output" => "output.md",
        "Attributes" => [
            "Overview" => "attributes.md",
            "Series Attributes" => "generated/attributes_series.md",
            "Plot Attributes" => "generated/attributes_plot.md",
            "Subplot Attributes" => "generated/attributes_subplot.md",
            "Axis Attributes" => "generated/attributes_axis.md",
        ],
        "Layouts" => "layouts.md",
        "Recipes" => "recipes.md",
        "Colors" => "colors.md",
        "Animations" => "animations.md",
        "Backends" => "backends.md",
        "Supported Attributes" => "generated/supported.md",
    ],
    "Learning" => "learning.md",
    "Contributing" => "contributing.md", # TODO: testing
    "Ecosystem" => "ecosystem.md",
    "Advanced Topics" => [
        "Internals" => "pipeline.md",
    ],
]

const EXAMPLES = "Examples" => [
    "GR" => "generated/gr.md",
    "Plotly" => "generated/plotly.md",
    "PyPlot" => "generated/pyplot.md",
    "PGFPlots" => "generated/pgfplots.md",
    "UnicodePlots" => "examples/unicodeplots.md",
    "InspectDR" => "examples/inspectdr.md",
]

function builddocs(; examples=true)
    generate_attr_markdown()
    generate_supported_markdown()
    for be in (:gr, :plotly, :pyplot, :pgfplots)
        if examples
            generate_markdown(be)
        else
            rm(joinpath(GENDIR, "$be.md"), force=true)
        end
    end
    pages = examples ? [PAGES; EXAMPLES] : PAGES
    makedocs(
        format = Documenter.HTML(prettyurls = get(ENV, "CI", nothing) == "true"),
        sitename = "Plots",
        authors = "Thomas Breloff",
        pages = pages,
    )
end

builddocs()

deploydocs(repo = "github.com/JuliaPlots/PlotDocs.jl.git")
