using Plots
gr()
Plots.reset_defaults()  #hide

x = [[-1, 1], [-1, -1], [-1, 1], [1, 1], [1, 1], [-1, -1], [-1, -1], [1, 1], [-1, 1], [-1, -1], [-1, 1], [1, 1]]
y = [[1, 1], [-1, 1], [-1, -1], [-1, 1], [1, 1], [1, 1], [-1, -1], [-1, -1], [1, 1], [-1, 1], [-1, -1], [-1, 1]]
z = [[1, 1], [1, 1], [1, 1], [1, 1], [-1, 1], [-1, 1], [-1, 1], [-1, 1], [-1, -1], [-1, -1], [-1, -1], [-1, -1]]
kw = (aspect_ratio = :equal, label = :none, xlabel = "x", ylabel = "y", zlabel = "z", xlims = (-1.1, 1.1), ylims = (-1.1, 1.1), zlims = (-1.1, 1.1))
plot(plot(x, y, z; proj_type = :ortho, title = "orthographic (isometric)", camera = (45, round(atand(1 / √2); digits = 3)), kw...), plot(x, y, z; proj_type = :persp, title = "perspective (fps)", camera = (0, 0), kw...))

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

