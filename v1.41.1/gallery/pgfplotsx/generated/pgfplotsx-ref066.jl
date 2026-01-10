using Plots
pgfplotsx()

Plots.reset_defaults()  #hide
using StableRNGs  #hide
rng = StableRNG(1234)  #hide
nothing  #hide

plot(bar(-5:5, randn(rng, 10)), bar(-2:2, [2, -2, NaN, -1, 1], color = 1:5), legend = false)
current()  #hide

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl
