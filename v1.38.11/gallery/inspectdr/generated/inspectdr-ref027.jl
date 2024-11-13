using Plots
inspectdr()

Plots.reset_defaults()  #hide
using StableRNGs  #hide
rng = StableRNG(1234)  #hide
nothing  #hide

Θ = range(0, stop = 1.5π, length = 100)
r = abs.(0.1 * randn(rng, 100) + sin.(3Θ))
plot(Θ, r, proj = :polar, m = 2)

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

