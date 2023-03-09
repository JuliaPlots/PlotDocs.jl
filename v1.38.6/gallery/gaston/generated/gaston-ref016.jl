using Plots
gaston()

Plots.reset_defaults()  #hide
using StableRNGs  #hide
rng = StableRNG(1234)  #hide
nothing  #hide

l = @layout([a{0.1h}; b [c; d e]])
plot(randn(rng, 100, 5), layout = l, t = [:line :histogram :scatter :steppre :bar], leg = false, ticks = nothing, border = :none)

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

