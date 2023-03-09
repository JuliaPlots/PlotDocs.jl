using Plots
gaston()

Plots.reset_defaults()  #hide
using StableRNGs  #hide
rng = StableRNG(1234)  #hide
nothing  #hide

plot([rand(rng, 10), rand(rng, 20)], color = [:black :orange], line = (:dot, 4), marker = ([:hex :d], 12, 0.8, Plots.stroke(3, :gray)))

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

