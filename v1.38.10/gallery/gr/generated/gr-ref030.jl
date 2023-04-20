using Plots
gr()

Plots.reset_defaults()  #hide
using StableRNGs  #hide
rng = StableRNG(1234)  #hide
nothing  #hide

using StatsPlots, RDatasets
singers = RDatasets.dataset("lattice", "singer")
@df singers violin(:VoicePart, :Height, line = 0, fill = (0.2, :blue))
@df singers boxplot!(:VoicePart, :Height, line = (2, :black), fill = (0.3, :orange))

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

