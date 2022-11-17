using Plots
unicodeplots()
Plots.reset_defaults()  #hide

p = plot([sin, cos], zeros(0), leg = false, xlims = (0, 2π), ylims = (-1, 1))
anim = Animation()
for x = range(0, stop = 2π, length = 20)
    push!(p, x, Float64[sin(x), cos(x)])
    frame(anim)
end

gif(anim, "assets/anim_unicodeplots_ex2.gif")

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

