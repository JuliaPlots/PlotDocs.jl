using Plots
const PlotsBase = Plots.PlotsBase  #hide
pythonplot()

PlotsBase.reset_defaults()  #hide
using StableRNGs  #hide
rng = StableRNG(1234)  #hide
nothing  #hide

histogram3d(randn(rng, 10000), randn(rng, 10000), bins = 15, color = :viridis)
current()  #hide

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl
