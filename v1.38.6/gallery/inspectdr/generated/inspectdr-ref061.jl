using Plots
inspectdr()

Plots.reset_defaults()  #hide
using StableRNGs  #hide
rng = StableRNG(1234)  #hide
nothing  #hide

curves([1, 2, 3, 4], [1, 1, 2, 4], title = "Bézier curve")

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

