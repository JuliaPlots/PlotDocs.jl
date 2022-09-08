# PlotDocs.jl

Documentation for [Plots.jl](https://github.com/tbreloff/Plots.jl)

## Editing the Docs

To edit the documentation, simply edit the Markdown files in [docs/src](https://github.com/JuliaPlots/PlotDocs.jl/tree/master/docs/src). [Documenter.jl](https://github.com/JuliaDocs/Documenter.jl) will automatically rebuild the documentation when changes are merged to master.
The new documentation files will be pushed to the [`gh-pages`](https://github.com/JuliaPlots/PlotDocs.jl/tree/gh-pages) branch in this repository (useful for debugging the `Plots.jl` documentation  build through CI).

## Building the docs

With proper dependencies installed, run `GKSwstype=nul julia --project=docs/ docs/make.jl`.

## Contributing demos

The demos are valid julia scripts written with [Literate markup syntax][literate_syntax] and managed
by [DemoCards.jl][democards_jl]. The following steps shows a common workflow to add demos:

1. create your julia script in any sub-folder in `docs/user_gallery/`. For instance,
   `docs/user_gallery/misc/gr_lorenz_attractor.jl`.
2. configure the demo using [DemoCards YAML frontmatter][yaml_frontmatter]. You may also check how
   other demos are configured as a reference.
3. write the demo in Julia with the Literate markup syntax.
3. activate the docs environment and add `PlotDocs.jl` to the environment via `import Pkg; Pkg.activate("docs"); Pkg.dev(".")`
4. preview the demo using [`DemoCards.preview_demos` feature][democards_preview]. For instance, you
   can partially build one single file via
   `preview_demos("docs/user_gallery/misc/gr_lorenz_attractor.jl")`, or the entire section via
   `preview_demos("docs/user_gallery/misc")`, or even the entire page via
   `preview_demos("docs/user_gallery")`.

[literate_syntax]: https://fredrikekre.github.io/Literate.jl/v2/fileformat/
[yaml_frontmatter]: https://johnnychen94.github.io/DemoCards.jl/stable/quickstart/usage_example/julia_demos/1.julia_demo/#juliademocard_example
[democards_jl]: https://github.com/johnnychen94/DemoCards.jl
[democards_preview]: https://johnnychen94.github.io/DemoCards.jl/stable/preview/
