using Plots
gaston()

Plots.reset_defaults()  #hide
using StableRNGs  #hide
rng = StableRNG(1234)  #hide
nothing  #hide

(x, y) = ([1, 2, 2, 1, 1], [1, 2, 1, 2, 1])
plot(plot([rand(rng, 5); NaN; rand(rng, 5); NaN; rand(rng, 5)]), plot([1, missing, 2, 3], marker = true), plot([x; NaN; x .+ 2], [y; NaN; y .+ 1], arrow = 2), plot([1, 2 + 3im, Inf, 4im, 3, -Inf * im, 0, 3 + 3im], marker = true), legend = false)

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

