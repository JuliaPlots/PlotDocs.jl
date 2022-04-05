using Plots
gr()
Plots.reset_defaults()  # hide

import FileIO
import Downloads
path = Downloads.download("http://juliaplots.org/PlotReferenceImages.jl/Plots/pyplot/0.7.0/ref1.png")
img = FileIO.load(path)
plot(img)

mkpath("assets")  # hide
png("assets/gr_ex6.png")  # hide

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

