using Plots
plotlyjs()

PlotsBase.Commons.reset_defaults()  #hide
using StableRNGs  #hide
rng = StableRNG(1234)  #hide
nothing  #hide

styles = filter((s->begin
                s in PlotsBase.supported_styles()
            end), [:solid, :dash, :dot, :dashdot, :dashdotdot])
styles = reshape(styles, 1, length(styles))
plot(cumsum(randn(rng, 20, length(styles)), dims = 1), line = (5, styles), label = map(string, styles), legendtitle = "linestyle")

nothing  #hide

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl