using Plots
pgfplotsx()
Plots.reset_defaults()  # hide

plot(Plots.fakedata(100, 10), layout = 4, palette = cgrad.([:grays :blues :heat :lightrainbow]), bg_inside = [:orange :pink :darkblue :black])

mkpath("assets")  # hide
png("assets/pgfplotsx_ex17.png")  # hide

using Random
Random.seed!(111)
plot!(Plots.fakedata(100, 10))

mkpath("assets")  # hide
png("assets/pgfplotsx_ex18.png")  # hide

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

