using Plots
plotlyjs()
Plots.reset_defaults() #hide

n = 10000
x = exp.(0.1 * randn(n) .+ randn(n) .* im)
histogram2d(x, nbins = (20, 40), show_empty_bins = true, normed = true, aspect_ratio = 1)

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

