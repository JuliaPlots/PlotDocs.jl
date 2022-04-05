using Plots
pyplot()
Plots.reset_defaults()  # hide

plot(rand(100) / 3, reg = true, fill = (0, :green))

mkpath("assets")  # hide
png("assets/pyplot_ex8.png")  # hide

scatter!(rand(100), markersize = 6, c = :orange)

mkpath("assets")  # hide
png("assets/pyplot_ex9.png")  # hide

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

