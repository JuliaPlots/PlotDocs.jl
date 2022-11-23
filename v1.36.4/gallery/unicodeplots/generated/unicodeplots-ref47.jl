using Plots
unicodeplots()
Plots.reset_defaults()  #hide

x = [0, 1, 2, 0]
y = [0, 0, 1, 2]
z = [0, 2, 0, 1]
i = [0, 0, 0, 1]
j = [1, 2, 3, 2]
k = [2, 3, 1, 3]
mesh3d(x, y, z; connections = (i, j, k), title = "triangles", xlabel = "x", ylabel = "y", zlabel = "z", legend = :none, margin = 2 * Plots.mm)

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

