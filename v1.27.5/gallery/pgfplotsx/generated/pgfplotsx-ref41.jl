using Plots
pgfplotsx()
Plots.reset_defaults()  # hide

begin
    using StaticArrays, OffsetArrays
    sv = SVector{10}(rand(10))
    ov = OffsetVector(rand(10), -2)
    plot([sv, ov], label = ["StaticArray" "OffsetArray"])
    plot!(3ov, ribbon = ov, label = "OffsetArray ribbon")
end

mkpath("assets")  # hide
png("assets/pgfplotsx_ex41.png")  # hide

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

