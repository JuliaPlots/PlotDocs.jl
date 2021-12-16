using Documenter, PlotDocs, Plots, PlotThemes, DemoCards

# Set matplotlib gui backend
ENV["MPLBACKEND"] = "agg"

# Initialize backends
gr()
plotlyjs()
pyplot()
pgfplotsx()
unicodeplots()
inspectdr()
gaston()

plotthemes_path = dirname(dirname(pathof(PlotThemes)))

cp(
    joinpath(plotthemes_path, "README.md"),
    joinpath(mkpath(joinpath(@__DIR__, "src", "generated")), "plotthemes.md"),
    force = true,
)

generate_cards(:gr)
gallery, postprocess_cb, gallery_assets = makedemos("gallery")

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
        "ColorSchemes" => "generated/colorschemes.md",
        "Animations" => "animations.md",
        "Themes" => "generated/plotthemes.md",
        "Backends" => "backends.md",
        "Supported Attributes" => "generated/supported.md",
    ],
    "Learning" => "learning.md",
    "Contributing" => "contributing.md", # TODO: testing
    "Ecosystem" => [
        "Overview" => "ecosystem.md",
        "GraphRecipes" => [
            "Introduction" => "graphrecipes/introduction.md",
            "Examples" => "graphrecipes/examples.md",
            "Attributes" => "generated/graph_attributes.md",
        ],
    ],
    "Advanced Topics" => ["Internals" => "pipeline.md"],
    gallery,
    # "Examples" => [
    #     "GR" => "gallery/index.md#Gr",
        # "PlotlyJS" => "generated/plotlyjs.md",
        # "PyPlot" => "generated/pyplot.md",
        # "PGFPlotsX" => "generated/pgfplotsx.md",
        # "UnicodePlots" => "generated/unicodeplots.md",
        # "InspectDR" => "generated/inspectdr.md",
        # "Gaston" => "generated/gaston.md",
    # ],
]

generate_attr_markdown()
generate_supported_markdown()
generate_graph_attr_markdown()
generate_colorschemes_markdown()
# for be in (:gr, :plotlyjs, :pyplot, :pgfplotsx, :unicodeplots, :inspectdr, :gaston)
#     generate_markdown(be)
# end
ansicolor = get(ENV, "PLOTDOCS_ANSICOLOR", "true") == "true"
@show ansicolor
@time makedocs(
    format = Documenter.HTML(
        prettyurls = get(ENV, "CI", nothing) == "true",
        assets = ["assets/favicon.ico",
            # gallery_assets...
            ],
        ansicolor = ansicolor,
    ),
    sitename = "Plots",
    authors = "Thomas Breloff",
    pages = PAGES,
)
postprocess_cb() # URL redirection for DemoCards-generated gallery

deploydocs(
    repo = "github.com/JuliaPlots/PlotDocs.jl.git",
    push_preview = true,
    forcepush = true,
)
