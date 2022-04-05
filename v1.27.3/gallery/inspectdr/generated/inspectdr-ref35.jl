using Plots
inspectdr()
Plots.reset_defaults() #hide

t = range(0, stop = 1, length = 100)
θ = (6π) .* t
x = t .* cos.(θ)
y = t .* sin.(θ)
p1 = plot(x, y, line_z = t, linewidth = 3, legend = false)
p2 = scatter(x, y, marker_z = (+), color = :bluesreds, legend = false)
plot(p1, p2)

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

