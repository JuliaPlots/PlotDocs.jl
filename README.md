# WARNING

[PlotDocs](https://github.com/JuliaPlots/PlotDocs.jl) is now integrated into [Plots.jl](https://github.com/JuliaPlots/Plots.jl ) [v1](https://github.com/JuliaPlots/Plots.jl/tree/master/docs) or [v2](https://github.com/JuliaPlots/Plots.jl/tree/v2/docs), please make corresponding PRs or open issues there.

# Documentation deployment notes
We only use the `gh-pages` branch of this repository to host the documentation (`stable`, `dev` and `preview`s) for Plots.

The old versions of the docs are kept in the branch `old-gh-pages`:

**DO NOT** delete these !

Trigger the [Plots.jl docs building workflow](https://github.com/JuliaPlots/Plots.jl/actions/workflows/docs.yml) event on a specific tag in order to build the docs for a new release.
