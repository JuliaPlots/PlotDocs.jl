
module PlotDocs


using Plots
import Plots: _examples

export
  generate_markdown

const DOCDIR = joinpath(Pkg.dir("PlotDocs"), "docs", "examples")
const IMGDIR = joinpath(DOCDIR, "img")


function createStringOfMarkDownCodeValues(arr, prefix = "")
  string("`", prefix, join(sort(map(string, arr)), "`, `$prefix"), "`")
end
createStringOfMarkDownSymbols(arr) = isempty(arr) ? "" : createStringOfMarkDownCodeValues(arr, ":")


function generate_markdown(pkgname::Symbol; skip = [])

  # set up the backend, and don't show the plots by default
  pkg = backend(pkgname)
  # default(:show, false)
  default(reuse = true)

  # mkdir if necessary
  pkgdir = joinpath(IMGDIR, string(pkgname))
  try
    mkdir(pkgdir)
  end

  # open the markdown file
  md = open("$DOCDIR/$(pkgname).md", "w")

  # write(md, "## Examples for backend: $pkgname\n\n")

  write(md, "### Initialize\n\n```julia\nusing Plots\n$(pkgname)()\n```\n\n")


  for (i,example) in enumerate(_examples)

    i in skip && continue

    try

      # we want to always produce consistent results
      srand(1234)

      # run the code
      map(eval, example.exprs)

      # # save the png
      # imgname = "$(pkgname)_example_$i.png"

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
      write(md, "```julia\n$(join(map(string, example.exprs), "\n"))\n```\n\n")
      write(md, "![](img/$pkgname/$imgname)\n\n")

    catch ex
      # TODO: put error info into markdown?
      warn("Example $pkgname:$i failed with: $ex")
    end

    #
  end

  write(md, "- Supported arguments: $(createStringOfMarkDownCodeValues(supportedArgs(pkg)))\n")
  write(md, "- Supported values for axis: $(createStringOfMarkDownSymbols(supportedAxes(pkg)))\n")
  write(md, "- Supported values for linetype: $(createStringOfMarkDownSymbols(supportedTypes(pkg)))\n")
  write(md, "- Supported values for linestyle: $(createStringOfMarkDownSymbols(supportedStyles(pkg)))\n")
  write(md, "- Supported values for marker: $(createStringOfMarkDownSymbols(supportedMarkers(pkg)))\n")
  write(md, "- Is `subplot`/`subplot!` supported? $(subplotSupported(pkg) ? "Yes" : "No")\n\n")

  write(md, "(Automatically generated: $(now()))")
  close(md)

end


end # module