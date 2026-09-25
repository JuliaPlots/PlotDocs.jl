using Plots
const PlotsBase = Plots.PlotsBase  #hide
pgfplotsx()

PlotsBase.reset_defaults()  #hide
using StableRNGs  #hide
rng = StableRNG(1234)  #hide
nothing  #hide

using PlotsBase.Commons
cbar_heatmap(; kw...) = begin
        heatmap(rand(rng, 10, 10); ticks = :none, right_margin = 8mm, kw...)
    end
plot(cbar_heatmap(title = "border color", colorbar_border_color = :red), cbar_heatmap(title = "border width", colorbar_border_width = 3), cbar_heatmap(title = "tick color", colorbar_tick_color = :red), cbar_heatmap(title = "tick width", colorbar_tick_line_width = 3), cbar_heatmap(title = "bar width", colorbar_width = 0.2), cbar_heatmap(title = "bar height", colorbar_height = 0.5), layout = (2, 3), size = (1200, 700))
current()  #hide

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl
