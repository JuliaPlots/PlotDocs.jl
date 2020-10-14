
module PlotDocs


using Plots, DataFrames, MacroTools, OrderedCollections, Dates
import Plots: _examples

export
    generate_markdown,
    generate_supported_markdown,
    generate_attr_markdown,
    generate_graph_attr_markdown,
    generate_colorschemes_markdown,
    GENDIR

const GENDIR = normpath(@__DIR__, "..", "docs", "src", "generated")
mkpath(GENDIR)

# ----------------------------------------------------------------------

recursive_rmlines(x) = x
function recursive_rmlines(x::Expr)
    x = rmlines(x)
    x.args .= recursive_rmlines.(x.args)
    return x
end

function pretty_print_expr(io::IO, expr::Expr)
    for arg in recursive_rmlines(expr).args
        println(io, arg)
    end
end

function markdown_code_to_string(arr, prefix = "")
    string("`", prefix, join(sort(map(string, arr)), "`, `$prefix"), "`")
end
markdown_symbols_to_string(arr) = isempty(arr) ? "" : markdown_code_to_string(arr, ":")

# ----------------------------------------------------------------------

function generate_markdown(pkgname::Symbol; skip = get(Plots._backend_skips, pkgname, Int[]))
    pkg = Plots._backend_instance(pkgname)

    # open the markdown file
    md = open(joinpath(GENDIR, "$(pkgname).md"), "w")

    write(md, """
    ### [Initialize](@id $pkgname-examples)

    ```@example $pkgname
    using Plots
    Plots.reset_defaults() # hide
    $(pkgname)()
    ```
    """)

    for (i,example) in enumerate(_examples)
        i in skip && continue
        # generate animations only for GR
        i in (2, 31) && pkgname != :gr && continue
        # write out the header, description, code block, and image link
        if !isempty(example.header)
            write(md, """
            ### [$(example.header)](@id $pkgname-ref$i)
            """)
        end
        write(md, """
        $(example.desc)
        """)
        # write(md, "```julia\n$(join(map(string, example.exprs), "\n"))\n```\n\n")
        write(md, """
        ```@example $pkgname
        Plots.reset_defaults() # hide
        """)
        for expr in example.exprs
            pretty_print_expr(md, expr)
        end
        if i in (2, 31)
            write(md, "gif(anim, \"anim_$(pkgname)_ex$i.gif\") # hide\n")
        end
        if pkgname ∈ (:plotly, :plotlyjs)
            write(md, "png(\"$(pkgname)_ex$i\") # hide\n")
        end
        write(md, "```\n")
        if pkgname ∈ (:plotly, :plotlyjs)
            write(md, "![]($(pkgname)_ex$i.png)\n")
        end
    end

    write(md, "- Supported arguments: $(markdown_code_to_string(collect(Plots.supported_attrs(pkg))))\n")
    write(md, "- Supported values for linetype: $(markdown_symbols_to_string(Plots.supported_seriestypes(pkg)))\n")
    write(md, "- Supported values for linestyle: $(markdown_symbols_to_string(Plots.supported_styles(pkg)))\n")
    write(md, "- Supported values for marker: $(markdown_symbols_to_string(Plots.supported_markers(pkg)))\n")

    write(md, "(Automatically generated: $(now()))")
    close(md)
end

# ----------------------------------------------------------------------


# tables detailing the features that each backend supports

function make_support_df(allvals, func)
    vals = sort(allvals) # rows
    bs = sort(backends())
    bs = filter(be -> !(be in Plots._deprecated_backends), bs) # cols
    df = DataFrames.DataFrame(keys=vals)

    for b in bs
        b_supported_vals = ["" for _ in 1:length(vals)]
        for (i, val) in enumerate(vals)
            if func == Plots.supported_seriestypes
                stype = Plots.seriestype_supported(Plots._backend_instance(b), val)
                b_supported_vals[i] = stype == :native ? "✅" : (stype == :no ? "" : "🔼")
            else
                supported = func(Plots._backend_instance(b))

                b_supported_vals[i] = val in supported ? "✅" : ""
            end
        end
        df[!, b] = b_supported_vals
    end
    df
