using Plots
pgfplotsx()
Plots.reset_defaults()  #hide

using Dates
heatmap(DateTime.(2016:2020), 1:5, rand(5, 5))

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

