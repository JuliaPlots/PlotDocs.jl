using Plots
gr()
Plots.reset_defaults()  #hide

x = range(0, 2π, length = 9)
y = 0:4
z = (1:4) .+ (1:8)'
heatmap(x, y, z, projection = :polar)

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

