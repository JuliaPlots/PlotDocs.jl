using Plots
const PlotsBase = Plots.PlotsBase  #hide
gr()

PlotsBase.reset_defaults()  #hide
using StableRNGs  #hide
rng = StableRNG(1234)  #hide

using Dates
heatmap(DateTime.(2016:2020), 1:5, rand(rng, 5, 5))
current()  #hide

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl
