using Plots
plotlyjs()
Plots.reset_defaults()  #hide

plot(sin, (x->begin
            sin(2x)
        end), 0, 2π, line = 4, leg = false, fill = (0, :orange))

nothing#hide

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

