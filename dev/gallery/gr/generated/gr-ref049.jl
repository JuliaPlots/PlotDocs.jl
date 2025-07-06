using Plots
const PlotsBase = Plots.PlotsBase  #hide
gr()

PlotsBase.reset_defaults()  #hide
using StableRNGs  #hide
rng = StableRNG(1234)  #hide

θ = range(0, 2π; length = 100)
ρ = range(0, 120; length = 50)
z = sin.(ρ ./ 10) .* (cos.(θ))'
heatmap(θ, ρ, z; projection = :polar, color = :cividis, right_margin = 2 * PlotsBase.mm)
current()  #hide

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl
