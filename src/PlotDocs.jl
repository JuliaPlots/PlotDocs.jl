
module PlotDocs


PRI_url = "https://raw.githubusercontent.com/JuliaPlots/PlotReferenceImages.jl/master/"


using Plots, Dates
import Plots: _examples

export
    generate_markdown,
    save_attr_html_files,
    make_support_df_args,
    make_support_df_types,
    make_support_df_styles,
    make_support_df_markers,
    make_support_df_scales,
    create_support_tables

const BASEDIR = normpath(@__DIR__, "..", "docs", "src")
const DOCDIR = joinpath(BASEDIR, "examples")
const IMGDIR = joinpath(DOCDIR, "img")

# ----------------------------------------------------------------------

# TODO: Make this work now on julia 1.0:
isnotlinenumber(e::LineNumberNode) = false
isnotlinenumber(e) = true
function filter_out_line_numbers!(expr::Expr)
    expr.args = filter(isnotlinenumber, expr.args)
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

function generate_markdown(pkgname::Symbol; skip = get(Plots._backend_skips, pkgname, Int[]))
    # set up the backend, and don't show the plots by default
    pkg = backend(pkgname)
    default(reuse = true)

    # open the markdown file
    md = open("$DOCDIR/$(pkgname).md", "w")

    write(md, "### Initialize\n\n```julia\nusing Plots\n$(pkgname)()\n```\n\n")

    for (i,example) in enumerate(_examples)
        i in skip && continue

        # write out the header, description, code block, and image link
        write(md, "### $(example.header)\n\n")
        write(md, "$(example.desc)\n\n")
        # write(md, "```julia\n$(join(map(string, example.exprs), "\n"))\n```\n\n")
        write(md, "```julia\n")
        for expr in example.exprs
            pretty_print_expr(md, expr)
        end
        write(md, "```\n\n")
        imgpath = joinpath(PRI_url, "PlotDocs", string(pkgname), string("ref", i, i in Plots._animation_examples ? ".gif" : ".png"))
        write(md, "![]($imgpath)\n\n")
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
                b_supported_vals[i] = stype == :native ? "native" : (stype == :no ? "" : "recipe")
            else
                supported = func(Plots._backend_instance(b))

                b_supported_vals[i] = val in supported ? "native" : ""
            end
        end
        df[b] = b_supported_vals
    end
    df
end

make_support_df_args()    = make_support_df(Plots._all_args,   Plots.supported_attrs)
# make_support_df_types()   = make_support_df(Plots._allTypes,   Plots.supported_types)
make_support_df_types()   = make_support_df(Plots.all_seriestypes(),   Plots.supported_seriestypes)
make_support_df_styles()  = make_support_df(Plots._allStyles,  Plots.supported_styles)
make_support_df_markers() = make_support_df(Plots._allMarkers, Plots.supported_markers)
make_support_df_scales()  = make_support_df(Plots._allScales,  Plots.supported_scales)

function create_support_tables()
    funcs = Dict(
        "args" => make_support_df_args, "types" => make_support_df_types,
        "styles" => make_support_df_styles, "markers" => make_support_df_markers,
        "scales" => make_support_df_scales,
    )
    for (s, func) in funcs
       save_html(func(), joinpath(BASEDIR, "supported_$s.html"), :supported)
    end
end


# ----------------------------------------------------------------------


# need dataframes to make html tables, etc easily
# if is_installed("DataFrames")
#     @eval begin
import DataFrames

function save_html(df::DataFrames.AbstractDataFrame, fn = "/tmp/tmp.html", table_style = :attr)
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
            data = df[row, i]
            cell = data == nothing ? "" : string(data)
            if table_style == :attr
                attrstr = if i == 1
                    " class=\"attr\""
                elseif i == length(cnames)
                    " class=\"desc\""
                else
                    ""
                end
            elseif table_style == :supported
                attrstr = if i == 1
                    " class=\"attr\""
                elseif cell == "native"
                    " class=\"supported_native\""
                elseif cell == "recipe"
                    " class=\"supported_recipe\""
                else
                    " class=\"supported_not\""
                end
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
        first_period_idx = findfirst(isequal('.'), desc)

        df[i,1] = k
        if first_period_idx == nothing
            df[i,2] = ""
            df[i,3] = ""
            df[i,4] = ""
            df[i,5] = ""
        else
            typedesc = desc[1:first_period_idx-1]
            desc = strip(desc[first_period_idx+1:end])
            aliases = keys(filter(p->p.second==k, Plots._keyAliases)) |> collect |> sort
            aliases = join(map(string,aliases), ", ")

            df[i,2] = def
            df[i,3] = aliases
            df[i,4] = typedesc
            df[i,5] = desc
        end
    end
    sort!(df, [:Attribute])
    df
end

# for each default dict, save an html file with the attributes table
function save_attr_html_files()
    for (ktype, defs) in [(:Series, Plots._series_defaults),
                          (:Subplot, Plots._subplot_defaults),
                          (:Plot, Plots._plot_defaults),
                          (:Axis, Plots._axis_defaults)]
        fn = joinpath(BASEDIR, "$(lowercase(string(ktype)))_attr.html")
        df = attr_dataframe_from_defaults(ktype, defs)
        save_html(df, fn)
        @info("Wrote html file for $ktype: $fn")
    end
end

#     end
# end

# ----------------------------------------------------------------------

end # module
