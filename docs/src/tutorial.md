```@setup tutorial
using Plots; gr()
Plots.reset_defaults()
```

# [Tutorial](@id tutorial)

This is a guide for getting you up and running with Plots.jl. Its main goal is
to introduce you to the terminology used in the package, how to use Plots.jl in
common use cases, and put you in a position to easily understand the rest of
the manual.

## Basic Plotting: Line Plots

The most basic plots are line plots. Assuming you have installed Plots.jl via
`Pkg.add("Plots")`, you can plot a line by calling `plot` on two vectors of
numbers. For example:

```@example tutorial
using Plots
x = 1:10; y = rand(10); # These are the plotting data
plot(x, y)
```

The plot is displayed in a plot pane, a stand-alone window or the browser,
depending on the environment and backend (see [below](@ref plotting-backends)).

In Plots.jl, every column is a **series**, i.e. a set of related points which
form lines, surfaces, or other plotting primitives. Thus we can plot multiple
lines by plotting a matrix of values and each column is interpreted as a
separate line:

```@example tutorial
x = 1:10; y = rand(10, 2) # 2 columns means two lines
plot(x, y)
```

Additionally, we can add more lines by mutating the plot object. This is done
by the `plot!` command. Let's add another line to our current plot:

```@example tutorial
z = rand(10)
plot!(x, z)
```

Note that we could have done the same as above using an explicit plot variable:

```@example tutorial
x = 1:10; y = rand(10, 2) # 2 columns means two lines
p = plot(x, y)
z = rand(10)
plot!(p, x, z)
```

Note that in the case where `p` is omitted, Plots.jl uses the global
`Plots.CURRENT_PLOT` automatically in the same manner.

## Plot Attributes

In the previous section we made plots... we're done right? No! We need to style
our plots. In Plots.jl, the modifiers to plots are called **attributes**. These
are documented at the [attributes page](@ref attributes). Plots.jl follows a simple
rule with data vs attributes: positional arguments are input data, and keyword
arguments are attributes. Thus something like `plot(x,y,z)` is 3-dimensional
data for 3D plots, while `plot(x,y,attribute=value)` is 2-dimensional with
an attribute.

As an example, we see that from the attributes page that we can increase the
line width using `linewidth` (or its alias `lw`), change the legend's labels
using the `label` command, and add a title with `title`. Let's apply that to our
previous plot:

```@example tutorial
x = 1:10; y = rand(10, 2) # 2 columns means two lines
plot(x, y, title = "Two Lines", label = ["Line 1" "Line 2"], lw = 3)
```

Note that every attribute can also be applied by mutating the plot with a
modifier function. For example, the `xlabel` attribute adds a label for the
x-axis. We can in the plot command specify it via `xlabel=...` like we did above.
Or we can use the modifier function to add it after the plot has already been
generated:

```@example tutorial
xlabel!("My x label")
```

Every modifier function is the name of the attribute followed by `!`. Note that
this implicitly uses the global `Plots.CURRENT_PLOT` and we can apply it to
other plot objects via `attribute!(p,value)`. For more examples of attributes
in action, see the examples pages.

## [Plotting Backends](@id plotting-backends)

Here's a secret: Plots.jl isn't actually a plotting package! Plots.jl is a
plotting metapackage: it's an interface over many different plotting libraries.
Thus what Plots.jl is actually doing is interpreting your commands and then
generating the plots using another plotting library. This plotting library in
the background is referred to as the **backend**. The nice thing about this
is that this means you can use many different plotting libraries all with the
Plots.jl syntax, and we'll see in a little bit that Plots.jl adds new features
to each of these libraries!

When we started plotting above, our plot used the default backend. The default
backend depends on what plotting packages you've installed in Julia. If have not
previously installed any backend packages, this will plot to the browser using
Plotly, or into the REPL using UnicodePlots.jl. However, let's say we want a
standard plotting backend which will plot into a nice GUI or into the plot pane
of Juno. To do this, we'll need a backend which is compatible with these
features. Some common backends for this are PyPlot and GR. To install these
backends, simply use the standard Julia installation
(`Pkg.add("BackendPackage")`). We can specifically choose the backend we are
plotting into by using the name of the backend in all lower case as a function.
Let's plot the example from above using Plotly and then GR (this assumes you've
done `Pkg.add("GR")`!):

