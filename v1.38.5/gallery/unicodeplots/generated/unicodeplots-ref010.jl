using Plots
unicodeplots()
import FileIO, FreeType  #hide
Plots.reset_defaults()  #hide
using StableRNGs  #hide
rng = StableRNG(1234)  #hide
nothing  #hide

histogram2d(randn(rng, 10000), randn(rng, 10000), nbins = 20)

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

