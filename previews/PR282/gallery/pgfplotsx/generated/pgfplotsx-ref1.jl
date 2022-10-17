using Plots
pgfplotsx()
Plots.reset_defaults()  # hide

plot(Plots.fakedata(50, 5), w = 3)

mkpath("assets")  # hide
png("assets/pgfplotsx_ex1.png")  # hide

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

