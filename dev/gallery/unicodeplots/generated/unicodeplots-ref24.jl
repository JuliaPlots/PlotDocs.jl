using Plots
unicodeplots()
Plots.reset_defaults()  # hide

n = 100
ts = range(0, stop = 8π, length = n)
x = ts .* map(cos, ts)
y = (0.1ts) .* map(sin, ts)
z = 1:n
plot(x, y, z, zcolor = reverse(z), m = (10, 0.8, :blues, Plots.stroke(0)), leg = false, cbar = true, w = 5)
plot!(zeros(n), zeros(n), 1:n, w = 10)

mkpath("assets")  # hide
png("assets/unicodeplots_ex24.png")  # hide

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

