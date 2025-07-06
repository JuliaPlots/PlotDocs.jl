using Plots
const PlotsBase = Plots.PlotsBase  #hide
pythonplot()

PlotsBase.reset_defaults()  #hide
using StableRNGs  #hide
rng = StableRNG(1234)  #hide

using TestImages
img = testimage("lighthouse")
plot([-π, π], [-1, 1], reverse(img, dims = 1), yflip = false, aspect_ratio = :none)
plot!(sin, -π, π, lw = 3, color = :red)
current()  #hide

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl
