using Plots
gaston()
Plots.reset_defaults() #hide

l = @layout([a{0.1h}; b [c; d e]])
plot(randn(100, 5), layout = l, t = [:line :histogram :scatter :steppre :bar], leg = false, ticks = nothing, border = :none)

png("assets/gaston_ex16") #hide

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