```@example tutorial
x = 1:10; y = rand(10, 2) # 2 columns means two lines
plotly() # Set the backend to Plotly
# This plots into the web browser via Plotly
plot(x, y, title = "This is Plotted using Plotly")
png("tutorial_1") # hide
```
![](tutorial_1.png)

```@example tutorial
gr() # Set the backend to GR
# This plots using GR
plot(x, y, title = "This is Plotted using GR")
```

If you're in Juno, the second plot command will cause the plot to open in the
plot pane. If you're in the REPL, GR will open a GUI window. You can always
open a GUI anyways by using the `gui()` command.

Each plotting backend has a very different feel. Some have interactivity, some
are faster and can deal with huge numbers of datapoints, and some can do
3D plots. Saving plots is done by the `savefig` command. As an example:

```julia
savefig("myplot.png") # Saves the CURRENT_PLOT as a .png
savefig(p, "myplot.pdf") # Saves the plot from p as a .pdf vector graphic
```

Some like GR can save to vector graphics and PDFs, while others like Plotly only save to `.png`s. For more information on backends, see the
[backends page](@ref backends). For examples of plots from the various backends, see
the Examples section.

## Changing the Plotting Series

At this point you're a master of lines, but don't you want to plot your data
in other ways? In Plots.jl, these other ways of plotting a series is called a
**series type**. A line is one series type. However, a scatter plot is another
series type which is commonly used. We can change the series type by the
`seriestype` attribute:

```@example tutorial
gr() # We will continue onward using the GR backend
plot(x, y, seriestype = :scatter, title = "My Scatter Plot")
```

For each built-in series type, there is a shorthand function for directly
calling that series type which matches the name of the series type. It handles
attributes just the same as the `plot` command, and have a mutating form which
ends in `!`. For example, we can instead do that scatter plot with:

```@example tutorial
scatter(x, y, title = "My Scatter Plot")
```

The series types which are available are dependent on the backend, and are
documented on the [Supported Attributes page](@ref supported). As we will describe
later, other libraries can add new series types via **recipes** as well.

## Plotting in Scripts

Now that you're making useful plots, go ahead and add these plotting commands
to a script. Now call the script... and the plot doesn't show up? This is
because Julia in interactive use calls `display` on every variable that is
returned by a command without a `;`. Thus in each case above, the interactive
usage was automatically calling `display` on the returned plot objects.

In a script, Julia does not do automatic displays (which is why `;` is not
necessary). However, if we would like to display our plots in a script, this
means we just need to add the `display` call. For example:

```julia
display(plot(x, y))
```

If we have a plot object `p`, we can do `display(p)` at any time.

## Combining Multiple Plots as Subplots

We can combine multiple plots together as subplots using **layouts**.
There are many methods for doing this, and we will show two simple methods
for generating simple layouts. More advanced layouts are shown in the
[Layouts page](@ref layouts).

The first method is to define a layout which will split a series. The `layout`
command takes in a 2-tuple `layout=(N, M)` which builds an NxM grid of plots.
It will automatically split a series to be in each plot. For example, if we do
`layout=(4,1)` on a plot with four series, then we will get four rows of plots,
each with one series in it:

```@example tutorial
y = rand(10, 4)
plot(x, y, layout = (4, 1))
```

We can also use layouts on plots of plot objects. For example, we can generate
for separate plots and make a single plot that combines them in a 2x2 grid
via the following:

```@example tutorial
p1 = plot(x, y) # Make a line plot
p2 = scatter(x, y) # Make a scatter plot
p3 = plot(x, y, xlabel = "This one is labelled", lw = 3, title = "Subtitle")
p4 = histogram(x, y) # Four histograms each with 10 points? Why not!
plot(p1, p2, p3, p4, layout = (2, 2), legend = false)
```

Notice that the attributes in the individual plots are applied to the
individual plots, while the attributes on the final `plot` call are applied
to all of the subplots.

## Plot Recipes and Recipe Libraries

You now know all of the basic terminology of Plots.jl and can roam the
documentation freely to become a plotting master. However, there is one
thing left: **recipes**. Plotting recipes are extensions to the Plots.jl
framework. They add:

