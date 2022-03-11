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

galleries = Pair{String,String}[]
galleries_cb = []
galleries_assets = String[]
for be in (:gr, :plotlyjs, :pyplot, :inspectdr, :gaston,
    :pgfplotsx,
    # :unicodeplots,
    )
    generate_cards(be)
    gallery_path, postprocess_cb, assets = makedemos("galleries/generated_$be")
    push!(galleries, titlecase(string(be)) => gallery_path)
    push!(galleries_cb, postprocess_cb)
    push!(galleries_assets, assets)
end
unique!(galleries_assets)

const PAGES = Any[
    "Home"=>"index.md",
    "Getting Started"=>[
        "Installation" => "install.md",
        "Basics" => "basics.md",
        "Tutorial" => "tutorial.md",
    ],
    "Manual"=>[
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
    "Learning"=>"learning.md",
    "Contributing"=>"contributing.md", # TODO: testing
    "Ecosystem"=>[
        "Overview" => "ecosystem.md",
        "GraphRecipes" => [
            "Introduction" => "graphrecipes/introduction.md",
            "Examples" => "graphrecipes/examples.md",
            "Attributes" => "generated/graph_attributes.md",
        ],
    ],
    "Advanced Topics"=>["Internals" => "pipeline.md"],
    "Gallery" => galleries,
    "Examples (old)" => [
        "UnicodePlots" => "generated/unicodeplots.md",
    ],
]

generate_attr_markdown()
generate_supported_markdown()
generate_graph_attr_markdown()
generate_colorschemes_markdown()
for be in (:unicodeplots,)
    generate_markdown(be)
end

ansicolor = get(ENV, "PLOTDOCS_ANSICOLOR", "true") == "true"
@show ansicolor
@time makedocs(
    format = Documenter.HTML(
        prettyurls = get(ENV, "CI", nothing) == "true",
        assets = ["assets/favicon.ico", galleries_assets...],
        ansicolor = ansicolor,
    ),
    sitename = "Plots",
    authors = "Thomas Breloff",
    pages = PAGES,
)
# currently broken
# foreach(galleries_cb) do cb
#     # URL redirection for DemoCards-generated gallery
#     cb()
# end

deploydocs(
    repo = "github.com/JuliaPlots/PlotDocs.jl.git",
    push_preview = true,
    forcepush = true,
)
