```@setup contour
using Plots
Plots.reset_defaults()
```

# [Contour Plots](@id contour)

The easiest way to get started with contour plots is to use the PyPlot backend. With this backend, `contour` can
take in 1D arrays for the X and Y axes and it'll know how to broadcast them, and you can write 2D functions of the
axes variables via broadcasting. PyPlot requires the `PyPlot.jl` package which can be installed by typing `]` and
then `add PyPlot` into the REPL. The first time you call `pyplot()`, Julia may install matplotlib for you.

Let's define some ranges and a function `f(x, y)` to plot. Notice the `'` at the end of the line defining `x`. 
This is the adjoint operator and makes `x` a row vector. You can check the shape of `x` by typing `size(x)`. In the
tutorial, we mentioned that the `@.` macro evaluates whatever is to the right of it in an element-wise manner. More
precisely, the dot `.` is shorthand for broadcasting; since `x` is of size `(1, 100)` and y is of size `(50, )`, 
`z = @. f(x, y)` will broadcast the function `f` over `x` and `y` and yield a matrix of size `(50, 100)`.

```@example contour
using Plots; pyplot()

f(x, y) = (3x + y^2) * abs(sin(x) + cos(y))

x = range(0, 5, length=100)'
y = range(0, 3, length=50)
z = @. f(x, y)
contour(x, y, z)
```

Much like with `plot!` and `scatter!`, the `contour` function also has a mutating version `contour!` which can be
used to modify the plot after it has been generated.

## Common Attributes

Let's make this plot more presentable with attributes. We can change the number of levels with `levels`. 
Besides the title and axes labels, we can also add contour labels via the attribute `contour_labels`. We'll use the 
LaTeXStrings.jl package to write the function expression in the title. (To install this package, type `]` and then 
`add LaTeXStrings` into the REPL.) LaTeX-formatted strings are prepended with `L` right before them.

The default colormap is `:inferno`, from matplotlib. This can be changed using `seriescolor`, which has the alias
`color`, or even `c`. A full list of colormaps can be found in the [ColorSchemes](@ref colorschemes) section of the
manual. A guide to choosing appropriate colormaps for your contour plots can be found 
[here](https://matplotlib.org/stable/tutorials/colors/colormaps.html). As an example, we'll change the colormap from
`:inferno` to `:turbo`.

Note that `levels`, `color`, and `contour_labels` need to be specified in `contour`.

```@example contour
using LaTeXStrings

contour(x, y, z, levels=10, color=:turbo, contour_labels=true)
title!(L"(3x + y^2)|\sin(x) + \cos(y)|")
xlabel!(L"x")
ylabel!(L"y")
```

## Filled Contours

We can also specify that the contours should be filled in. One way to do this is by using the attribute `fill`:

```julia
contour(x, y, z, fill=true)
```

Another way is to use the function `contourf`, along with its mutating version `contourf!`. With filled contour plots,
the attribute `contour_labels` does not apply.

```@example contour
contourf(x, y, z, levels=20, color=:turbo)
title!(L"(3x + y^2)|\sin(x) + \cos(y)|")
xlabel!(L"x")
ylabel!(L"y")
```


