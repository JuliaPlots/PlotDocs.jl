using Plots
gr()
Plots.reset_defaults()  #hide

using StatsPlots, RDatasets
iris = RDatasets.dataset("datasets", "iris")
@df iris scatter(:SepalLength, :SepalWidth, group = :Species, title = "My awesome plot", xlabel = "Length", ylabel = "Width", marker = (0.5, [:cross :hex :star7], 12), bg = RGB(0.2, 0.2, 0.2))

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

