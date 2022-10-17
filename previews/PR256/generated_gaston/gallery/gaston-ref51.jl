using Plots
gaston()
Plots.reset_defaults() #hide

using TestImages
img = testimage("lighthouse")
plot([-π, π], [-1, 1], reverse(img, dims = 1), yflip = false, aspect_ratio = :none)
plot!(sin, -π, π, lw = 3, color = :red)

png("assets/gaston_ex51") #hide

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

