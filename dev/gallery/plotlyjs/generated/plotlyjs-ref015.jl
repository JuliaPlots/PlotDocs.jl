using Plots
const PlotsBase = Plots.PlotsBase  #hide
plotlyjs()

PlotsBase.reset_defaults()  #hide
using StableRNGs  #hide
rng = StableRNG(1234)  #hide
nothing  #hide

histogram(randn(rng, 1000), bins = :scott, weights = repeat(1:5, outer = 200))
nothing  #hide

  #hide

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl
