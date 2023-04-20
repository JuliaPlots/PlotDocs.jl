using Plots
pythonplot()

Plots.reset_defaults()  #hide
using StableRNGs  #hide
rng = StableRNG(1234)  #hide
nothing  #hide

plot(rand(rng, 100) / 3, reg = true, fill = (0, :green))

scatter!(rand(rng, 100), markersize = 6, c = :orange)

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

