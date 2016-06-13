
module PlotDocs


using Plots
import Plots: _examples

export
    generate_markdown,
    save_attr_html_files,
    make_support_graph_args,
    make_support_graph_types,
    make_support_graph_styles,
    make_support_graph_markers,
    make_support_graph_scales,
    create_support_graphs

const DOCDIR = Pkg.dir("PlotDocs", "docs", "examples")
const IMGDIR = joinpath(DOCDIR, "img")

# ----------------------------------------------------------------------

function filter_out_line_numbers!(expr::Expr)
    expr.args = filter(e->!isa(e,LineNumberNode), expr.args)
    map(filter_out_line_numbers!, expr.args)
end
filter_out_line_numbers!(v) = nothing


function pretty_print_expr(io::IO, expr::Expr)
    e2 = copy(expr)
    filter_out_line_numbers!(e2)
    for arg in e2.args
        println(io, arg)
    end
end

function markdown_code_to_string(arr, prefix = "")
    string("`", prefix, join(sort(map(string, arr)), "`, `$prefix"), "`")
end
markdown_symbols_to_string(arr) = isempty(arr) ? "" : markdown_code_to_string(arr, ":")

# ----------------------------------------------------------------------

function generate_markdown(pkgname::Symbol; skip = [])
    # set up the backend, and don't show the plots by default
    pkg = backend(pkgname)
    default(reuse = true)

    # mkdir if necessary
    pkgdir = joinpath(IMGDIR, string(pkgname))
    try
        mkdir(pkgdir)
    end

    # open the markdown file
    md = open("$DOCDIR/$(pkgname).md", "w")

    write(md, "### Initialize\n\n```julia\nusing Plots\n$(pkgname)()\n```\n\n")

    for (i,example) in enumerate(_examples)
        i in skip && continue

        try
            # we want to always produce consistent results
            srand(1234)

            # run the code
            map(eval, example.exprs)

            # NOTE: uncomment this to overwrite the images as well
            if i == 2
                imgname = "$(pkgname)_example_$i.gif"
                gif(anim, "$pkgdir/$imgname", fps=15)
            else
                imgname = "$(pkgname)_example_$i.png"
                png("$pkgdir/$imgname")
            end

            # write out the header, description, code block, and image link
            write(md, "### $(example.header)\n\n")
            write(md, "$(example.desc)\n\n")
            # write(md, "```julia\n$(join(map(string, example.exprs), "\n"))\n```\n\n")
            write(md, "```julia\n")
            for expr in example.exprs
                pretty_print_expr(md, expr)
            end
            write(md, "```\n\n")
            write(md, "![](img/$pkgname/$imgname)\n\n")

        catch ex
            # TODO: put error info into markdown?
            warn("Example $pkgname:$i failed with: $ex")
        end
    end

    write(md, "- Supported arguments: $(markdown_code_to_string(supported_args(pkg)))\n")
    write(md, "- Supported values for linetype: $(markdown_symbols_to_string(supported_types(pkg)))\n")
    write(md, "- Supported values for linestyle: $(markdown_symbols_to_string(supported_styles(pkg)))\n")
    write(md, "- Supported values for marker: $(markdown_symbols_to_string(supported_markers(pkg)))\n")

    write(md, "(Automatically generated: $(now()))")
    close(md)
end

# ----------------------------------------------------------------------


# graphs detailing the features that each backend supports

function make_support_graph(allvals, func)
    vals = reverse(sort(allvals))
    bs = sort(backends())
    bs = filter(be -> !(be in Plots._deprecated_backends), bs)
    x, y = map(string, bs), map(string, vals)
    nx, ny = map(length, (x,y))
    z = zeros(ny, nx)
    for i=1:nx, j=1:ny
        if func == Plots.supported_types
            stype = Plots.seriestype_supported(Plots._backend_instance(bs[i]), vals[j])
            z[j,i] = stype == :native ? 1.0 : (stype == :no ? 0.0 : 0.5)
        else
            supported = func(Plots._backend_instance(bs[i]))
            # z[j,i] = float(vals[j] in supported) * (0.4i/nx+0.6)

            # if it's supported, alternate between 0.5 and 1, otherwise 0
            z[j,i] = (vals[j] in supported ? (1 - 0.5*(i%2)) : 0.0)
        end
    end
    lastcolor = func == Plots.supported_types ? RGB(0.98,0.55,0.23) : :steelblue
    # @show func x,y,z
    heatmap(x, y, z,
            # color = ColorGradient([:white, :darkblue]),
            color = [:white, :steelblue,lastcolor],
            line = (1, :black),
            leg = false,
            size = (50nx+50, 35ny+100),
            xrotation = 90,
            aspect_ratio = :equal)
