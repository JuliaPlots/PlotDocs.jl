
### Install

First, add the package

```julia
import Pkg
Pkg.add("Plots")

# if you want the latest features:
Pkg.pkg"add Plots#master"
```

then get any plotting packages you need (obviously, you should get at least one [backend](@ref backends)).


Tier 1 support (alphabetical order) backends:
```julia
Pkg.add("GR")
# Note that GR has additional installation requirements 
# https://gr-framework.org/julia.html#installation

Pkg.add("PGFPlotsX")
# You need to have latex installed on your system 

Pkg.add("PlotlyJS"); Pkg.add("ORCA")
# Note that you only need to add this if you need electron windows and
# additional output formats, otherwise `plotly()` comes shipped with Plots.jl
# In order to have a good experience with Jupyter, refer to plotly-specific
# Jupyter installation jupyter https://github.com/plotly/plotly.py#installation

Pkg.add("PyPlot")
# Depends only on PyPlot package
```

Tier 2 support backends:
```julia
Pkg.add("UnicodePlots")
Pkg.add("InspectDR")
```
Learn more about backends [here](http://docs.juliaplots.org/latest/backends/)


Finally, you may wish to add some extensions from the [Plots ecosystem](@ref ecosystem):

```julia
Pkg.add("StatsPlots")
Pkg.add("GraphRecipes")
```

---

### Initialize

```julia
using Plots # or StatsPlots 
# using GraphRecipes  # if you wish to use GraphRecipes package too
```

[Choose a backend](@ref backends), and optionally override default settings at the same time:

```julia
gr(size = (300, 300), legend = false)  # provide optional defaults
pgfplotsx()
plotly(ticks=:native)                  # plotlyjs for richer saving options, otherwise it is the same
pyplot()                               # backends are selected with lowercase names!
```

!!! tip
    Plots will pick a default backend for you automatically based on what backends are installed. You can override this choice by setting an environment variable in your `~/.juliarc.jl` file: `ENV["PLOTS_DEFAULT_BACKEND"] = "PlotlyJS"`

!!! tip
    You can override standard default values in your `~/.julia/config/startup.jl` file: `PLOTS_DEFAULTS = Dict(:markersize => 10, :legend => false, warn_on_unsupported = false)`
---