end

function generate_supported_markdown()
    md = open(joinpath(GENDIR, "supported.md"), "w")

    write(md, """
    ## [Series Types](@id supported)

    Key:

    - ✅ the series type is natively supported by the backend.
    - 🔼 the series type is supported through series recipes.


    """)

    write(md, "```@raw html\n")
    write(md,
        to_html(
            make_support_df(
                Plots.all_seriestypes(),
                Plots.supported_seriestypes,
            )
        )
    )
    write(md, "\n```\n\n")

    supported_args =OrderedDict(
        "Keyword Arguments" => (Plots._all_args, Plots.supported_attrs),
        "Markers" => (Plots._allMarkers, Plots.supported_markers),
        "Line Styles" => (Plots._allStyles,  Plots.supported_styles),
        "Scales" => (Plots._allScales,  Plots.supported_scales)
    )

    for (header, args) in supported_args
        write(md, """

        ## $header

        """)

        write(md, "```@raw html\n")
        write(md, to_html(make_support_df(args...)))
        write(md, "\n```\n\n")
    end

    write(md, "\n(Automatically generated: $(now()))")
    close(md)
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
        desc = get(Plots._arg_desc, k, "")
        first_period_idx = findfirst(isequal('.'), desc)

        aliases = sort(collect(keys(filter(p -> p.second == k, Plots._keyAliases))))
        df.Attribute[i] = string(k)
        df.Aliases[i] = join(aliases, ", ")
        if first_period_idx !== nothing
            typedesc = desc[1:first_period_idx-1]
            desc = strip(desc[first_period_idx+1:end])
            df.Default[i] = show_default(def)
            df.Type[i] = string(typedesc)
            df.Description[i] = string(desc)
        end
    end
    sort!(df, [:Attribute])
    return df
end

show_default(x) = string("`", x, "`")
show_default(::Nothing) = "`nothing`"

