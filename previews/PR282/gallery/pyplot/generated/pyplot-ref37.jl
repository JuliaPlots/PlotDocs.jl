using Plots
pyplot()
Plots.reset_defaults()  # hide

plot(plot(0:10; ribbon = (LinRange(0, 2, 11), LinRange(0, 1, 11))), plot(0:10; ribbon = 0:0.5:5), plot(0:10; ribbon = sqrt), plot(0:10; ribbon = 1))

mkpath("assets")  # hide
png("assets/pyplot_ex37.png")  # hide

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

