using Plots
const PlotsBase = Plots.PlotsBase  #hide
plotlyjs()

PlotsBase.reset_defaults()  #hide
using StableRNGs  #hide
rng = StableRNG(1234)  #hide
nothing  #hide

plot(PlotsBase.fakedata(rng, 100, 10), layout = 4, palette = cgrad.([:grays :blues :heat :lightrainbow]), bg_inside = [:orange :pink :darkblue :black])
nothing  #hide

  #hide

using Random
Random.seed!(111)
plot!(PlotsBase.fakedata(rng, 100, 10))
nothing  #hide

  #hide

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl
