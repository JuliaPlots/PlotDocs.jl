# ---
# title: Line Plot 2D
# cover: assets/line_plot_2d.png
# author: "[goropikari](https://github.com/goropikari)"
# date: 2021-08-11
# ---

using Plots
gr()

x = 0:0.1:2pi
y1 = cos.(x)
y2 = sin.(x)

plot(x, y1, c="blue", linewidth=3)
plot!(x, y2, c="red", line=:dash)
title!("Trigonometric functions")
xlabel!("angle")
ylabel!("sin(x) and cos(x)")

## axis limit
plot!(xlims=(0,2pi), ylims=(-2, 2))

# An equivalent way to draw the same plot

x = 0:0.1:2pi
y1 = cos.(x)
y2 = sin.(x)

plot(x, y1,
    c="blue",
    linewidth=3,
    title="Trigonometric functions",
    xlabel="angle",
    ylabel="sin(x) and cos(x)")
plot!(x, y2, c="red", line=:dash)

plot!(xlims=(0,2pi), ylims=(-2, 2))

# save cover image #src
mkpath("assets") #src
savefig("assets/line_plot_2d.png") #src
