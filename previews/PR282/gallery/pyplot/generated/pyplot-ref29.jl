using Plots
pyplot()
Plots.reset_defaults()  # hide

using Plots.PlotMeasures
plot(rand(100, 6), layout = @layout([a b; c]), title = ["A" "B" "C"], titlelocation = :left, left_margin = [20mm 0mm], bottom_margin = 10px, xrotation = 60)

mkpath("assets")  # hide
png("assets/pyplot_ex29.png")  # hide

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

