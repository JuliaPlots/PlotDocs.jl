using Plots
pgfplotsx()
Plots.reset_defaults()  # hide

histogram2d(randn(10000), randn(10000), nbins = 20)

mkpath("assets")  # hide
png("assets/pgfplotsx_ex10.png")  # hide

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

