using Plots
unicodeplots()
Plots.reset_defaults()  # hide

using StatsPlots
import RDatasets
singers = RDatasets.dataset("lattice", "singer")
@df singers violin(:VoicePart, :Height, line = 0, fill = (0.2, :blue))
@df singers boxplot!(:VoicePart, :Height, line = (2, :black), fill = (0.3, :orange))

mkpath("assets")  # hide
png("assets/unicodeplots_ex30.png")  # hide

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

