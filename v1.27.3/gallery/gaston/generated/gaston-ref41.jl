using Plots
gaston()
Plots.reset_defaults() #hide

begin
    using StaticArrays, OffsetArrays
    sv = SVector{10}(rand(10))
    ov = OffsetVector(rand(10), -2)
    plot([sv, ov], label = ["StaticArray" "OffsetArray"])
    plot!(3ov, ribbon = ov, label = "OffsetArray ribbon")
end

png("assets/gaston_ex41") #hide

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

