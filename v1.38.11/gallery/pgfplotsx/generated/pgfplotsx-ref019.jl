using Plots
pgfplotsx()

Plots.reset_defaults()  #hide
using StableRNGs  #hide
rng = StableRNG(1234)  #hide
nothing  #hide

n = 20
hgt = rand(rng, n) .+ 1
bot = randn(rng, n)
openpct = rand(rng, n)
closepct = rand(rng, n)
y = OHLC[(openpct[i] * hgt[i] + bot[i], bot[i] + hgt[i], bot[i], closepct[i] * hgt[i] + bot[i]) for i = 1:n]
ohlc(y)

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

