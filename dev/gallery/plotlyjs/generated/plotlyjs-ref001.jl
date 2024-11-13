using Plots
plotlyjs()

PlotsBase.Commons.reset_defaults()  #hide
using StableRNGs  #hide
rng = StableRNG(1234)  #hide
nothing  #hide

plot(PlotsBase.fakedata(rng, 50, 5), w = 3)

nothing  #hide

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl