using Plots
plotlyjs()
Plots.reset_defaults()  # hide

begin
    x = -5:0.1:5
    plot(plot(x, (x->begin
                    x ^ 2
                end)), plot(x, (x->begin
                    sin(x)
                end)), layout = 2, link = :y)
end

mkpath("assets")  # hide
png("assets/plotlyjs_ex44.png")  # hide

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

