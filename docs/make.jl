using DataFrames, MacroTools, OrderedCollections, Dates
using PlotThemes, Plots, RecipesBase, RecipesPipeline
using Documenter, DemoCards, Literate, StableRNGs, Glob
using JSON

import StatsPlots

const SRC_DIR = joinpath(@__DIR__, "src")
const WORK_DIR = joinpath(@__DIR__, "work")
const GEN_DIR = joinpath(WORK_DIR, "generated")

const ATTRIBUTE_SEARCH = Dict{String,Any}()  # search terms

# monkey patch `Documenter` - note that this could break on minor `Documenter` releases
@eval Documenter.Writers.HTMLWriter domify(ctx, navnode) = begin
    # github.com/JuliaDocs/Documenter.jl/blob/327d155f992ec7c63e35fa2cb08f7f7c2d33409a/src/Writers/HTMLWriter.jl#L1448-L1455
    page = getpage(ctx, navnode)
    map(page.elements) do elem
        rec = SearchRecord(ctx, navnode, elem)
        ############################################################
        # begin addition
        info = "[src=$(rec.src) fragment=$(rec.fragment) title=$(rec.title) page_title=$(rec.page_title)]"
        if (m = match(r"generated/attributes_(\w+)", lowercase(rec.src))) !== nothing
            # fix attributes search terms: `Series`, `Plot`, `Subplot` and `Axis` (github.com/JuliaPlots/Plots.jl/issues/2337)
            @info "$info: fix attribute search"
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
                @info "$info: skip adding to `search_index`"
            end
        end
        # end addition
        ############################################################
        domify(ctx, navnode, page.mapping[elem])
    end
end

@eval DemoCards get_logopath() = $(joinpath(SRC_DIR, "assets", "axis_logo_600x400.png"))

# monkey patch `DemoCards` to avoid `# Generated` section in gallery
@eval DemoCards generate(sec::DemoSection, templates; level=1, properties=Dict{String, Any}()) = begin
    # https://github.com/JuliaDocs/DemoCards.jl/blob/db05c296b9de80137c28f92a4944bc21a0cda0db/src/generate.jl#L275-L292
    ############################################################
    # begin addition
    header = if occursin("generated", lowercase(sec.title)) 
        ""
    else
        repeat("#", level) * " " * sec.title
    end * '\n'
    # end addition
    ############################################################
    footer = "\n"
    properties = merge(properties, sec.properties) # sec.properties has higher priority

    # either cards or subsections are empty
    # recursively generate the page contents
    if isempty(sec.cards)
        body = generate(sec.subsections, templates; level=level+1, properties=properties)
    else
        items = Dict(
            "cards" => generate(sec.cards, templates["card"], properties=properties),
            "description" => sec.description
        )
        body = Mustache.render(templates["section"], items)
    end
    header * body * footer
end

# ----------------------------------------------------------------------

edit_url(args...) = 
    "https://github.com/JuliaPlots/PlotDocs.jl/blob/master/docs/" * if length(args) == 0
        "make.jl"
    else
        joinpath("src", args...)
    end

autogenerated() = "(Automatically generated: " * Dates.format(now(), RFC1123Format) * ')'

author() = "[PlotDocs.jl](https://github.com/JuliaPlots/PlotDocs.jl)"

recursive_rmlines(x) = x
function recursive_rmlines(x::Expr)
    x = rmlines(x)
    x.args .= recursive_rmlines.(x.args)
    x
end

pretty_print_expr(io::IO, expr::Expr) =
    if expr.head === :block
        foreach(arg -> println(io, arg), recursive_rmlines(expr).args)
    else
        println(io, recursive_rmlines(expr))
    end

markdown_code_to_string(arr, prefix = "") =
    surround_backticks(prefix, join(sort(map(string, arr)), "`, `$prefix"))

markdown_symbols_to_string(arr) = isempty(arr) ? "" : markdown_code_to_string(arr, ":")

# ----------------------------------------------------------------------

# NOTE: keep consistent with `Plots`
ref_name(i) = "ref" * lpad(i, 3, '0')

