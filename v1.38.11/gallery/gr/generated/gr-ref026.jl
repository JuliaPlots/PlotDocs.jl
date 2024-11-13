using Plots
gr()

Plots.reset_defaults()  #hide
using StableRNGs  #hide
rng = StableRNG(1234)  #hide
nothing  #hide

group = rand(rng, map((i->begin
                    "group $(i)"
                end), 1:4), 100)
plot(rand(rng, 100), layout = @layout([a b; c]), group = group, linetype = [:bar :scatter :steppre], linecolor = :match)

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

