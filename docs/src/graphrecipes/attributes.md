# Graph Attributes
Where possible, GraphRecipes will adopt attributes from Plots.jl to format visualizations.
For example, the `linewidth` attribute from Plots.jl has the same effect in GraphRecipes.
In order to give the user control over the layout of the graph visualization, GraphRecipes
provides a number of keyword arguments (attributes). Here we describe those attributes
alongside their default values.

### `dim = 2`
The number of dimensions in the visualization.

### `T = Float64`
The data type for the coordinates of the graph nodes.
### `curves = true`
Whether or not edges are curved. If `curves == true`, then the edge going from node $s$ to
node $d$ will be defined by a cubic spline passing through three points: (i) node $s$,
(ii) a point `p` that is distance `curvature_scalar` from the average of node $s$ and node
$d$ and (iii) node $d$.
### `curvature_scalar = 0.05`
A scalar that defines how much edges curve, see `curves` for more explanation.
### `root = :top`
For displaying trees, choose from `:top`, `:bottom`, `:left`, `:right`. If you choose
`:top`, then the tree will be plotted from the top down.

### `node_weights = nothing`
The weight of the nodes given by a list of numbers. If `node_weights != nothing`, then the
size of the nodes will be scaled by the `node_weights` vector.
### `names = []`
Names of the nodes given by a list of objects that can be parsed into strings. If the list
is smaller than the number of nodes, then GraphRecipes will cycle around the list.
### `fontsize = 7`
Font size for the node labels and the edge labels.
### `nodeshape = :hexagon`
Shape of the nodes, choose from `:hexagon`, `circle`, `ellipse`, `rect` or `rectangle`.
### `nodesize = 0.1`
The size of nodes in the plot coordinates. Note that if `names` is not empty, then nodes
will be scaled to fit the labels inside them.
### `nodecolor = 1`
The color of the nodes. If `nodecolor` is an integer, then it will be taken from the
current color pallette. Otherwise, the user can pass any color that would be recognised by
the Plots `color` attribute.
### `x = nothing` `y = nothing` `z = nothing`
The coordinates of the nodes.
### `method = :stress`
The method that GraphRecipes uses to produce an optimal layout, choose from `:spectral`,
`:sfdp`, `:circular`, `:shell`, `:stress`, `:spring`, `:tree`, `:buchheim`, `:arcdiagram`
or `:chorddiagram`. See [NetworkLayout](https://github.com/JuliaGraphs/NetworkLayout.jl)
for further details.
### `func = get(_graph_funcs, method, by_axis_local_stress_graph)`
A layout algorithm that can be passed in by the user.
### `shorten = 0.0`
An amount to shorten edges by.
### `axis_buffer = 0.2`
Increase the `xlims` and `ylims`/`zlims` of the plot. Can be useful if part of the graph
sits outside of the default view.
### `layout_kw = Dict{Symbol,Any}()`
A list of keywords to be passed to the layout algorithm, see
[NetworkLayout](https://github.com/JuliaGraphs/NetworkLayout.jl) for a list of keyword
arguments for each algorithm.
### `edgewidth = (s,d,w)->1`
The width of the edge going from $s$ to node $d$ with weight $w$.
### `edgelabel = nothing`
A dictionary of `(s, d) => label`, where `s` is an integer for the source node, `d` is an
integer for the destiny node and `label` is the desired label for the given edge.
Alternatively the user can pass a vector or a matrix describing the edge labels. If you
use a vector or matrix, then either `missing`, `false`, `nothing`, `NaN` or `""` values
will not be displayed.

In the case of multigraphs, triples can be used to define edges.
### `edgelabel_offset = 0.0`
The distance between edge labels and edges.
### `self_edge_size = 0.1`
The size of self edges.
### `edge_label_box = true`
A box around edge labels that avoids intersections between edge labels and the edges that
they are labeling.

## Aliases
Certain keyword arguments have aliases, so GraphRecipes "does what you mean, not
what you say". Here is a list of keyword arguments with their aliases:
```
:curvature_scalar => [:curvaturescalar,:curvature],
:node_weights => [:nodeweights],
:nodeshape => [:node_shape],
:nodesize => [:node_size],
:nodecolor => [:marker_color],
:shorten => [:shorten_edge],
:axis_buffer => [:axisbuffer],
:edgewidth => [:edge_width,:ew],
:edgelabel => [:edge_label,:el],
:edgelabel_offset => [:edgelabeloffset,:elo],
:self_edge_size => [:selfedgesize,:ses],
:edge_label_box => [:edgelabelbox,:edgelabel_box,:elb]
```
So for example, `nodeshape=:rect` and `node_shape=:rect` are equivalent. To see the
available aliases, type `GraphRecipes.graph_aliases`. If you are unhappy with the provided
aliases, then you can add your own:
```julia
using GraphRecipes, Plots

push!(GraphRecipes.graph_aliases[:nodecolor],:nc)

# These two calls produce the same plot, modulo some randomness in the layout.
plot(graphplot([0 1; 0 0], nodecolor=:red), graphplot([0 1; 0 0], nc=:red))
```
