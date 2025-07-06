using Plots
const PlotsBase = Plots.PlotsBase  #hide
gr()

PlotsBase.reset_defaults()  #hide
using StableRNGs  #hide
rng = StableRNG(1234)  #hide

l = @layout([a{0.1h}; b [c; d e]])
plot(randn(rng, 100, 5), layout = l, t = [:line :histogram :scatter :steppre :bar], leg = false, ticks = nothing, border = :none)
current()  #hide

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl
