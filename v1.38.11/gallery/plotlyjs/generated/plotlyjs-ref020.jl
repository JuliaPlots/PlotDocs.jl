using Plots
plotlyjs()

Plots.reset_defaults()  #hide
using StableRNGs  #hide
rng = StableRNG(1234)  #hide
nothing  #hide

y = rand(rng, 10)
plot(y, annotations = (3, y[3], Plots.text("this is #3", :left)), leg = false)
annotate!([(5, y[5], ("this is #5", 16, :red, :center)), (10, y[10], ("this is #10", :right, 20, "courier"))])
annotate!([2, 8], y[[2, 8]], ["#2", "#8"])
scatter!(range(2, stop = 8, length = 6), rand(rng, 6), marker = (50, 0.2, :orange), series_annotations = ["series", "annotations", "map", "to", "series", Plots.text("data", :green)])

nothing  #hide

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

