using Plots
pgfplotsx()

Plots.reset_defaults()  #hide
using StableRNGs  #hide
rng = StableRNG(1234)  #hide
nothing  #hide

linetypes = [:path :steppre :steppost :sticks :scatter]
n = length(linetypes)
x = map((_->begin
                sort(rand(rng, 20))
            end), 1:n)
y = rand(rng, 20, n)
plot(x, y, line = (linetypes, 3), lab = map(string, linetypes), ms = 15)

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

