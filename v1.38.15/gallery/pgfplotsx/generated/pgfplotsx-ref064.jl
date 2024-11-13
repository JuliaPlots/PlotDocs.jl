using Plots
pgfplotsx()

Plots.reset_defaults()  #hide
using StableRNGs  #hide
rng = StableRNG(1234)  #hide
nothing  #hide

legs = (:topleft, :top, :topright, :left, :inside, :right, :bottomleft, :bottom, :bottomright)
leg_plots(; kw...) = begin
        map((leg->begin
                    plot([0:1, reverse(0:1)]; marker = :circle, ticks = :none, leg_title = leg, leg, kw...)
                end), legs)
    end
(w, h) = Plots._plot_defaults[:size]
with(scalefonts = 0.5, size = (2w, 2h)) do
    plot(leg_plots()..., leg_plots(legend_column = -1)...; layout = (6, 3))
end

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

