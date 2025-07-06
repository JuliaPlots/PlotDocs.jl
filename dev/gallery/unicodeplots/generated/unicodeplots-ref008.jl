using Plots
const PlotsBase = Plots.PlotsBase  #hide
unicodeplots()
import FileIO, FreeType  #hide
PlotsBase.reset_defaults()  #hide
using StableRNGs  #hide
rng = StableRNG(1234)  #hide

plot(rand(rng, 100) / 3, reg = true, fill = (0, :green))
current()  #hide

scatter!(rand(rng, 100), markersize = 6, c = :orange)
current()  #hide

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl
