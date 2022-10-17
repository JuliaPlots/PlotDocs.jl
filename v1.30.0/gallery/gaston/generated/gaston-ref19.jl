using Plots
gaston()
Plots.reset_defaults()  #hide

n = 20
hgt = rand(n) .+ 1
bot = randn(n)
openpct = rand(n)
closepct = rand(n)
y = OHLC[(openpct[i] * hgt[i] + bot[i], bot[i] + hgt[i], bot[i], closepct[i] * hgt[i] + bot[i]) for i = 1:n]
ohlc(y)

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

