using Plots
gaston()

Plots.reset_defaults()  #hide
using StableRNGs  #hide
rng = StableRNG(1234)  #hide
nothing  #hide

plot(bar([-1, 0, 2, 3], [1, 3, 6, 2], fill_z = 4:-1:1, alpha = [1, 0.2, 0.8, 0.5], label = "", bar_width = 1:4), bar(rand(rng, 5), bar_width = 1.2, alpha = 0.8, color = [:lightsalmon, :tomato, :crimson, :firebrick, :darkred], fillto = 0:-0.1:-0.4, label = "reds"))

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

