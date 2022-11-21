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

Let's make this plot more presentable with the following attributes:

1. The number of levels can be changed with `levels`. 
2. Besides the title and axes labels, we can also add contour labels via the attribute `contour_labels`, which has the
alias `clabels`. We'll use the LaTeXStrings.jl package to write the function expression in the title. (To install this
package, type `]` and then `add LaTeXStrings` into the REPL.)
3. The colormap can be changed using `seriescolor`, which has the alias `color`, or even `c`. The default colormap is 
`:inferno`, from matplotlib. A full list of colormaps can be found in the [ColorSchemes](@ref colorschemes) section of 
the manual.
4. The colorbar location can be changed with the attribute `colorbar`, alias `cbar`. We can remove it by setting
`cbar=false`.
5. The line width can be changed as with line plots using `linewidth`, or `lw`.

Note that `levels`, `color`, and `contour_labels` need to be specified in `contour`.

```@example contour
using LaTeXStrings

contour(x, y, z, levels=10, color=:turbo, clabels=true, cbar=false, lw=1)
title!(L"Plot of $(3x + y^2)|\sin(x) + \cos(y)|$")
xlabel!(L"x")
ylabel!(L"y")
```

If only black lines are desired, you can set the `color` attribute like so:

```julia
contour(x, y, z, color=[:black])
```

For alternating black and red lines of a specific hex value, you could type `color=[:black, "#E52B50"]`, and so on.

To get a full list of the available values that an attribute can take, type `plotattr("attribute")` into the REPL. For
example, `plotattr("cbar")` shows that it can take either symbols from a predefined list (e.g. `:left` and `:top`), 
which move the colorbar from its default location; or a boolean `true` or `false`, the latter of which hides the 
colorbar.

## Filled Contours

We can also specify that the contours should be filled in. One way to do this is by using the attribute `fill`:

```julia
contour(x, y, z, fill=true)
```

Another way is to use the function `contourf`, along with its mutating version `contourf!`. With filled contour plots,
the attribute `clabels` does not apply.

```@example contour
contourf(x, y, z, levels=20, color=:turbo)
title!(L"(3x + y^2)|\sin(x) + \cos(y)|")
xlabel!(L"x")
ylabel!(L"y")
```


