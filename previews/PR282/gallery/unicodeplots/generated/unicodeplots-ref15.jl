using Plots
unicodeplots()
Plots.reset_defaults()  # hide

histogram(randn(1000), bins = :scott, weights = repeat(1:5, outer = 200))

mkpath("assets")  # hide
png("assets/unicodeplots_ex15.png")  # hide

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

