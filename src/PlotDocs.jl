
module PlotDocs


using Plots, DataFrames, Latexify, MacroTools, OrderedCollections, Dates
import Plots: _examples

export
    generate_markdown,
    generate_supported_markdown,
    generate_attr_markdown,
    GENDIR

const GENDIR = normpath(@__DIR__, "..", "docs", "src", "generated")
mkpath(GENDIR)

# ----------------------------------------------------------------------

# TODO: Make this work now on julia 1.0:
function pretty_print_expr(io::IO, expr::Expr)
    for arg in rmlines(expr).args
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
        """)
        for expr in example.exprs
            pretty_print_expr(md, expr)
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
    bs = filter(be -> be ∉ [Plots._deprecated_backends; :plotlyjs; :hdf5], bs) # cols
    df = DataFrames.DataFrame(keys = string.('`', vals, '`'))

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
    return string(mdtable(df, latex=false))
end

function generate_supported_markdown()
    md = open(joinpath(GENDIR, "supported.md"), "w")

    write(md, """
    ## [Series Types](@id supported)

    Key:

    - ✅ the series type is natively supported by the backend.
    - 🔼 the series type is supported through series recipes.


    """)
    write(md, make_support_df(Plots.all_seriestypes(), Plots.supported_seriestypes))

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
        write(md, make_support_df(args...))
    end

    write(md, "\n(Automatically generated: $(now()))")
    close(md)
end


# ----------------------------------------------------------------------


function make_attr_df(ktype::Symbol, defs::KW)
    n = length(defs)
    df = DataFrame(
        Attribute = fill("", n),
        Default = fill("", n),
        Type = fill("", n),
        Description = fill("", n),
    )
    for (i, (k, def)) in enumerate(defs)
        desc = get(Plots._arg_desc, k, "")
        first_period_idx = findfirst(isequal('.'), desc)

        aliases = sort(collect(keys(filter(p -> p.second == k, Plots._keyAliases))))
        add = isempty(aliases) ? "" : string(
            "\n*`",
            join(aliases, "`*, *`"),
            "`*"
        )
        df.Attribute[i] = string("`", k, "`", add)
        if first_period_idx !== nothing
            typedesc = desc[1:first_period_idx-1]
            desc = strip(desc[first_period_idx+1:end])

            aliases = join(map(string,aliases), ", ")

            df.Default[i] = string("`", def, "`")
            df.Type[i] = string(typedesc)
            df.Description[i] = string(desc)
        end
    end
    sort!(df, [:Attribute])
    return string(mdtable(df, latex=false))
end

const ATTRIBUTE_TEXTS = Dict(
    :Series => "These attributes apply to individual series (lines, scatters, heatmaps, etc)",
    :Plot => "These attributes apply to the full Plot. (A Plot contains a tree-like layout of Subplots)",
    :Subplot => "These attributes apply to settings for individual Subplots.",
    :Axis => "These attributes apply to an individual Axis in a Subplot (for example the `subplot[:xaxis]`)",
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
    write(md, make_attr_df(c, ATTRIBUTE_DEFAULTS[c]))

    write(md, "\n(Automatically generated: $(now()))")
    close(md)
end

function generate_attr_markdown()
    for c in (:Series, :Plot, :Subplot, :Axis)
        generate_attr_markdown(c)
    end
end

end # module
