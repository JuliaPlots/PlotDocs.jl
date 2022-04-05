using Plots
inspectdr()
Plots.reset_defaults()  # hide

x = 1:5
y = [1, 2, 3, 2, 1]
default(shape = :circle)
plot(plot(x, y, markershape = :circle, seriestype = :steppre, label = "steppre"), plot(x, y, markershape = :circle, seriestype = :stepmid, label = "stepmid"), plot(x, y, markershape = :circle, seriestype = :steppost, label = "steppost"), layout = (3, 1))

mkpath("assets")  # hide
png("assets/inspectdr_ex53.png")  # hide

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

