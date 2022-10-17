using Plots
gaston()
Plots.reset_defaults()  # hide

Θ = range(0, stop = 1.5π, length = 100)
r = abs.(0.1 * randn(100) + sin.(3Θ))
plot(Θ, r, proj = :polar, m = 2)

mkpath("assets")  # hide
png("assets/gaston_ex27.png")  # hide

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

