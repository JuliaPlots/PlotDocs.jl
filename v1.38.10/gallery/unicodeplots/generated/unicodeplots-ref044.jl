using Plots
unicodeplots()
import FileIO, FreeType  #hide
Plots.reset_defaults()  #hide
using StableRNGs  #hide
rng = StableRNG(1234)  #hide
nothing  #hide

x = -5:0.1:5
plot(plot(x, (x->begin
                x ^ 2
            end)), plot(x, (x->begin
                sin(x)
            end)), layout = 2, link = :y)

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

