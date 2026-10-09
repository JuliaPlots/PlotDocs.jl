using Plots
const PlotsBase = Plots.PlotsBase  #hide
pgfplotsx()

PlotsBase.reset_defaults()  #hide
using StableRNGs  #hide
rng = StableRNG(1234)  #hide
nothing  #hide

plot((plot(rand(rng, 5, 5); label = ["a" "b" "c" "d" "e"], legend_column = c, title = "legend_column = $(c)") for c = (1, 2, 3, -1))...; layout = 4, size = (1000, 700))
current()  #hide

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl
