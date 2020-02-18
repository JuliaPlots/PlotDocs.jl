### Undirected graph
Plot an undirected graph with labeled nodes and individual node sizes/colors.
```julia
using GraphRecipes
using Plots

const n = 15
const A = Float64[ rand() < 0.5 ? 0 : rand() for i=1:n, j=1:n]
for i=1:n
    A[i, 1:i-1] = A[1:i-1, i]
    A[i, i] = 0
end

graphplot(A,
          markersize = 0.2,
          node_weights = 1:n,
          markercolor = range(colorant"yellow", stop=colorant"red", length=n),
          names = 1:n,
          fontsize = 10,
          linecolor = :darkgrey
          )
```

![](https://user-images.githubusercontent.com/8610352/74630965-9abefd00-51c0-11ea-921d-f0dc3e8f8651.png)

Now plot the graph in three dimensions.
```julia
graphplot(A,
           node_weights = 1:n,
           markercolor = :darkgray,
           dim = 3,
           markersize = 5,
           linecolor = :darkgrey,
           linealpha = 0.5
       )

```

![](https://user-images.githubusercontent.com/8610352/74630887-7105d600-51c0-11ea-9d1c-3c3c65d728e7.png)

### LightGraphs.jl
You can visualize a `LightGraphs.AbstractGraph` by passing it to `graphplot`.
```julia
using GraphRecipes, Plots
using LightGraphs

g = wheel_graph(10)
graphplot(g, curves=false)
```

![](https://user-images.githubusercontent.com/8610352/74631053-de196b80-51c0-11ea-8cba-ddbdc2c6312f.png)
#### Directed Graphs
I you pass `graphplot` a `LightGraphs.DiGraph` or an asymmetric adjacency matrix, then `graphplot` will use arrows to indicate the direction of the edges. Note that using the `arrow` attribute with the `pyplot` backend will allow you to control the aesthetics of the arrows.
```julia
using GraphRecipes, Plots
g = [0 1 1;
     0 0 1;
     0 1 0]

graphplot(g, names=1:3, curvature_scalar=0.1)
```

![](https://user-images.githubusercontent.com/8610352/74631107-04d7a200-51c1-11ea-87c1-be9cbf1b02eb.png)
#### Edge Labels
Edge labels can be passed via the `edgelabel` keyword argument. You can pass edge labels
as a dictionary of `(si::Int, di::Int) => label`, where `si`, `di` are the indices of the source and destiny nodes for the edge being labeled. Alternatively, you can pass a matrix or a vector of labels. `graphplot` will try to convert any label you pass it into a string unless you pass one of `missing`, `NaN`, `nothing`, `false` or `""`, in which case, `graphplot` will skip the label.

```julia
using GraphRecipes, Plots
using LightGraphs

n = 8
g = wheel_digraph(n)
edgelabel_dict = Dict()
edgelabel_mat = Array{String}(undef, n, n)
for i in 1:n
    for j in 1:n
        edgelabel_mat[i, j] = edgelabel_dict[(i, j)] = string("edge ", i, " to ", j)
    end
end
edgelabel_vec = edgelabel_mat[:]

graphplot(g, names=1:n, edgelabel=edgelabel_dict, curves=false, nodeshape=:rect)  # Or edgelabel=edgelabel_mat, or edgelabel=edgelabel_vec.
```

![](https://user-images.githubusercontent.com/8610352/74631218-4b2d0100-51c1-11ea-8cd0-ecb7daac4ebb.png)
#### Self edges
```julia
using LightGraphs, Plots, GraphRecipes

g = [1 1 1;
     0 0 1;
     0 0 1]

graphplot(DiGraph(g), self_edge_size=0.2)
```
![](https://user-images.githubusercontent.com/8610352/74634698-44a28780-51c9-11ea-849a-bd2d675bea73.png)
#### Multigraphs
```julia
graphplot([[1,1,2,2],[1,1,1],[1]], names="node_".*string.(1:3), nodeshape=:circle, self_edge_size=0.25)
```
![](https://user-images.githubusercontent.com/8610352/74631260-67c93900-51c1-11ea-8f78-057be37388be.png)
#### Arc and chord diagrams

```julia
using LinearAlgebra
using SparseArrays
using GraphRecipes
using Plots

adjmat = Symmetric(sparse(rand(0:1,8,8)))

plot(
    graphplot(adjmat,
              method=:chorddiagram,
              names=[text(string(i), 8) for i in 1:8],
              linecolor=:black,
              fillcolor=:lightgray),

    graphplot(adjmat,
              method=:arcdiagram,
              markersize=0.5,
              linecolor=:black,
              markercolor=:black)
    )

```
![](https://user-images.githubusercontent.com/8610352/74631298-82031700-51c1-11ea-8149-c304ac667cea.png)


#### Julia code -- AST

```julia
using GraphRecipes
using Plots
default(size=(1000, 1000))

code = :(
function mysum(list)
    out = 0
    for value in list
        out += value
    end
    out
end
)

plot(code, fontsize=12, shorten=0.01, axis_buffer=0.15, nodeshape=:rect)

```

![](https://user-images.githubusercontent.com/8610352/74631335-96471400-51c1-11ea-9721-c1167d565417.png)

#### Julia Type Trees

```julia
using GraphRecipes
using Plots
default(size=(1000, 1000))

plot(AbstractFloat, method=:tree, fontsize=10, nodeshape=:ellipse)

```
![](https://user-images.githubusercontent.com/8610352/74631370-ae1e9800-51c1-11ea-9871-99a618e7ba34.png)


#### `AbstractTrees` Trees

```julia
using AbstractTrees

AbstractTrees.children(d::Dict) = [p for p in d]
AbstractTrees.children(p::Pair) = AbstractTrees.children(p[2])
function AbstractTrees.printnode(io::IO, p::Pair)
    str = isempty(AbstractTrees.children(p[2])) ? string(p[1], ": ", p[2]) : string(p[1], ": ")
    print(io, str)
end

d = Dict(:a => 2,:d => Dict(:b => 4,:c => "Hello"),:e => 5.0)

using GraphRecipes
using Plots
default(size=(1000, 1000))

plot(TreePlot(d), method=:tree, fontsize=10, nodeshape=:ellipse)

```
![](https://user-images.githubusercontent.com/8610352/74631477-f1790680-51c1-11ea-878b-b4c92cbf6f85.png)
