# PlotDocs.jl

Documentation for [Plots.jl](https://github.com/tbreloff/Plots.jl)

## Editing the Docs

To edit the documentation, simply edit the Markdown files in [docs/src](https://github.com/JuliaPlots/PlotDocs.jl/tree/master/docs/src). [Documenter.jl](https://github.com/JuliaDocs/Documenter.jl) will automatically rebuild the documentation when changes are merged to master.
The new documentation files will be pushed to the [`gh-pages`](https://github.com/JuliaPlots/PlotDocs.jl/tree/gh-pages) branch in this repository (useful for debugging the `Plots.jl` documentation  build through CI).

## Building the docs

With proper dependencies installed, run `GKSwstype=nul julia --project=docs/ docs/make.jl`.

## Contributing demos

The demos are julia scripts written with [Literate syntax](https://fredrikekre.github.io/Literate.jl/v2/fileformat/) and managed
by [DemoCards.jl](https://github.com/johnnychen94/DemoCards.jl). The following steps shows a common workflow to add
demos, take GR backend as an example:

1. create your julia script in any sub-folder in `docs/galleries/gr`. Say the file is `docs/galleries/gr/sec/file.jl`.
2. configure the demo using YAML frontmatter. You may check how other demos are configured as a reference.
3. write the demo in Julia using Literate syntax, you can interactively check the execution result using your favorite editor, e.g., VSCode.
4. preview the demo using `DemoCards.preview_demos("docs/galleries/gr/sec/file.jl")` for single-file, or
   the entire folder using `DemoCards.preview_demos("docs/galleries/gr/sec")`. This would trigger a [partial building of demos](https://johnnychen94.github.io/DemoCards.jl/stable/preview/).

The demo dependencies are managed by `docs/Project.toml`. To ensure reproducibility, you should run the demo in the `docs` environment,
e.g., start your julia with `julia --project=docs`.
