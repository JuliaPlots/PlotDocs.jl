using Plots
unicodeplots()
Plots.reset_defaults()  # hide

plot(Plots.fakedata(100, 10), layout = 4, palette = cgrad.([:grays :blues :heat :lightrainbow]), bg_inside = [:orange :pink :darkblue :black])

mkpath("assets")  # hide
png("assets/unicodeplots_ex17.png")  # hide

using Random
Random.seed!(111)
plot!(Plots.fakedata(100, 10))

mkpath("assets")  # hide
png("assets/unicodeplots_ex18.png")  # hide

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