function generate_cards(
    prefix::AbstractString, backend::Symbol, slice;
    skip = get(Plots._backend_skips, backend, Int[]) 
)
    # create folder: for each backend we generate a DemoSection "generated" under "gallery"
    cardspath = mkpath(joinpath(prefix, "$backend", "generated"))
    sec_config = Dict{String, Any}("order" => [])

    needs_rng_fix = Dict{Int,Bool}()

    for (i, example) in enumerate(Plots._examples[slice])
        # write out the header, description, code block, and image link
        jlname = "$backend-$(ref_name(i)).jl"
        jl = PipeBuffer()
        if !isempty(example.header)
            push!(sec_config["order"], jlname)
            # start a new demo file
            @debug "generate demo \"$(example.header)\" - writing `$jlname`"

            # DemoCards YAML frontmatter
            # https://johnnychen94.github.io/DemoCards.jl/stable/quickstart/usage_example/julia_demos/1.julia_demo/#juliademocard_example
            asset = if i in (2, 31)
                "anim_$(backend)_$(ref_name(i)).gif"
            else
                "$(backend)_$(ref_name(i)).png"
            end
            write(jl, """
                # ---
                # title: $(example.header)
                # id: $(backend)_demo_$i $(i in skip ? "" : "\n# cover: assets/$asset")
                # author: "$(author())"
                # description: ""
                # date: $(now())
                # ---

                using Plots
                $backend()
                """
            )

            i in skip && @goto write_file
            write(jl, """
                Plots.reset_defaults()  #hide
                using StableRNGs  #hide
                rng = StableRNG($(Plots.PLOTS_SEED))  #hide
                nothing  #hide
                """
            )
        end
        # DemoCards use Literate.jl syntax with extra leading `#` as markdown lines
        write(jl, "# $(replace(example.desc, "\n" => "\n  # "))\n")
        isnothing(example.imports) || pretty_print_expr(jl, example.imports)
        needs_rng_fix[i] = (exprs_rng = Plots.replace_rand(example.exprs)) != example.exprs
        pretty_print_expr(jl, exprs_rng)

        # NOTE: the supported `Literate.jl` syntax is `#src` and `#hide` NOT `# src` !!
        # from the docs: """
        # #src and #hide are quite similar. The only difference is that #src lines are filtered out before execution (if execute=true) and #hide lines are filtered out after execution.
        # """
        asset = if i in (2, 31)
            "gif(anim, \"assets/anim_$(backend)_$(ref_name(i)).gif\")\n"  # NOTE: must not be hidden, for appearance in the rendered `html`
        else
            "png(\"assets/$(backend)_$(ref_name(i)).png\")  #src\n"
        end
        write(jl, """
            mkpath("assets")  #src
            $asset
            """
        )
        backend === :plotlyjs && write(jl, """
            nothing  #hide
            # ![plot](assets/$(backend)_$(ref_name(i)).png)
            """
        )

        @label write_file
        fn, mode = if isempty(example.header)
            "$backend-$(ref_name(i - 1)).jl", "a"  # continued example
        else
            jlname, "w"
        end
        card = joinpath(cardspath, fn)
        # @info "writing" card
        open(card, mode) do io
            write(io, read(jl, String))
        end
        # DEBUG: sometimes the generated file is still empty when passing to `DemoCards.makedemos`
        sleep(0.01)
    end
    # insert attributes page
    # TODO(johnnychen): make this part of the page template
    attr_name = string(backend, ".jl")
    open(joinpath(cardspath, attr_name), "w") do jl
        pkg = Plots._backend_instance(backend)
        write(jl, """
            # ---
            # title: Supported attribute values
            # id: $(backend)_attributes
            # hidden: true
            # author: "$(author())"
            # date: $(now())
            # ---

            # - Supported arguments: $(markdown_code_to_string(collect(Plots.supported_attrs(pkg))))
            # - Supported values for linetype: $(markdown_symbols_to_string(Plots.supported_seriestypes(pkg)))
            # - Supported values for linestyle: $(markdown_symbols_to_string(Plots.supported_styles(pkg)))
            # - Supported values for marker: $(markdown_symbols_to_string(Plots.supported_markers(pkg)))
            """
        )
    end
    open(joinpath(cardspath, "config.json"), "w") do config
        sec_config["description"] = "[Supported attributes](@ref $(backend)_attributes)"
        push!(sec_config["order"], attr_name)
        write(config, json(sec_config))
    end
    needs_rng_fix
end

# tables detailing the features that each backend supports

function make_support_df(allvals, func)
    vals = sort(collect(allvals)) # rows
    bs = sort(backends())
    df = DataFrames.DataFrame(keys=vals)

    for be in filter(b -> b ∉ Plots._deprecated_backends, bs) # cols
        be_supported_vals = fill("", length(vals))
        for (i, val) in enumerate(vals)
            be_supported_vals[i] = if func == Plots.supported_seriestypes
                stype = Plots.seriestype_supported(Plots._backend_instance(be), val)
                stype === :native ? "✅" : (stype === :no ? "" : "🔼")
            else
                val in func(Plots._backend_instance(be)) ? "✅" : ""
            end
        end
        df[!, be] = be_supported_vals
    end
    df
end

function generate_supported_markdown()
    supported_args = OrderedDict(
        "Keyword Arguments" => (Plots._all_args, Plots.supported_attrs),
        "Markers" => (Plots._allMarkers, Plots.supported_markers),
        "Line Styles" => (Plots._allStyles,  Plots.supported_styles),
        "Scales" => (Plots._allScales,  Plots.supported_scales)
    )
    open(joinpath(GEN_DIR, "supported.md"), "w") do md
        write(md, """
            ```@meta
            EditURL = "$(edit_url())"
            ```

            ## [Series Types](@id supported)

            Key:

            - ✅ the series type is natively supported by the backend.
            - 🔼 the series type is supported through series recipes.

            ```@raw html
            $(to_html(make_support_df(Plots.all_seriestypes(), Plots.supported_seriestypes)))
            ```
            """
        )
        for (header, args) in supported_args
            write(md, """

                ## $header

                ```@raw html
                $(to_html(make_support_df(args...)))
                ```
                """
            )
        end
        write(md, '\n' * autogenerated())
    end
end


# ----------------------------------------------------------------------


function make_attr_df(ktype::Symbol, defs::KW)
    n = length(defs)
    df = DataFrame(
        Attribute = fill("", n),
        Aliases = fill("", n),
        Default = fill("", n),
        Type = fill("", n),
        Description = fill("", n),
    )
    for (i, (k, def)) in enumerate(defs)
        type, desc = get(Plots._arg_desc, k, (Any, ""))

        aliases = sort(collect(keys(filter(p -> p.second == k, Plots._keyAliases))))
        df.Attribute[i] = string(k)
        df.Aliases[i] = join(aliases, ", ")
        df.Default[i] = show_default(def)
        df.Type[i] = string(type)
        df.Description[i] = string(desc)
    end
    sort!(df, [:Attribute])
    df
end

surround_backticks(args...) = '`' * string(args...) * '`'
show_default(x) = surround_backticks(x)
show_default(x::Symbol) = surround_backticks(":$x")

function generate_attr_markdown(c)
    attribute_texts = Dict(
        :Series => "These attributes apply to individual series (lines, scatters, heatmaps, etc)",
        :Plot => "These attributes apply to the full Plot. (A Plot contains a tree-like layout of Subplots)",
        :Subplot => "These attributes apply to settings for individual Subplots.",
        :Axis => """
        These attributes apply by default to all Axes in a Subplot (for example the `subplot[:xaxis]`).
        !!! info
            You can also specific the x, y, or z axis for each of these attributes by prefixing the attribute name with x, y, or z
            (for example `xmirror` only sets the mirror attribute for the x axis).
        """,
    )
    attribute_defaults = Dict(
        :Series => Plots._series_defaults,
        :Plot => Plots._plot_defaults,
        :Subplot => Plots._subplot_defaults,
        :Axis => Plots._axis_defaults,
    )

    df = make_attr_df(c, attribute_defaults[c])
    cstr = lowercase(string(c))
    ATTRIBUTE_SEARCH[cstr] = collect(zip(df.Attribute, df.Aliases))

    open(joinpath(GEN_DIR, "attributes_$cstr.md"), "w") do md
        write(md, """
            ```@meta
            EditURL = "$(edit_url())"
            ```
            ### $c

            $(attribute_texts[c])

            ```@raw html
            $(to_html(df))
            ```

            $(autogenerated())
            """
        )
    end
end

generate_attr_markdown() =
    foreach(c -> generate_attr_markdown(c), (:Series, :Plot, :Subplot, :Axis))

function generate_graph_attr_markdown()
    df = DataFrame(
        Attribute = [
            "dim",
            "T",
            "curves",
            "curvature_scalar",
            "root",
            "node_weights",
            "names",
            "fontsize",
            "nodeshape",
            "nodesize",
            "nodecolor",
            "x, y, z",
            "method",
            "func",
            "shorten",
            "axis_buffer",
            "layout_kw",
            "edgewidth",
            "edgelabel",
            "edgelabel_offset",
            "self_edge_size",
            "edge_label_box",
        ],
        Aliases = [
            "",
            "",
            "",
            "curvaturescalar, curvature",
            "",
            "nodeweights",
            "",
            "",
            "node_shape",
            "node_size",
            "marker_color",
            "x",
            "",
            "",
            "shorten_edge",
            "axisbuffer",
            "",
            "edge_width, ew",
            "edge_label, el",
            "edgelabeloffset, elo",
            "selfedgesize, ses",
            "edgelabelbox, edgelabel_box, elb",
        ],
        Default = [
            "2",
            "Float64",
            "true",
            "0.05",
            ":top",
            "nothing",
            "[]",
            "7",
            ":hexagon",
            "0.1",
            "1",
            "nothing",
            ":stress",
            "get(_graph_funcs, method, by_axis_local_stress_graph)",
            "0.0",
            "0.2",
            "Dict{Symbol,Any}()",
            "(s, d, w) -> 1",
            "nothing",
            "0.0",
            "0.1",
            "true",
        ],
        Description = [
            "The number of dimensions in the visualization.",
            "The data type for the coordinates of the graph nodes.",
            "Whether or not edges are curved. If `curves == true`, then the edge going from node \$s\$ to node \$d\$ will be defined by a cubic spline passing through three points: (i) node \$s\$, (ii) a point `p` that is distance `curvature_scalar` from the average of node \$s\$ and node \$d\$ and (iii) node \$d\$.",
            "A scalar that defines how much edges curve, see `curves` for more explanation.",
            "For displaying trees, choose from `:top`, `:bottom`, `:left`, `:right`. If you choose `:top`, then the tree will be plotted from the top down.",
            "The weight of the nodes given by a list of numbers. If `node_weights != nothing`, then the size of the nodes will be scaled by the `node_weights` vector.",
            "Names of the nodes given by a list of objects that can be parsed into strings. If the list is smaller than the number of nodes, then GraphRecipes will cycle around the list.",
            "Font size for the node labels and the edge labels.",
            "Shape of the nodes, choose from `:hexagon`, `:circle`, `:ellipse`, `:rect` or `:rectangle`.",
            "The size of nodes in the plot coordinates. Note that if `names` is not empty, then nodes will be scaled to fit the labels inside them.",
            "The color of the nodes. If `nodecolor` is an integer, then it will be taken from the current color pallette. Otherwise, the user can pass any color that would be recognised by the Plots `color` attribute.",
            "The coordinates of the nodes.",
            "The method that GraphRecipes uses to produce an optimal layout, choose from `:spectral`, `:sfdp`, `:circular`, `:shell`, `:stress`, `:spring`, `:tree`, `:buchheim`, `:arcdiagram` or `:chorddiagram`. See [NetworkLayout](https://github.com/JuliaGraphs/NetworkLayout.jl) for further details.",
            "A layout algorithm that can be passed in by the user.",
            "An amount to shorten edges by.",
            "Increase the `xlims` and `ylims`/`zlims` of the plot. Can be useful if part of the graph sits outside of the default view.",
            "A list of keywords to be passed to the layout algorithm, see [NetworkLayout](https://github.com/JuliaGraphs/NetworkLayout.jl) for a list of keyword arguments for each algorithm.",
            "The width of the edge going from \$s\$ to node \$d\$ with weight \$w\$.",
            "A dictionary of `(s, d) => label`, where `s` is an integer for the source node, `d` is an integer for the destiny node and `label` is the desired label for the given edge. Alternatively the user can pass a vector or a matrix describing the edge labels. If you use a vector or matrix, then either `missing`, `false`, `nothing`, `NaN` or `\"\"` values will not be displayed. In the case of multigraphs, triples can be used to define edges.",
            "The distance between edge labels and edges.",
            "The size of self edges.",
            "A box around edge labels that avoids intersections between edge labels and the edges that they are labeling.",
        ]
    )
    open(joinpath(GEN_DIR, "graph_attributes.md"), "w") do md
        write(md, """
            ```@meta
            EditURL = "$(edit_url())"
            ```
            # [Graph Attributes](@id graph_attributes)

            Where possible, GraphRecipes will adopt attributes from Plots.jl to format visualizations.
            For example, the `linewidth` attribute from Plots.jl has the same effect in GraphRecipes.
            In order to give the user control over the layout of the graph visualization, GraphRecipes
            provides a number of keyword arguments (attributes). Here we describe those attributes
            alongside their default values.

            ```@raw html
            $(to_html(df))
            ```
            \n
            ## Aliases
            Certain keyword arguments have aliases, so GraphRecipes "does what you mean, not
            what you say".

            So for example, `nodeshape=:rect` and `node_shape=:rect` are equivalent. To see the
            available aliases, type `GraphRecipes.graph_aliases`. If you are unhappy with the provided
            aliases, then you can add your own:
            ```julia
            using GraphRecipes, Plots

            push!(GraphRecipes.graph_aliases[:nodecolor],:nc)

            # These two calls produce the same plot, modulo some randomness in the layout.
            plot(graphplot([0 1; 0 0], nodecolor=:red), graphplot([0 1; 0 0], nc=:red))
            ```

            $(autogenerated())
            """
        )
    end
end

function generate_colorschemes_markdown()
    open(joinpath(GEN_DIR, "colorschemes.md"), "w") do md
        write(md, """
            ```@meta
            EditURL = "$(edit_url())"
            ```
            """
        )
        for line in readlines(joinpath(SRC_DIR, "colorschemes.md"))
            write(md, line * '\n')
        end
        write(md, """
            ## misc

            These colorschemes are not defined or provide different colors in ColorSchemes.jl
            They are kept for compatibility with Plots behavior before v1.1.0.
            """
        )
        write(md, "```@raw html\n")
        ks = [:default; sort(collect(keys(PlotUtils.MISC_COLORSCHEMES)))]
        write(md, to_html(make_colorschemes_df(ks); allow_html_in_cells=true))
        write(md, "\n```\n\nThe following colorschemes are defined by ColorSchemes.jl.\n\n")
        for cs in ("cmocean", "scientific", "matplotlib", "colorbrewer", "gnuplot", "colorcet", "seaborn", "general")
            ks = sort([k for (k, v) in PlotUtils.ColorSchemes.colorschemes if occursin(cs, v.category)])
            write(md, "\n## $cs\n\n```@raw html\n")
            write(md, to_html(make_colorschemes_df(ks); allow_html_in_cells=true))
            write(md, "\n```\n")
        end
    end
end

function colors_svg(cs, w, h)
    n = length(cs)
    ws = min(w / n, h)
    # NOTE: html tester, codebeautify.org/htmlviewer or htmledit.squarefree.com
    html = replace("""
        <?xml version="1.0" encoding="UTF-8"?>
        <!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.1//EN"
         "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd">
        <svg xmlns="http://www.w3.org/2000/svg" version="1.1"
             width="$(n * ws)mm" height="$(h)mm"
             viewBox="0 0 $n 1" preserveAspectRatio="none"
             shape-rendering="crispEdges" stroke="none">
        """, "\n" => " "
    )  # NOTE: no linebreaks (because those break html code)
    for (i, c) in enumerate(cs)
        html *= """<rect width="$(ws)mm" height="$(h)mm" x="$(i-1)" y="0" fill="#$(hex(convert(RGB, c)))" />"""
    end
    html *= "</svg>"
end

function make_colorschemes_df(ks)
    n = length(ks)
    df = DataFrame(
        Name = fill("", n),
        Palette = fill("", n),
        Gradient = fill("", n),
    )
    len, w, h = 100, 60, 5
    for (i, k) in enumerate(ks)
        p = palette(k)
        cg = cgrad(k)[range(0, 1, length = len)]
        cp = length(p) ≤ len ? color_list(p) : cg
        df.Name[i] = string(':', k)
        df.Palette[i] = colors_svg(cp, w, h)
        df.Gradient[i] = colors_svg(cg, w, h)
    end
    df
end

# ----------------------------------------------------------------------

function to_html(df::AbstractDataFrame; table_style=Dict("font-size" => "12px"), kw...)
    io = PipeBuffer()  # NOTE: `DataFrames` exports `PrettyTables`
    show(
        IOContext(io, :limit => false, :compact => false), MIME"text/html"(), df;
        show_row_number=false, summary=false, eltypes=false, table_style,
        kw...
    )
    read(io, String)
end

function main()
    get!(ENV, "MPLBACKEND", "agg")  # set matplotlib gui backend
    get!(ENV, "GKSwstype", "nul")  # disable default GR ws

    mkpath(GEN_DIR)

    # initialize all backends
    gr()
    plotlyjs()
    pyplot()
    pgfplotsx()
    unicodeplots()
    gaston()
    inspectdr()

    # NOTE: for a faster representative test build use `PLOTDOCS_BACKENDS='GR' PLOTDOCS_EXAMPLES='1'`
    default_backends = "GR PyPlot PlotlyJS PGFPlotsX UnicodePlots Gaston InspectDR"
    backends = get(ENV, "PLOTDOCS_BACKENDS", default_backends)
    backends = backends == "ALL" ? default_backends : backends
    @info "selected backends: $backends"

    slice = parse.(Int, split(get(ENV, "PLOTDOCS_EXAMPLES", "")))
    slice = length(slice) == 0 ? Colon() : slice
    @info "selected examples: $slice"

    work = basename(WORK_DIR)

    @info "generate markdown"
    generate_attr_markdown()
    generate_supported_markdown()
    generate_graph_attr_markdown()
    generate_colorschemes_markdown()

    for (pkg, dest) in ((PlotThemes, "plotthemes.md"), (StatsPlots, "statsplots.md"))
        cp(pkgdir(pkg, "README.md"), joinpath(GEN_DIR, dest); force = true)
    end

    @info "gallery"
    gallery = Pair{String,String}[]
    gallery_assets, gallery_callbacks, user_gallery = map(_ -> [], 1:3)
    needs_rng_fix = Dict{String,Any}()

    for name in split(backends)
        name_low = lowercase(name)
        needs_rng_fix[name] = generate_cards(joinpath(@__DIR__, "gallery"), Symbol(name_low), slice)
        let (path, cb, assets) = makedemos(joinpath("gallery", name_low); src = "$work/gallery")
            push!(gallery, name => joinpath("gallery", path))
            push!(gallery_callbacks, cb)
            push!(gallery_assets, assets)
        end
    end
    user_gallery, cb, assets = makedemos(joinpath("user_gallery"); src = work)
    push!(gallery_callbacks, cb)
    push!(gallery_assets, assets)
    unique!(gallery_assets)

    pages = [
        "Home" => "index.md",
        "Getting Started" => [
            "Installation" => "install.md",
            "Basics" => "basics.md",
            "Tutorial" => "tutorial.md",
            "Series Types" => [
                "Contour Plots" => "series_types/contour.md",
                "Histograms" => "series_types/histogram.md",
            ],
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
        "Contributing" => "contributing.md",
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
        "Gallery" => gallery,
        "User Gallery" => user_gallery,
        "API" => "api.md",
    ]

    # those will be built pages - to skip some pages, comment them above
    selected_pages = []
    collect_pages!(p::Pair) = if p.second isa AbstractVector
        collect_pages!(p.second)
    else
        push!(selected_pages, basename(p.second))
    end
    collect_pages!(v::AbstractVector) = foreach(collect_pages!, v)

    collect_pages!(pages)
    unique!(selected_pages)
    # @show selected_pages length(gallery) length(user_gallery)

    # FIXME: github.com/JuliaDocs/DemoCards.jl/pull/134
    # delete src/democards/bulmagridtheme.css when released
    n = 0
    for (root, dirs, files) in walkdir(SRC_DIR)
        foreach(dir -> mkpath(joinpath(WORK_DIR, dir)), dirs)
        for file in files
            _, ext = splitext(file)
            (ext == ".md" && file ∉ selected_pages) && continue
            cp(joinpath(root, file), joinpath(replace(root, SRC_DIR => WORK_DIR), file); force = true)
            n += 1
        end
    end
    @info "copied $n source file(s) to scratch directory `$work`"

    @info "UnitfulRecipes"
    src_unitfulrecipes = "src/UnitfulRecipes"
    unitfulrecipes = joinpath(@__DIR__, src_unitfulrecipes)
    notebooks = joinpath(unitfulrecipes, "notebooks")

    execute = true  # set to true for executing notebooks and documenter
    nb = false      # set to true to generate the notebooks
    for (root, _, files) in walkdir(unitfulrecipes), file in files
        last(splitext(file)) == ".jl" || continue
        ipath = joinpath(root, file)
        opath = replace(ipath, src_unitfulrecipes => "$work/generated") |> splitdir |> first
        Literate.markdown(ipath, opath; documenter = execute)
        nb && Literate.notebook(ipath, notebooks; execute)
    end

    ansicolor = get(ENV, "PLOTDOCS_ANSICOLOR", "true") == "true"
    @info "makedocs" ansicolor
    failed = false
    try
        @time makedocs(;
            source = work,
            format = Documenter.HTML(;
                prettyurls = get(ENV, "CI", nothing) == "true",
                assets = ["assets/favicon.ico", gallery_assets...],
                collapselevel = 2,
                ansicolor,
            ),
            sitename = "Plots",
            authors = "Thomas Breloff",
            strict = [:doctest, :example_block],
            pages,
        )
    catch e
        failed = true
        e isa InterruptException || rethrow()
    end

    foreach(gallery_callbacks) do cb
        cb()  # URL redirection for DemoCards-generated gallery
    end

    failed && return  # don't deploy and post-process on failure

    # postprocess gallery html files to remove `rng` in user displayed code
    # non-exhaustive list of examples to be fixed:
    # [1, 4, 5, 7:12, 14:21, 25:27, 29:30, 33:34, 36, 38:39, 41, 43, 45:46, 48, 52, 54, 62]
    for name in split(backends)
        prefix = joinpath(@__DIR__, "build", "gallery", lowercase(name), "generated")
        must_fix = needs_rng_fix[name]
        for file in glob("*/index.html", prefix)
            (m = match(r"-ref(\d+)", file)) === nothing && continue
            idx = parse(Int, first(m.captures))
            lines = readlines(file; keep=true)
            open(file, "w") do io
                count, in_code, sub = 0, false, ""
                for line in lines
                    trailing = if (m = match(r"""<code class="language-julia hljs">.*""", line)) !== nothing
                        in_code = true
                        m.match
                    else
                        line
                    end
                    if in_code && occursin("rng", line)
                        line = replace(line, r"rng\s*?,\s*" => "")
                        count += 1
                    end
                    occursin("</code>", trailing) && (in_code = false)
                    write(io, line)
                end
                count > 0 && @info "replaced $count `rng` occurrence(s) in $file"
                @assert (get(must_fix, idx, false) ? count > 0 : count == 0) "idx=$idx - count=$count - file=$file"
            end
        end
    end

    @info "deploydocs"
    deploydocs(
        repo = "github.com/JuliaPlots/PlotDocs.jl.git",
        versions = ["stable" => "v^", "v#.#", "dev" => "dev", "latest" => "dev"],
        push_preview = true,
        forcepush = true,
    )
end

main()
