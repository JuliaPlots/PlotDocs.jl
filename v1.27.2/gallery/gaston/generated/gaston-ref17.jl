using Plots
gaston()
Plots.reset_defaults() #hide

plot(Plots.fakedata(100, 10), layout = 4, palette = cgrad.([:grays :blues :heat :lightrainbow]), bg_inside = [:orange :pink :darkblue :black])

png("assets/gaston_ex17") #hide

using Random
Random.seed!(111)
plot!(Plots.fakedata(100, 10))

png("assets/gaston_ex18") #hide

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

