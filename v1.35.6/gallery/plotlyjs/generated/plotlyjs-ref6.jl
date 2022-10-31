using Plots
plotlyjs()
Plots.reset_defaults()  #hide

import Downloads, FileIO
path = Downloads.download("http://juliaplots.org/PlotReferenceImages.jl/Plots/pyplot/0.7.0/ref1.png")
img = FileIO.load(path)
plot(img)

nothing#hide

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

