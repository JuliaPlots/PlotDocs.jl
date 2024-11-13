using Plots
pythonplot()

Plots.reset_defaults()  #hide
using StableRNGs  #hide
rng = StableRNG(1234)  #hide
nothing  #hide

using StaticArrays, OffsetArrays
sv = SVector{10}(rand(rng, 10))
ov = OffsetVector(rand(rng, 10), -2)
plot(Any[sv, ov], label = ["StaticArray" "OffsetArray"])
plot!(3ov, ribbon = ov, label = "OffsetArray ribbon")

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

