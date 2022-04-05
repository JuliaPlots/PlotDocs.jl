using Plots
gaston()
Plots.reset_defaults() #hide

import FileIO
import Downloads
path = Downloads.download("http://juliaplots.org/PlotReferenceImages.jl/Plots/pyplot/0.7.0/ref1.png")
img = FileIO.load(path)
plot(img)

png("assets/gaston_ex6") #hide

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

