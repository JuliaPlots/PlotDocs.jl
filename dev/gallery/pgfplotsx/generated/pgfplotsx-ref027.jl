using Plots
const PlotsBase = Plots.PlotsBase  #hide
pgfplotsx()

PlotsBase.reset_defaults()  #hide
using StableRNGs  #hide
rng = StableRNG(1234)  #hide

Θ = range(0, stop = 1.5π, length = 100)
r = abs.(0.1 * randn(rng, 100) + sin.(3Θ))
plot(Θ, r, proj = :polar, m = 2)
current()  #hide

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl
