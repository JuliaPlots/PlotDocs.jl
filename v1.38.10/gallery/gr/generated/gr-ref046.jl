using Plots
gr()

Plots.reset_defaults()  #hide
using StableRNGs  #hide
rng = StableRNG(1234)  #hide
nothing  #hide

using GeometryBasics, Distributions
d = MvNormal([1.0 0.75; 0.75 2.0])
plot([(1, 2), (3, 2), (2, 1), (2, 3)])
scatter!(Point2.(eachcol(rand(rng, d, 1000))), alpha = 0.25)

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

