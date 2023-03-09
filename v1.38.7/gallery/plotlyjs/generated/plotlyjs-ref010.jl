using Plots
plotlyjs()

Plots.reset_defaults()  #hide
using StableRNGs  #hide
rng = StableRNG(1234)  #hide
nothing  #hide

histogram2d(randn(rng, 10000), randn(rng, 10000), nbins = 20)

nothing  #hide

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

