using Plots
gaston()
Plots.reset_defaults() #hide

group = rand(map((i->begin
                    "group $(i)"
                end), 1:4), 100)
plot(rand(100), layout = @layout([a b; c]), group = group, linetype = [:bar :scatter :steppre], linecolor = :match)

png("assets/gaston_ex26") #hide

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

