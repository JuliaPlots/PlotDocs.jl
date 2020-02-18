# GraphRecipes
[GraphRecipes](https://github.com/JuliaPlots/GraphRecipes.jl) is a collection of recipes for visualizing graphs. Users specify a graph through an adjacency matrix, an adjacency list, or an `AbstractGraph` via [LightGraphs](https://github.com/JuliaGraphs/LightGraphs.jl). GraphRecipes will then use a layout algorithm to produce a visualization of the graph that the user passed.

## Installation
GraphRecipes can be installed with the package manager:
```julia
] add GraphRecipes
```

## Usage
The main user interface is through the fuction `graphplot`:
```julia
using GraphRecipes, Plots

g = [0  1  1;
     1  0  1;
     1  1  0]
graphplot(g)
```
![](https://user-images.githubusercontent.com/8610352/74631816-c9d66e00-51c2-11ea-8f4c-dae28a5a4146.png)

See [Examples](examples.md) for example usages and [Attributes](attributes.md) for an explanation of keyword arguments to the `graphplot` function.
