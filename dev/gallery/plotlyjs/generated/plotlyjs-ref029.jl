using Plots
const PlotsBase = Plots.PlotsBase  #hide
plotlyjs()

PlotsBase.reset_defaults()  #hide
using StableRNGs  #hide
rng = StableRNG(1234)  #hide
nothing  #hide

using PlotsBase.Commons
plot(rand(rng, 100, 6), layout = @layout([a b; c]), title = ["A" "B" "C"], titlelocation = :left, left_margin = [20mm 0mm], bottom_margin = 10px, xrotation = 60)
nothing  #hide

  #hide

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl
