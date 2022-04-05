using Plots
pgfplotsx()
Plots.reset_defaults() #hide

hspan([1, 2, 3, 4]; label = "hspan", legend = :topleft)
vspan!([2, 3]; alpha = 0.5, label = "vspan")
plot!([0, 2, 3, 5], [-1, 3, 2, 6]; c = :black, lw = 2, label = "line")

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

