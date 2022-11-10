using Plots
gr()
Plots.reset_defaults()  #hide

y = rand(10)
plot(y .+ 1, fillrange = y, fillstyle = :/)

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

