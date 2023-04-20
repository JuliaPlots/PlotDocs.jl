using Plots
gr()

Plots.reset_defaults()  #hide
using StableRNGs  #hide
rng = StableRNG(1234)  #hide
nothing  #hide

using LinearAlgebra
with(scalefonts = 0.5) do
    (x, y) = (collect(-6:0.5:10), collect(-8:0.5:8))
    args = (x, y, ((x, y)->begin
                    sinc(norm([x, y]) / π)
                end))
    kw = (xlabel = "x", ylabel = "y", zlabel = "z", grid = true, minorgrid = true)
    plots = [wireframe(args..., title = "wire"; kw...)]
    for ax = (:x, :y, :z)
        push!(plots, wireframe(args..., title = "wire-flip-$(ax)", xflip = ax === :x, yflip = ax === :y, zflip = ax === :z; kw...))
    end
    for ax = (:x, :y, :z)
        push!(plots, wireframe(args..., title = "wire-mirror-$(ax)", xmirror = ax === :x, ymirror = ax === :y, zmirror = ax === :z; kw...))
    end
    plot(plots..., layout = @layout([_ ° _; ° ° °; ° ° °]), margin = 0 * Plots.px)
end

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

