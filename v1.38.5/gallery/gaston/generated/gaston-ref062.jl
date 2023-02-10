using Plots
gaston()

Plots.reset_defaults()  #hide
using StableRNGs  #hide
rng = StableRNG(1234)  #hide
nothing  #hide

y = rand(rng, 10)
plot(y .+ 1, fillrange = y, fillstyle = :/)

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

