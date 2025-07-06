using Plots
const PlotsBase = Plots.PlotsBase  #hide
unicodeplots()
import FileIO, FreeType  #hide
PlotsBase.reset_defaults()  #hide
using StableRNGs  #hide
rng = StableRNG(1234)  #hide

using GeometryBasics, Distributions
d = MvNormal([1.0 0.75; 0.75 2.0])
plot([(1, 2), (3, 2), (2, 1), (2, 3)])
scatter!(Point2.(eachcol(rand(rng, d, 1000))), alpha = 0.25)
current()  #hide

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl
