using Plots
gaston()
Plots.reset_defaults() #hide

plot(rand(100) / 3, reg = true, fill = (0, :green))

png("assets/gaston_ex8") #hide

scatter!(rand(100), markersize = 6, c = :orange)

png("assets/gaston_ex9") #hide

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

