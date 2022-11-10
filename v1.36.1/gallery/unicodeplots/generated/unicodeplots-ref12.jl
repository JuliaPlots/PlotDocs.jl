using Plots
unicodeplots()
Plots.reset_defaults()  #hide

styles = filter((s->begin
                s in Plots.supported_styles()
            end), [:solid, :dash, :dot, :dashdot, :dashdotdot])
styles = reshape(styles, 1, length(styles))
plot(cumsum(randn(20, length(styles)), dims = 1), line = (5, styles), label = map(string, styles), legendtitle = "linestyle")

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

