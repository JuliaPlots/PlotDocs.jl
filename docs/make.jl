using PlotDocs, PlotThemes, Plots, RecipesBase, RecipesPipeline
using Documenter, DemoCards, Literate
import StatsPlots

# Set matplotlib gui backend
ENV["MPLBACKEND"] = "agg"

# Initialize all backends
gr()
plotlyjs()
pyplot()
pgfplotsx()
unicodeplots()
inspectdr()
gaston()

@info "generate markdown"
generate_attr_markdown()
generate_supported_markdown()
generate_graph_attr_markdown()
generate_colorschemes_markdown()

@eval DemoCards.get_logopath() =
    joinpath(pkgdir(PlotDocs), "docs", "src", "assets", "axis_logo_600x400.png")

plotthemes_path = pkgdir(PlotThemes)

cp(
    joinpath(plotthemes_path, "README.md"),
    joinpath(mkpath(joinpath(@__DIR__, "src", "generated")), "plotthemes.md"),
    force = true,
)
cp(
    joinpath(pkgdir(StatsPlots), "README.md"),
    joinpath(@__DIR__, "src", "generated", "statsplots.md"),
    force = true,
)

@info "gallery"

galleries = Pair{String,String}[]
galleries_assets = String[]
galleries_cb = []
user_gallery = []
if get(ENV, "PLOTDOCS_GALLERY", "true") == "true"
    for (bename, be) in [
        ("GR", :gr),
        ("PlotlyJS", :plotlyjs),
        ("PyPlot", :pyplot),
        ("PGFPlotsX", :pgfplotsx),
        ("UnicodePlots", :unicodeplots),
        ("InspectDR", :inspectdr),
        ("Gaston", :gaston),
    ]
        generate_cards(be)
        let (path, cb, assets) = makedemos("gallery/$be"; src = "src/gallery")
            push!(galleries, bename => joinpath("gallery", path))
            push!(galleries_cb, cb)
            push!(galleries_assets, assets)
        end
    end
    user_gallery, cb, assets = makedemos("user_gallery"; src = "src")
    push!(galleries_cb, cb)
    push!(galleries_assets, assets)
    unique!(galleries_assets)
end
@info "generated $(length(galleries_assets)) gallery card(s)" 

@info "UnitfulRecipes"
src_unitfulrecipes = "src/UnitfulRecipes"
unitfulrecipes = joinpath(@__DIR__, src_unitfulrecipes)
notebooks = joinpath(unitfulrecipes, "notebooks")

execute = true  # set to true for executing notebooks and documenter!
nb = false      # set to true to generate the notebooks
for (root, _, files) in walkdir(unitfulrecipes), file in files
    last(splitext(file)) == ".jl" || continue
    ipath = joinpath(root, file)
    opath = replace(ipath, src_unitfulrecipes => "src/generated") |> splitdir |> first
    Literate.markdown(ipath, opath, documenter = execute)
    nb && Literate.notebook(ipath, notebooks, execute = execute)
end

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
        "Attributes" => "attributes.md",
        "Series Attributes" => "generated/attributes_series.md",
        "Plot Attributes" => "generated/attributes_plot.md",
        "Subplot Attributes" => "generated/attributes_subplot.md",
        "Axis Attributes" => "generated/attributes_axis.md",
        "Layouts" => "layouts.md",
        "Recipes" => [
            "Overview" => "recipes.md",
            "RecipesBase" => [
                "Home" => "RecipesBase/index.md",
                "Recipes Syntax" => "RecipesBase/syntax.md",
                "Recipes Types" => "RecipesBase/types.md",
                "Internals" => "RecipesBase/internals.md",
                "Public API" => "RecipesBase/api.md",
            ],
            "RecipesPipeline" => [
                "Home" => "RecipesPipeline/index.md",
                "Public API" => "RecipesPipeline/api.md",
            ],
        ],
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
        "StatsPlots" => "generated/statsplots.md",
        "GraphRecipes" => [
            "Introduction" => "GraphRecipes/introduction.md",
            "Examples" => "GraphRecipes/examples.md",
            "Attributes" => "generated/graph_attributes.md",
        ],
        "UnitfulRecipes" => [
            "Introduction" => "UnitfulRecipes/unitfulrecipes.md",
            "Examples" => [
                "Simple" => "generated/unitfulrecipes_examples.md",
                "Plots" => "generated/unitfulrecipes_plots.md",
            ]
        ],
        "Overview" => "ecosystem.md",
    ],
    "Advanced Topics" => ["Internals" => "pipeline.md"],
    "Gallery" => galleries,
    "User Gallery" => user_gallery,
    "API" => "api.md",
]

@info "makedocs"
ansicolor = get(ENV, "PLOTDOCS_ANSICOLOR", "true") == "true"
@show ansicolor
@time makedocs(
    format = Documenter.HTML(
        prettyurls = get(ENV, "CI", nothing) == "true",
        assets = ["assets/favicon.ico", galleries_assets...],
        ansicolor = ansicolor,
        collapselevel = 2,
    ),
    sitename = "Plots",
    authors = "Thomas Breloff",
    pages = PAGES,
    strict = [:doctest, :example_block],
)

foreach(galleries_cb) do cb
    cb()  # URL redirection for DemoCards-generated gallery
end

@info "deploydocs"
deploydocs(
    repo = "github.com/JuliaPlots/PlotDocs.jl.git",
    versions = ["stable" => "v^", "v#.#", "dev" => "dev", "latest" => "dev"],
    push_preview = true,
    forcepush = true,
)