const ATTRIBUTE_TEXTS = Dict(
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

const ATTRIBUTE_DEFAULTS = Dict(
    :Series => Plots._series_defaults,
    :Plot => Plots._plot_defaults,
    :Subplot => Plots._subplot_defaults,
    :Axis => Plots._axis_defaults,
)

function generate_attr_markdown(c)
    # open the markdown file
    cstr = lowercase(string(c))
    attr_text = ATTRIBUTE_TEXTS[c]
    md = open(joinpath(GENDIR, "attributes_$cstr.md"), "w")

    write(md, """
    ### $c

    $attr_text

    """)

    write(md, "```@raw html\n")
    write(md, to_html(make_attr_df(c, ATTRIBUTE_DEFAULTS[c])))
    write(md, "\n```\n\n")

    write(md, "\n(Automatically generated: $(now()))")
    close(md)
end

function generate_attr_markdown()
    for c in (:Series, :Plot, :Subplot, :Axis)
        generate_attr_markdown(c)
    end
end

function generate_graph_attr_markdown()
    md = open(joinpath(GENDIR, "graph_attributes.md"), "w")

    write(md, """
    # [Graph Attributes](@id graph_attributes)

    Where possible, GraphRecipes will adopt attributes from Plots.jl to format visualizations.
    For example, the `linewidth` attribute from Plots.jl has the same effect in GraphRecipes.
    In order to give the user control over the layout of the graph visualization, GraphRecipes
    provides a number of keyword arguments (attributes). Here we describe those attributes
    alongside their default values.

    """)

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

    write(md, "```@raw html\n")
    write(md, to_html(df))
    write(md, "\n```\n\n")

    write(md, """
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
    """)

    write(md, "\n(Automatically generated: $(now()))")
    close(md)
end

function generate_colorschemes_markdown()
    md = open(joinpath(GENDIR, "colorschemes.md"), "w")

    for line in readlines(normpath(@__DIR__, "..", "docs", "src", "colorschemes.md"))
        write(md, line)
        write(md, "\n")
    end

    write(md, """

    ## misc

    These colorschemes are not defined or provide different colors in ColorSchemes.jl
    They are kept for compatibility with Plots behavior before v1.1.0.

    """)
    write(md, "```@raw html\n")
    write(
        md,
        generate_colorschemes_table(
            [:default; sort(collect(keys(PlotUtils.MISC_COLORSCHEMES)))]
        )
    )
    write(md, "\n```\n\nThe following colorschemes are defined by ColorSchemes.jl.\n\n")
    for cs in ["cmocean", "scientific", "matplotlib", "colorbrewer", "gnuplot", "colorcet", "seaborn", "general"]
        ks = sort([k for (k, v) in PlotUtils.ColorSchemes.colorschemes if occursin(cs, v.category)])
        write(md, "\n\n## $cs\n\n```@raw html\n")
        write(md, generate_colorschemes_table(ks))
        write(md, "\n```\n\n")
    end

    close(md)
end

function colors_svg(cs, w, h)
    n = length(cs)
    ws = min(w / n, h)
    html = """
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.1//EN"
     "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd">
     <svg xmlns="http://www.w3.org/2000/svg" version="1.1"
          width="$(n * ws)mm" height="$(h)mm"
          viewBox="0 0 $n 1" preserveAspectRatio="none"
          shape-rendering="crispEdges" stroke="none">
    """
    for (i, c) in enumerate(cs)
        html *= """
        <rect width="$(ws)mm" height="$(h)mm" x="$(i-1)" y="0" fill="#$(hex(convert(RGB, c)))" />
        """
    end
    html *= "</svg>"
    return html
end

function generate_colorschemes_table(ks)
    extra_dir = get(ENV, "CI", "false") == "true" ? "../" : ""
    html = "<head><link type=\"text/css\" rel=\"stylesheet\" href=\"$(extra_dir)../assets/tables.css\" /></head><body><table><tr class=\"headerrow\">"
    for header in ["NAME", "palette(NAME)", "cgrad(NAME)"]
        html *= "<th>$header</th>"
    end
    html *= "</tr>"
    w, h = 60, 5
    for k in ks
        p = palette(k)
        cg = cgrad(k)[range(0, 1, length = 100)]
        cp = length(p) <= 100 ? color_list(p) : cg
        # cp7 = color_list(palette(k, 7))

        html *= "<tr><td class=\"attr\">:$k</td><td>"
        html *= colors_svg(cp, w, h)
        html *= "</td><td>"
        html *= colors_svg(cg, w, h)
        # html *= "</td><td>"
        # html *= colors_svg(cp7, 35, h)
        html *= "</td></tr>"
    end
    html *= "</table></body>"
    return html
end



# ----------------------------------------------------------------------

function to_html(df::DataFrames.AbstractDataFrame)
    cnames = DataFrames._names(df)
    extra_dir = get(ENV, "CI", "false") == "true" ? "../" : ""
    html = "<head><link type=\"text/css\" rel=\"stylesheet\" href=\"$(extra_dir)../assets/tables.css\" /></head><body><table><tr class=\"headerrow\">"
    for column_name in cnames
        html *= "<th>$column_name</th>"
    end
    html *= "</tr>"
    attrstr = " class=\"attr\""
    for row in 1:size(df,1)
        html *= "<tr>"
        for (i,column_name) in enumerate(cnames)
            data = df[row, i]
            cell = data == nothing ? "" : string(data)
            attrstr = if i == 1
                " class=\"attr\""
            elseif i == length(cnames)
                " class=\"desc\""
            else
                ""
            end
            html *= "<td$attrstr>$(DataFrames.html_escape(cell))</td>"
        end
        html *= "</tr>"
    end
    html *= "</table></body>"
    return html
end

end # module
