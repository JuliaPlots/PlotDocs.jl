using Plots
plotlyjs()
Plots.reset_defaults()  #hide

(x, y) = (["a", "b", "c"], [1, 5, 15])
p = scatter(["a", "b"], ["q", "r"], ms = 8, legend = false, tickfontsize = 20)
annotate!(["a", "b"], ["r", "q"], [text("ar", :top, :left, 50), text("bq", :bottom, :right, 20)])

nothing#hide

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

