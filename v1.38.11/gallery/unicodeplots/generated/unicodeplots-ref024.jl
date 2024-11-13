using Plots
unicodeplots()
import FileIO, FreeType  #hide
Plots.reset_defaults()  #hide
using StableRNGs  #hide
rng = StableRNG(1234)  #hide
nothing  #hide

n = 100
ts = range(0, stop = 8π, length = n)
z = 1:n
plot(ts .* map(cos, ts), (0.1ts) .* map(sin, ts), z, zcolor = reverse(z), m = (10, 0.8, :blues, Plots.stroke(0)), leg = false, cbar = true, w = 5)
plot!(zeros(n), zeros(n), 1:n, w = 10)

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

