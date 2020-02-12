
### Install

First, add the package

```julia
import Pkg
Pkg.add("Plots")

# if you want the latest features:
Pkg.pkg"add Plots#master"
```

then get any plotting packages you need (obviously, you should get at least one [backend](@ref backends)).

```julia
Pkg.add("PyPlot")
Pkg.add("GR")
Pkg.add("UnicodePlots")
Pkg.add("PlotlyJS")
```

!!! tip
    If you want to use PlotlyJS.jl with plots, you will also need to install ORCA.jl:
    ```julia
    Pkg.add("ORCA")
    ```
    
Finally, you may wish to add some extensions from the [Plots ecosystem](@ref ecosystem):

```julia
Pkg.add("StatsPlots")
Pkg.add("PlotRecipes")
```

---

### Initialize

```julia
using Plots # or StatsPlots, or PlotRecipes
```

[Choose a backend](@ref backends), and optionally override default settings at the same time:

```julia
pyplot(size = (300, 300), legend = false)
```

!!! tip
    Backend methods are lowercase, and match the corresponding backend package name.

!!! tip
    The underlying plotting backends are not imported and initialized immediately, thus they are loaded on demand to reduce dependencies.

!!! tip
    Plots will pick a default backend for you automatically based on what backends are installed. You can override this choice by setting an environment variable in your `~/.juliarc.jl` file: `ENV["PLOTS_DEFAULT_BACKEND"] = "PlotlyJS"`

!!! tip
    You can override standard default values in your `~/.juliarc.jl` file: `PLOTS_DEFAULTS = Dict(:markersize => 10, :legend => false)`


---
