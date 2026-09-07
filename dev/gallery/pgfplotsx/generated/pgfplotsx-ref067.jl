using Plots
const PlotsBase = Plots.PlotsBase  #hide
pgfplotsx()

PlotsBase.reset_defaults()  #hide
using StableRNGs  #hide
rng = StableRNG(1234)  #hide
nothing  #hide

using PlotsBase.Commons
plot(heatmap(rand(rng, 10, 10); colorbar_ticks = [0.2, 0.5, 0.8], colorbar_tick_font_size = 10, right_margin = 8mm, title = "ticks"), heatmap(rand(rng, 10, 10); colorbar_ticks = ([0.2, 0.5, 0.8], ["low", "mid", "high"]), colorbar_tick_font_size = 10, right_margin = 14mm, title = "labels"), layout = (1, 2), size = (900, 500))
current()  #hide

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl
