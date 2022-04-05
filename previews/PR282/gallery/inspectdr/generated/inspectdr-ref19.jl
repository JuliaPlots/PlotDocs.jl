using Plots
inspectdr()
Plots.reset_defaults()  # hide

n = 20
hgt = rand(n) .+ 1
bot = randn(n)
openpct = rand(n)
closepct = rand(n)
y = OHLC[(openpct[i] * hgt[i] + bot[i], bot[i] + hgt[i], bot[i], closepct[i] * hgt[i] + bot[i]) for i = 1:n]
ohlc(y)

mkpath("assets")  # hide
png("assets/inspectdr_ex19.png")  # hide

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

