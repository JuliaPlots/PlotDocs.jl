using Plots
gr()
Plots.reset_defaults()  # hide

using LinearAlgebra
scalefontsizes(0.4)
(x, y) = (collect(-6:0.5:10), collect(-8:0.5:8))
args = (x, y, ((x, y)->begin
                sinc(norm([x, y]) / π)
            end))
kwargs = Dict(:xlabel => "x", :ylabel => "y", :zlabel => "z", :grid => true, :minorgrid => true)
plots = [wireframe(args..., title = "wire"; kwargs...)]
for ax = (:x, :y, :z)
    push!(plots, wireframe(args..., title = "wire-flip-$(ax)", xflip = ax == :x, yflip = ax == :y, zflip = ax == :z; kwargs...))
end
for ax = (:x, :y, :z)
    push!(plots, wireframe(args..., title = "wire-mirror-$(ax)", xmirror = ax == :x, ymirror = ax == :y, zmirror = ax == :z; kwargs...))
end
plt = plot(plots..., layout = @layout([_ ° _; ° ° °; ° ° °]), margin = 0 * Plots.px)
resetfontsizes()
plt

mkpath("assets")  # hide
png("assets/gr_ex55.png")  # hide

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

