using Plots
plotlyjs()
Plots.reset_defaults() #hide

ys = Vector[rand(10), rand(20)]
plot(ys, color = [:black :orange], line = (:dot, 4), marker = ([:hex :d], 12, 0.8, Plots.stroke(3, :gray)))

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

