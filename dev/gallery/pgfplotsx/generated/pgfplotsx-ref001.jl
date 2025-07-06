using Plots
const PlotsBase = Plots.PlotsBase  #hide
pgfplotsx()

PlotsBase.reset_defaults()  #hide
using StableRNGs  #hide
rng = StableRNG(1234)  #hide

plot(PlotsBase.fakedata(rng, 50, 5), w = 3)
current()  #hide

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl
