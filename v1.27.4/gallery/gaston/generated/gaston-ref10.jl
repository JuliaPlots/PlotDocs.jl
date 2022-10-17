using Plots
gaston()
Plots.reset_defaults() #hide

histogram2d(randn(10000), randn(10000), nbins = 20)

png("assets/gaston_ex10") #hide

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