end

make_support_graph_args()    = make_support_graph(Plots._all_args,   Plots.supported_args)
# make_support_graph_types()   = make_support_graph(Plots._allTypes,   Plots.supported_types)
make_support_graph_types()   = make_support_graph(Plots.all_seriestypes(),   Plots.supported_types)
make_support_graph_styles()  = make_support_graph(Plots._allStyles,  Plots.supported_styles)
make_support_graph_markers() = make_support_graph(Plots._allMarkers, Plots.supported_markers)
make_support_graph_scales()  = make_support_graph(Plots._allScales,  Plots.supported_scales)

function create_support_graphs()
    for func in (make_support_graph_args, make_support_graph_types, make_support_graph_styles,
               make_support_graph_markers, make_support_graph_scales)
        plt = func()
        png(Pkg.dir("PlotDocs", "docs", "examples", "img", "supported", "$(string(func))"))
    end
end


# ----------------------------------------------------------------------


# need dataframes to make html tables, etc easily
# if is_installed("DataFrames")
#     @eval begin
import DataFrames

function save_html(df::DataFrames.AbstractDataFrame, fn = "/tmp/tmp.html")
    f = open(fn, "w")
    cnames = DataFrames._names(df)
    write(f, "<head><link type=\"text/css\" rel=\"stylesheet\" href=\"tables.css\" /></head><body><table><tr class=\"headerrow\">")
    for column_name in cnames
        write(f, "<th>$column_name</th>")
    end
    write(f, "</tr>")
    attrstr = " class=\"attr\""
    for row in 1:size(df,1)
        write(f, "<tr>")
        for (i,column_name) in enumerate(cnames)
            cell = string(df[row, column_name])
            attrstr = if i == 1
                " class=\"attr\""
            elseif i == length(cnames)
                " class=\"desc\""
            else
                ""
            end
            write(f, "<td$attrstr>$(DataFrames.html_escape(cell))</td>")
        end
        write(f, "</tr>")
    end
    write(f, "</table></body>")
    close(f)
end

function attr_dataframe_from_defaults(ktype::Symbol, defs::KW)
    df = DataFrames.DataFrame(
        [Symbol,Any,Any,Any,Any],
        [:Attribute, :Default, :Aliases, :Type, :Description],
        length(defs)
    )
    for (i,(k,def)) in enumerate(defs)
        desc = get(Plots._arg_desc, k, "")
        first_period_idx = findfirst(desc, '.')
        typedesc = desc[1:first_period_idx-1]
        desc = strip(desc[first_period_idx+1:end])
        aliases = keys(filter((_,v)->v==k, Plots._keyAliases)) |> collect |> sort
        aliases = join(map(string,aliases), ", ")
        df[i,1] = k
        # df[i,2] = ktype
        df[i,2] = def
        df[i,3] = aliases
        df[i,4] = typedesc
        df[i,5] = desc
    end
    sort!(df, cols = [:Attribute])
    df
end

# for each default dict, save an html file with the attributes table
function save_attr_html_files()
    basedir = Pkg.dir("PlotDocs","docs")
    for (ktype, defs) in [(:Series, Plots._series_defaults),
                          (:Subplot, Plots._subplot_defaults),
                          (:Plot, Plots._plot_defaults),
                          (:Axis, Plots._axis_defaults)]
        fn = joinpath(basedir, "$(lowercase(string(ktype)))_attr.html")
        df = attr_dataframe_from_defaults(ktype, defs)
        save_html(df, fn)
        info("Wrote html file for $ktype: $fn")
    end
end

#     end
# end

# ----------------------------------------------------------------------

end # module