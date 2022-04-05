using Plots
unicodeplots()
Plots.reset_defaults()  # hide

n = 10000
x = exp.(0.1 * randn(n) .+ randn(n) .* im)
histogram2d(x, nbins = (20, 40), show_empty_bins = true, normed = true, aspect_ratio = 1)

mkpath("assets")  # hide
png("assets/unicodeplots_ex38.png")  # hide

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

