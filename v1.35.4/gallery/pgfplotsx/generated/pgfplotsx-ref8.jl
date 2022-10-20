using Plots
pgfplotsx()
Plots.reset_defaults()  #hide

plot(rand(100) / 3, reg = true, fill = (0, :green))

scatter!(rand(100), markersize = 6, c = :orange)

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

