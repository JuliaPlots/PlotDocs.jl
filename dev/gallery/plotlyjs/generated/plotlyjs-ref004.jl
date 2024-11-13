using Plots
plotlyjs()

PlotsBase.Commons.reset_defaults()  #hide
using StableRNGs  #hide
rng = StableRNG(1234)  #hide
nothing  #hide

y = rand(rng, 100)
plot(0:10:100, rand(rng, 11, 4), lab = "lines", w = 3, palette = cgrad(:grays), fill = 0, α = 0.6)
scatter!(y, zcolor = abs.(y .- 0.5), m = (:heat, 0.8, PlotsBase.stroke(1, :green)), ms = 10 * abs.(y .- 0.5) .+ 4, lab = "grad")

nothing  #hide

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl
