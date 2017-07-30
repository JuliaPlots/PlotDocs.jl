
# Tutorial

This is a guide for getting you up and running with Plots.jl. Its main goal is
to introduce you to the terminology used in the package, how to use Plots.jl in
common use cases, and put you in a position to easily understand the rest of
the manual.

## Basic Plotting: Line Plots

The most basic plots are line plots. Assuming you have installed Plots.jl via
`Pkg.add("Plots")`, you can plot a line by calling `plot` on two vectors of
numbers. For example:

```julia
using Plots
x = 1:10; y = rand(10) # These are the plotting data
plot(x,y)
```

![first_plot](https://user-images.githubusercontent.com/1814174/28752263-dc198750-74cf-11e7-9d96-c61affb655d8.png)

In Plots.jl, every column is a **series**, i.e. a set of related points which
for lines, surfaces, or other plotting primitives. Thus we can plot multiple
lines by plotting a matrix of values and each column is interpreted as a
separate line:

```julia
x = 1:10; y = rand(10,2) # 2 columns means two lines
plot(x,y)
```

![twoseries_plot](https://user-images.githubusercontent.com/1814174/28752268-f32e269e-74cf-11e7-9074-ffbd1730e7f7.png)

Additionally, we can add more lines by mutating the plot object. This is done
by the `plot!` command. Let's add another line to our current plot:

```julia
z = rand(10)
plot!(x,z)
```

![addline_plot](https://user-images.githubusercontent.com/1814174/28752269-047910e4-74d0-11e7-8059-7c20facabd49.png)

Note that we could have done the same as above using an explicit plot variable:

```julia
x = 1:10; y = rand(10,2) # 2 columns means two lines
p = plot(x,y)
z = rand(10)
plot!(p,x,z)
```

![explicit_p_plot](https://user-images.githubusercontent.com/1814174/28752272-15f7a3ee-74d0-11e7-811c-847f33437b9d.png)

Note that in the case where `p` is omitted, Plots.jl uses the global
`Plots.CURRENT_PLOT` automatically in the same manner.

## Plot Attributes

In the previous section we made plots... we're done right? No! We need to style
our plots. In Plots.jl, the modifiers to plots are called **attributes**. These
are documented at the [attributes page](/attributes). Plots.jl follows a simple
rule with data vs attributes: positional arguments are input data, and keyword
arguments are attributes. Thus something like `plot(x,y,z)` is 3-dimensional
data for 3D plots, while `plot(x,y,attribute=value)` is 2-dimensional with
an attribute.

As an example, we see that from the attributes page that we can increase the
line width using `line_width` (or its alias `lw`), change the legend's labels
using the `label` command, and add a title with `title`. Let's apply that to our
previous plot:

```julia
x = 1:10; y = rand(10,2) # 2 columns means two lines
plot(x,y,title="Two Lines",label=["Line 1" "Line 2"],lw=3)
```

![first_attributes_plot](https://user-images.githubusercontent.com/1814174/28752275-29e0f4dc-74d0-11e7-843d-f50d499ca772.png)

Note that every attribute can also be applied by mutating the plot with a
modifier function. For example, the `xlabel` attribute adds a label for the
x-axis. We can in the plot command specify it via `xlabel=...` like we did above.
Or we can use the modifier function to add it after the plot has already been
generated:

```julia
xlabel!("My x label")
```

![add_x_label_plot](https://user-images.githubusercontent.com/1814174/28752277-399e3830-74d0-11e7-9eb8-db337b3164a1.png)

Every modifier function is the name of the attribute followed by `!`. Note that
this implicitly uses the global `Plots.CURRENT_PLOT` and we can apply it to
other plot objects via `attribute!(p,value)`. For more examples of attributes
in action, see the examples pages like the [PyPlot examples](/examples/pyplot).

## Plotting Backends

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

```julia
x = 1:10; y = rand(10,2) # 2 columns means two lines
plotly() # Set the backend to Plotly
plot(x,y,title="This is Plotted using Plotly") # This plots into the web browser via Plotly
gr() # Set the backend to GR
plot(x,y,title="This is Plotted using GR") # This plots using GR
```

![plotly_plot](https://user-images.githubusercontent.com/1814174/28752391-55d2d860-74d2-11e7-824b-ca67d8485c66.png)

![gr_plot](https://user-images.githubusercontent.com/1814174/28752685-5863cdf2-74da-11e7-8ce6-59083403f64f.png)

If you're in Juno, the second plot command will cause the plot to open in the
plot pane. If you're in the REPL, GR will open a GUI window. You can always
open a GUI anyways by using the `gui()` command.

Each plotting backend has a very different feel. Some have interactivity, some
are faster and can deal with huge numbers of datapoints, and some can do
3D plots. Saving plots is done by the `savefig` command. As an example:

```julia
savefig("myplot.png") # Saves the CURRENT_PLOT as a .png
savefig(p,"myplot.pdf") # Saves the plot from p as a .pdf vector graphic
```

Some like GR can save to vector graphics and PDFs, while others like Plotly only save to `.png`s. For more information on backends, see the
[backends page](/backends). For examples of plots from the various backends, see
the Examples section.

## Changing the Plotting Series

At this point you're a master of lines, but don't you want to plot your data
in other ways? In Plots.jl, these other ways of plotting a series is called a
**series type**. A line is one series type. However, a scatter plot is another
series type which is commonly used. We can change the series type by the
`seriestype` attribute:

```julia
gr() # We will continue onward using the GR backend
plot(x,y,seriestype=:scatter,title="My Scatter Plot")
```

![scatter_plot](https://user-images.githubusercontent.com/1814174/28752688-67293c50-74da-11e7-91ba-8056f3a8d6e1.png)

For each built-in series type, there is a shorthand function for directly
calling that series type which matches the name of the series type. It handles
attributes just the same as the `plot` command, and have a mutating form which
ends in `!`. For example, we can instead do that scatter plot with:

```julia
scatter(x,y,title="My Scatter Plot")
```

![scatter_plot](https://user-images.githubusercontent.com/1814174/28752688-67293c50-74da-11e7-91ba-8056f3a8d6e1.png)

The series types which are available are dependent on the backend, and are
documented on the [Supported Attributes page](/supported). As we will describe
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
display(plot(x,y))
```

If we have a plot object `p`, we can do `display(p)` at any time.

## Combining Multiple Plots as Subplots

We can combine multiple plots together as subplots using **layouts**.
There are many methods for doing this, and we will show two simple methods
for generating simple layouts. More advanced layouts are shown in the
[Layouts page](/layouts).

The first method is to define a layout which will split a series. The `layout`
command takes in a 2-tuple `layout=(N,M)` which builds an NxM grid of plots.
It will automatically split a series to be in each plot. For example, if we do
`layout=(4,1)` on a plot with four series, then we will get four rows of plots,
each with one series in it:

```julia
y = rand(10,4)
plot(x,y,layout=(4,1))
```

![subplot_single_plot](https://user-images.githubusercontent.com/1814174/28752693-85ac2c64-74da-11e7-82d7-1fb6986c9093.png)

We can also use layouts on plots of plot objects. For example, we can generate
for separate plots and make a single plot that combines them in a 2x2 grid
via the following:

```julia
p1 = plot(x,y) # Make a line plot
p2 = scatter(x,y) # Make a scatter plot
p3 = plot(x,y,xlabel="This one is labelled",lw=3,title="Subtitle")
p4 = histogram(x,y) # Four histograms each with 10 points? Why not!
plot(p1,p2,p3,p4,layout=(2,2),legend=false)
```

![multi_plot_subplot](https://user-images.githubusercontent.com/1814174/28752698-94c91248-74da-11e7-9431-8d3a12fb97b8.png)

Notice that the attributes in the individual plots are applied to the
individual plots, while the attributes on the final `plot` call are applied
to all of the subplots.

## Plot Recipes and Recipe Libraries

You now know all of the basic terminology of Plots.jl and can roam the
documentation freely to become a plotting master. However, there is one
thing left: **recipes**. Plotting recipes are extensions to the Plots.jl
framework. They add:

1) New `plot` commands via **user recipes**.
2) Default interpretations of Julia types as plotting data via **type recipes**.
3) New functions for generating plots via **plot recipes**.
4) New series types via **series recipes**.

Writing your own recipes is an advanced topic described on the
[recipes page](/recipes). Instead, we will introduce the ways that one uses
a recipe.

Recipes are included in many recipe libraries. Two fundamental recipe libraries
are [PlotRecipes.jl](https://github.com/JuliaPlots/PlotRecipes.jl) and
[StatPlots.jl](https://github.com/JuliaPlots/StatPlots.jl). Let's look into
StatPlots.jl. StatPlots.jl adds a bunch of recipes, but the ones we'll focus
on are:

1) It adds a user recipe for `DataFrame`s.
2) It adds a type recipe for `Distribution`s.
3) It adds a plot recipe for marginal histograms.
4) It adds a bunch of new statistical plot series.

### Using User Recipes

A user recipe says how to interpret plotting commands on a new data type.
In this case, StatPlots.jl thus has an extension which allows you to plot
a `DataFrame` directly by using the column names. Let's build a `DataFrame`
with columns `a`, `b`, and `c`, and tell Plots.jl to use `a` as the `x` axis
and plot the series defined by columns `b` and `c`:

```julia
# Pkg.add("StatPlots")
using StatPlots # Required for the DataFrame user recipe
# Now let's create the DataFrame
using DataFrames
df = DataFrame(a = 1:10, b = 10*rand(10), c = 10 * rand(10))
# Plot the DataFrame by declaring the points by the column names
plot(df, :a, [:b :c]) # x = :a, y = [:b :c]. Notice this is two columns!
```

![dataframeplot](https://user-images.githubusercontent.com/1814174/28752322-09f62f24-74d1-11e7-80a7-0d8183337a0c.png)

Notice there's not much you have to do here: a user recipe is a way of
translating a Julia type to plotting data, and all of the commands from before
(attributes, series types, etc.) will still work on this data:

```julia
scatter(df, :a, :b, title="My DataFrame Scatter Plot!") # x = :a, y = :b
```

![dataframescatterplot](https://user-images.githubusercontent.com/1814174/28752706-c37b7720-74da-11e7-9fe2-aec281cef0dc.png)

### Using a Type Recipe

In addition, StatPlots.jl extends Distributions.jl by adding a type recipe
for its distribution types, so they can be directly interpreted as plotting
data:

```julia
using Distributions
plot(Normal(3,5),lw=3)
```

![distributionplot](https://user-images.githubusercontent.com/1814174/28752330-2de10fb2-74d1-11e7-902e-8ce60a62fba2.png)

Thus type recipes are a very convenient way to plot a specialized type which
requires no more intervention!

### Using Plot Recipes

StatPlots.jl adds the `marginhist` multiplot via a plot recipe. For our data
we will pull in the famous `iris` dataset from RDatasets:

```julia
#Pkg.add("RDatasets")
using RDatasets
iris = dataset("datasets","iris")
```

Here `iris` is a Dataframe, using the user recipe on `Dataframe`s described above,
we give `marginalhist(x,y)` the data from the `PetalLength` and the `PetalWidth`
columns:

```julia
marginalhist(iris, :PetalLength, :PetalWidth)
```

![marginalhistplot](https://user-images.githubusercontent.com/1814174/28752339-5fa4176a-74d1-11e7-9e7c-0dd366625f40.png)

This demonstrates two important facts. Notice that this is more than a series
since it generates multiple series (i.e. there are multiple plots due to the
hists on the top and right). Thus a plot recipe is not just a series but instead
something like a new `plot` command. Secondly, this shows that recipes can chain
together. The `DataFrame` user recipes which defines a new way of
inputing data from a `DataFrame`, and then any plot or series recipe can make
use of this new data input style. In this sense, recipes are a true extension
of the Plots.jl internal power via external libraries.

### Using Series Recipes

StatPlots.jl also introduces new series recipes. The key is that you don't have
to do anything differently: after `using StatPlots` you can simply use those
new series recipes as though they were built into the plotting libraries. Let's
use the Violin plot on some random data:

```julia
y = rand(100,4) # Four series of 100 points each
violin(["Series 1" "Series 2" "Series 3" "Series 4"],y,leg=false)
```

![violinplot](https://user-images.githubusercontent.com/1814174/28752344-6f5c3c00-74d1-11e7-9a30-18d2682f1e3a.png)

and we can add a `boxplot` on top using the same mutation commands as before:

```julia
boxplot!(["Series 1" "Series 2" "Series 3" "Series 4"],y,leg=false)
```

![violinboxplot](https://user-images.githubusercontent.com/1814174/28752350-8646bb34-74d1-11e7-9f53-b2ecbf39a5cf.png)

## Additional Addons To Try

Given the easy extendability of Plots.jl, there are many other things you can
try. Here's a short list of very usable addons to check out:

- [PlotThemes.jl](https://github.com/JuliaPlots/PlotThemes.jl) allows you to
  change the color scheme of your plots. For example, `theme(:dark)` adds a
  dark theme.
- [GGPlots.jl](https://github.com/JuliaPlots/GGPlots.jl) adds a Grammar of
  Graphics (GoG) API to Plots.jl
- The [ecosystem page](/ecosystem) shows many other packages which have recipes
  and extend Plots.jl's functionality.
