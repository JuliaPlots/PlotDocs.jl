using Plots
gaston()

Plots.reset_defaults()  #hide
using StableRNGs  #hide
rng = StableRNG(1234)  #hide
nothing  #hide

using Dates
heatmap(DateTime.(2016:2020), 1:5, rand(rng, 5, 5))

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

