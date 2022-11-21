using PlotDocs, PlotThemes, Plots, RecipesBase, RecipesPipeline
using Documenter, DemoCards, Literate
import StatsPlots

# monkey patch `Documenter` - note that this could break on minor `Documenter` releases
@eval Documenter.Writers.HTMLWriter domify(ctx, navnode) = begin
    # github.com/JuliaDocs/Documenter.jl/blob/327d155f992ec7c63e35fa2cb08f7f7c2d33409a/src/Writers/HTMLWriter.jl#L1448-L1455
    page = getpage(ctx, navnode)
    map(page.elements) do elem
        rec = SearchRecord(ctx, navnode, elem)
        ############################################################
        # begin addition
        if (m = match(r"generated/attributes_(\w+).html", lowercase(rec.src))) !== nothing
            # fix attributes search terms: `Series`, `Plot`, `Subplot` and `Axis` (github.com/JuliaPlots/Plots.jl/issues/2337)
            @info "fix $(rec.src) $(rec.fragment) attribute search"
            for (attr, alias) in $(ATTRIBUTE_SEARCH)[first(m.captures)]
                push!(
                    ctx.search_index, 
                    SearchRecord(rec.src, rec.page, rec.fragment, rec.category, rec.title, rec.page_title, attr * ' ' * alias)
                )
            end
        else
            add_to_index = if (m = match(r"gallery/(\w+)/", lowercase(rec.src))) !== nothing
                first(m.captures) == "gr"  # only add `GR` gallery pages to `search_index` (github.com/JuliaPlots/Plots.jl/issues/4157)
            else
                true
            end
            if add_to_index
                push!(ctx.search_index, rec)
            else
                @info "skip adding $(rec.src) $(rec.fragment) to `search_index`"
            end
        end
        # end addition
        ############################################################
        domify(ctx, navnode, page.mapping[elem])
    end
end

@eval DemoCards get_logopath() = $(pkgdir(PlotDocs, "docs", "src", "assets", "axis_logo_600x400.png"))

get!(ENV, "MPLBACKEND", "agg")  # set matplotlib gui backend
mkpath(GENDIR)

# initialize all backends
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

for (pkg, dest) in ((PlotThemes, "plotthemes.md"), (StatsPlots, "statsplots.md"))
    cp(pkgdir(pkg, "README.md"), joinpath(GENDIR, dest); force = true)
end

@info "gallery"

galleries = Pair{String,String}[]
galleries_assets = String[]
galleries_cb = []
user_gallery = []
if get(ENV, "PLOTDOCS_GALLERY", "true") == "true"
    for (bename, be) in (
        ("GR", :gr),
        ("PyPlot", :pyplot),
        ("PlotlyJS", :plotlyjs),
        ("PGFPlotsX", :pgfplotsx),
        ("UnicodePlots", :unicodeplots),
        ("InspectDR", :inspectdr),
        ("Gaston", :gaston),
    )
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
end
unique!(galleries_assets)

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
    Literate.markdown(ipath, opath; documenter = execute)
    nb && Literate.notebook(ipath, notebooks; execute)
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

ansicolor = get(ENV, "PLOTDOCS_ANSICOLOR", "true") == "true"
@info "makedocs" ansicolor
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
