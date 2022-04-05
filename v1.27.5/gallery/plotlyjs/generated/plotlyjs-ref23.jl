using Plots
plotlyjs()
Plots.reset_defaults()  # hide

x = ["Nerds", "Hackers", "Scientists"]
y = [0.4, 0.35, 0.25]
pie(x, y, title = "The Julia Community", l = 0.5)

mkpath("assets")  # hide
png("assets/plotlyjs_ex23.png")  # hide

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

