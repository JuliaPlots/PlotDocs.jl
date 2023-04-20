using Plots
pythonplot()

Plots.reset_defaults()  #hide
using StableRNGs  #hide
rng = StableRNG(1234)  #hide
nothing  #hide

scatter(fill(randn(rng, 10), 6), fill(randn(rng, 10), 6), framestyle = [:box :semi :origin :zerolines :grid :none], title = [":box" ":semi" ":origin" ":zerolines" ":grid" ":none"], color = permutedims(1:6), layout = 6, label = "", markerstrokewidth = 0, ticks = -2:2)

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

