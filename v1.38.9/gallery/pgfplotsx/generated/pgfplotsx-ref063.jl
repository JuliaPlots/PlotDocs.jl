using Plots
pgfplotsx()

Plots.reset_defaults()  #hide
using StableRNGs  #hide
rng = StableRNG(1234)  #hide
nothing  #hide

kw = (; lab = "", title_loc = :left)
x = π:0.1:2π
plot(x, sin.(x), xaxis = "common X label", yaxis = "Y label 1", color = :red, title = "twinx"; kw...)
pl = plot!(twinx(), x, 2 * cos.(x), yaxis = "Y label 2"; kw...)
plot(x, cos.(x), xaxis = "X label 1", yaxis = "common Y label", color = :red, title = "twiny"; kw...)
pr = plot!(twiny(), 2x, cos.(2x), xaxis = "X label 2"; kw...)
plot(pl, pr)

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

