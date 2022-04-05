using Plots
gaston()
Plots.reset_defaults() #hide

using StatsPlots
import RDatasets
singers = RDatasets.dataset("lattice", "singer")
@df singers violin(:VoicePart, :Height, line = 0, fill = (0.2, :blue))
@df singers boxplot!(:VoicePart, :Height, line = (2, :black), fill = (0.3, :orange))

png("assets/gaston_ex30") #hide

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

