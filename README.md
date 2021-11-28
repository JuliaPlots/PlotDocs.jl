# PlotDocs.jl

Documentation for [Plots.jl](https://github.com/tbreloff/Plots.jl)

## Editing the Docs

To edit the documentation, simply edit the Markdown files in [docs/src](https://github.com/JuliaPlots/PlotDocs.jl/tree/master/docs/src). [Documenter.jl](https://github.com/JuliaDocs/Documenter.jl) will automatically rebuild the documentation when changes are merged to master.
The new documentation files will be pushed to the [`gh-pages`](https://github.com/JuliaPlots/PlotDocs.jl/tree/gh-pages) branch in this repository (useful for debugging the `Plots.jl` documentation  build through CI).

## Building the docs

With proper dependencies installed, run `julia --project=docs/ docs/make.jl`.
