using Plots
inspectdr()

Plots.reset_defaults()  #hide
using StableRNGs  #hide
rng = StableRNG(1234)  #hide
nothing  #hide

plot(rand(rng, 10, 4), layout = 4, xguide = "x guide", yguide = "y guide", xguidefonthalign = [:left :right :right :left], yguidefontvalign = [:top :bottom :bottom :top], xguideposition = :top, yguideposition = [:right :left :right :left], ymirror = [false true true false], xmirror = [false false true true], legend = false, seriestype = [:bar :scatter :path :stepmid])

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

