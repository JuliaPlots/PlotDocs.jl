using Plots
inspectdr()

Plots.reset_defaults()  #hide
using StableRNGs  #hide
rng = StableRNG(1234)  #hide
nothing  #hide

using Random
Random.seed!(111)
tickers = ["IBM", "Google", "Apple", "Intel"]
(N, D) = (10, length(tickers))
weights = rand(rng, N, D)
weights ./= sum(weights, dims = 2)
returns = sort!((1:N) + D * randn(rng, N))
portfoliocomposition(weights, returns, labels = permutedims(tickers))

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