1. New `plot` commands via **user recipes**.
2. Default interpretations of Julia types as plotting data via **type recipes**.
3. New functions for generating plots via **plot recipes**.
4. New series types via **series recipes**.

Writing your own recipes is an advanced topic described on the
[recipes page](@ref recipes). Instead, we will introduce the ways that one uses
a recipe.

Recipes are included in many recipe libraries. Two fundamental recipe libraries
are [PlotRecipes.jl](https://github.com/JuliaPlots/PlotRecipes.jl) and
[StatsPlots.jl](https://github.com/JuliaPlots/StatsPlots.jl). Let's look into
StatsPlots.jl. StatsPlots.jl adds a bunch of recipes, but the ones we'll focus
on are:

1. It adds a type recipe for `Distribution`s.
2. It adds a plot recipe for marginal histograms.
3. It adds a bunch of new statistical plot series.

Besides recipes, StatsPlots.jl also provides a specialized macro from plotting directly
from data tables.

### Using User Recipes

A user recipe says how to interpret plotting commands on a new data type.
In this case, StatsPlots.jl thus has a macro `@df` which allows you to plot
a `DataFrame` directly by using the column names. Let's build a `DataFrame`
with columns `a`, `b`, and `c`, and tell Plots.jl to use `a` as the `x` axis
and plot the series defined by columns `b` and `c`:

```@example tutorial
# Pkg.add("StatsPlots")
using StatsPlots # Required for the DataFrame user recipe
# Now let's create the DataFrame
using DataFrames
df = DataFrame(a = 1:10, b = 10 * rand(10), c = 10 * rand(10))
# Plot the DataFrame by declaring the points by the column names
@df df plot(:a, [:b :c]) # x = :a, y = [:b :c]. Notice this is two columns!
```

Notice there's not much you have to do here: all of the commands from before
(attributes, series types, etc.) will still work on this data:

```@example tutorial
@df df scatter(:a, :b, title = "My DataFrame Scatter Plot!") # x = :a, y = :b
```

### Using a Type Recipe

In addition, StatsPlots.jl extends Distributions.jl by adding a type recipe
for its distribution types, so they can be directly interpreted as plotting
data:

```@example tutorial
using Distributions
plot(Normal(3, 5), lw = 3)
```

Thus type recipes are a very convenient way to plot a specialized type which
requires no more intervention!

### Using Plot Recipes

StatsPlots.jl adds the `marginhist` multiplot via a plot recipe. For our data
we will pull in the famous `iris` dataset from RDatasets:

```@example tutorial
#Pkg.add("RDatasets")
using RDatasets, StatsPlots
iris = dataset("datasets", "iris")
@df iris marginalhist(:PetalLength, :PetalWidth)
```

Here `iris` is a Dataframe, using the `@df` macro on `Dataframe`s described above,
we give `marginalhist(x, y)` the data from the `PetalLength` and the `PetalWidth`
columns.

This demonstrates two important facts. Notice that this is more than a series
since it generates multiple series (i.e. there are multiple plots due to the
hists on the top and right). Thus a plot recipe is not just a series but instead
something like a new `plot` command.

### Using Series Recipes

StatsPlots.jl also introduces new series recipes. The key is that you don't have
to do anything differently: after `using StatsPlots` you can simply use those
new series recipes as though they were built into the plotting libraries. Let's
use the Violin plot on some random data:

```@example tutorial
y = rand(100, 4) # Four series of 100 points each
violin(["Series 1" "Series 2" "Series 3" "Series 4"], y, leg = false)
```

and we can add a `boxplot` on top using the same mutation commands as before:

```@example tutorial
boxplot!(["Series 1" "Series 2" "Series 3" "Series 4"], y, leg = false)
```

## Additional Addons To Try

Given the easy extendability of Plots.jl, there are many other things you can
try. Here's a short list of very usable addons to check out:

- [PlotThemes.jl](https://github.com/JuliaPlots/PlotThemes.jl) allows you to
  change the color scheme of your plots. For example, `theme(:dark)` adds a
  dark theme.
- [StatsPlots.jl](https://github.com/JuliaPlots/StatsPlots.jl) adds functionality for visualizations of statistical analysis
- The [ecosystem page](@ref ecosystem) shows many other packages which have recipes
  and extend Plots.jl's functionality.
