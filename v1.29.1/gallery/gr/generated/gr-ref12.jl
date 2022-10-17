using Plots
gr()
Plots.reset_defaults()  #hide

styles = filter((s->begin
                s in Plots.supported_styles()
            end), [:solid, :dash, :dot, :dashdot, :dashdotdot])
styles = reshape(styles, 1, length(styles))
n = length(styles)
y = cumsum(randn(20, n), dims = 1)
plot(y, line = (5, styles), label = map(string, styles), legendtitle = "linestyle")

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

