
### Install

First, add the package

```julia
Pkg.add("Plots")

# if you want the latest features:
Pkg.checkout("Plots")

# or for the bleeding edge:
Pkg.checkout("Plots", "dev")
```

then get any plotting packages you need (obviously, you should get at least one [backend](/backends)).

```julia
Pkg.add("PyPlot")
Pkg.add("GR")
Pkg.add("UnicodePlots")
Pkg.add("PlotlyJS")
```

Finally, you may wish to add some extensions from the [Plots ecosystem](/ecosystem):

```julia
Pkg.add("StatPlots")
Pkg.add("PlotRecipes")
```

---

### Initialize

```julia
using Plots # or StatPlots, or PlotRecipes
```

[Choose a backend](/backends), and optionally override default settings at the same time:

```julia
pyplot(size = (300,300), legend = false)
```

<div style="background-color: lightblue; padding: 10px; border-style: solid; border-width: medium; margin: 10px;">
Tip: Backend methods are lowercase, and match the corresponding backend package name.
</div>

<div style="background-color: lightblue; padding: 10px; border-style: solid; border-width: medium; margin: 10px;">
Tip: The underlying plotting backends are not imported and initialized immediately, thus they are
loaded on demand to reduce dependencies.
</div>

<div style="background-color: lightblue; padding: 10px; border-style: solid; border-width: medium; margin: 10px;">
Tip: Plots will pick a default backend for you automatically based on what backends are installed.  You can
override this choice by setting an environment variable in your ~/.juliarc.jl file: ENV["PLOTS_DEFAULT_BACKEND"] = "PlotlyJS"
</div>

<div style="background-color: lightblue; padding: 10px; border-style: solid; border-width: medium; margin: 10px;">
Tip: You can override standard default values in your ~/.juliarc.jl file: PLOTS_DEFAULTS = Dict(:markersize => 10, :legend => false)
</div>



---
