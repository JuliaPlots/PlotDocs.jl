using Plots
plotlyjs()
Plots.reset_defaults()  # hide

scatter(fill(randn(10), 6), fill(randn(10), 6), framestyle = [:box :semi :origin :zerolines :grid :none], title = [":box" ":semi" ":origin" ":zerolines" ":grid" ":none"], color = permutedims(1:6), layout = 6, label = "", markerstrokewidth = 0, ticks = -2:2)

mkpath("assets")  # hide
png("assets/plotlyjs_ex34.png")  # hide

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

