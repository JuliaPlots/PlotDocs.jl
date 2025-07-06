using Plots
const PlotsBase = Plots.PlotsBase  #hide
gr()

PlotsBase.reset_defaults()  #hide
using StableRNGs  #hide
rng = StableRNG(1234)  #hide

plot(bar(randn(rng, 10)), bar([0, 3, 5], [1, 2, 6]), legend = false)
current()  #hide

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl
