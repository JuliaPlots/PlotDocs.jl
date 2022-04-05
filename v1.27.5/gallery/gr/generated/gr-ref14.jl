using Plots
gr()
Plots.reset_defaults()  # hide

bar(randn(99))

mkpath("assets")  # hide
png("assets/gr_ex14.png")  # hide

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

