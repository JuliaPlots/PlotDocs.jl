
# Intro to Plots in Julia

**Author: Thomas Breloff (@tbreloff)**

Data visualization has a complicated history, with plotting software making trade-offs between features vs simplicity, speed vs beauty, and static vs dynamic.  Some make a visualization and never change it, others must make updates in real-time.

Plots is a visualization interface and toolset.  It sits above other visualization "backends", connecting commands with implementation.  If one backend does not support your desired features, or make the right trade-offs, just switch to another backend with one command.  No need to change your code.  No need to learn something new.  Plots might be the last plotting package you ever learn.

My goals with the package are:

- **Powerful**.  Do more with less.  Complex visualizations become easy.
- **Intuitive**.  Start generating plots without reading volumes of documentation.  Commands should "just work".
- **Concise**.  Less code means fewer mistakes and more efficient development/analysis.
- **Flexible**.  Produce your favorite plots from your favorite package, but quicker and simpler.
- **Consistent**.  Don't commit to one graphics package.  Use the same code and access the strengths of all [backends](http://plots.readthedocs.io/en/latest/backends/).
- **Lightweight**.  Very few dependencies, since backends are loaded and initialized dynamically.
- **Smart**.  It's not quite AGI, but Plots should figure out what you **want** it to do... not just what you **tell** it.

Use the [preprocessing pipeline](/pipeline) in Plots to fully describe your visualization before it calls the backend code.  This maintains modularity and allows for efficient separation of front end code, algorithms, and backend graphics.  New graphical backends can be added with minimal effort.

Please add wishlist items, bugs, or any other comments/questions to the [issues list](https://github.com/tbreloff/Plots.jl/issues).

---

### Simple is Beautiful

Lorenz Attractor

```julia
# initialize the attractor
n = 1500
dt = 0.02
σ, ρ, β = 10., 28., 8/3
x, y, z = 1., 1., 1.

# initialize a 3D plot with 1 empty series
plt = path3d(1, xlim=(-25,25), ylim=(-25,25), zlim=(0,50),
                xlab = "x", ylab = "y", zlab = "z",
                title = "Lorenz Attractor", marker = 1)

# build an animated gif, saving every 10th frame
@gif for i=1:n
    dx = σ*(y - x)     ; x += dt * dx
    dy = x*(ρ - z) - y ; y += dt * dy
    dz = x*y - β*z     ; z += dt * dz
    push!(plt, x, y, z)
end every 10
```

![](examples/img/lorenz.gif)

Make some waves

```julia
using Plots
pyplot(reuse=true)

@gif for i in linspace(0,2π,100)
    X = Y = linspace(-5,5,40)
    surface(X, Y, (x,y) -> sin(x+10sin(i))+cos(y))
end
```

![waves](examples/img/waves.gif)

Iris Dataset

```julia
# load a dataset
using RDatasets
iris = dataset("datasets", "iris");

# Scatter plot with some custom settings
scatter(iris, :SepalLength, :SepalWidth, group=:Species,
        title = "My awesome plot",
        xlabel = "Length", ylabel = "Width",
        m=(0.5, [:+ :h :star7], 12),
        bg=RGB(.2,.2,.2))

# save a png
png("iris")
```

![iris_plt](examples/img/iris.png)

---

### Install

First, add the package

```julia
Pkg.add("Plots")

# if you want the latest features:
Pkg.checkout("Plots")

# or for the bleeding edge:
Pkg.checkout("Plots", "dev")
```

then get any plotting packages you need (obviously, you should get at least one [backend](/backends)).

```julia
Pkg.add("PyPlot")
Pkg.add("GR")
Pkg.add("Gadfly")
Pkg.add("Immerse")
Pkg.add("UnicodePlots")
Pkg.add("PlotlyJS")
```

---

### Initialize

```julia
using Plots
```

[Choose a backend](/backends), and optionally override default settings at the same time:

```julia
pyplot(size = (300,300), legend = false)
```

<div style="background-color: lightblue; padding: 10px; border-style: solid; border-width: medium; margin: 10px;">
Tip: Backend methods are lowercase, and match the corresponding backend package name.
</div>

<div style="background-color: lightblue; padding: 10px; border-style: solid; border-width: medium; margin: 10px;">
Tip: The underlying plotting backends are not imported and initialized immediately, thus they are
loaded on demand to reduce dependencies.
</div>

<div style="background-color: lightblue; padding: 10px; border-style: solid; border-width: medium; margin: 10px;">
Tip: Plots will pick a default backend for you automatically based on what backends are installed.  You can
override this choice by setting an environment variable in your ~/.juliarc.jl file: ENV["PLOTS_DEFAULT_BACKEND"] = "PlotlyJS"
</div>


---

### Basic Concepts

Use `plot` to create a new plot object, and `plot!` to add to an existing one:

```julia
plot(args...; kw...)                  # creates a new plot window, and sets it to be the `current`
plot!(args...; kw...)                 # changes plot `current()`
plot!(plt, args...; kw...)            # changes plot `plt`
```

<div style="background-color: lightblue; padding: 10px; border-style: solid; border-width: medium; margin: 10px;">
Tip: subplot and subplot! follow the same convention
</div>

Arguments can take [many forms](/input_data).  Some valid examples:

```julia
plot()                                    # empty plot object
plot(4)                                   # initialize with 4 empty series
plot(rand(10))                            # plot 1 series... x = 1:10
plot(rand(10,5))                          # plot 5 series... x = 1:10
plot(rand(10), rand(10))                  # plot 1 series
plot(rand(10,5), rand(10))                # plot 5 series... y is the same for all
plot(sin, rand(10))                       # y = sin(x)
plot(rand(10), sin)                       # same... y = sin(x)
plot([sin,cos], 0:0.1:π)                  # plot 2 series, sin(x) and cos(x)
plot([sin,cos], 0, π)                     # plot sin and cos on the range [0, π]
plot(1:10, Any[rand(10), sin])            # plot 2 series: rand(10) and map(sin,x)
plot(dataset("Ecdat", "Airline"), :Cost)  # plot the :Cost column from a DataFrame
```

Keyword arguments allow for customization from the defaults.  Some rules:

- Many arguments have aliases which are [replaced during preprocessing](/pipeline/#step-1-replace-aliases).  `c` is the same as `color`, `m` is the same as `marker`, etc.  You can choose how verbose you'd like to be.
- There are some [special arguments](/pipeline/#step-2-handle-magic-arguments) which magically set many related things at once.
- If the argument is a "matrix-type", then [each column will map to a series](/input_data/#columns-are-series), cycling through columns if there are fewer columns than series.  Anything else will apply the argument value to every series.
- Many arguments accept many different types... for example the color (also markercolor, fillcolor, etc) argument will accept strings or symbols with a color name, or any Colors.Colorant, or a ColorScheme, or a symbol representing a ColorGradient, or an AbstractVector of colors/symbols/etc...

<div style="background-color: lightblue; padding: 10px; border-style: solid; border-width: medium; margin: 10px;">
Tip: A common error is to pass a Vector when you intend for each item to apply to only one series.  Instead of an n-length Vector, pass a 1xn Matrix.
</div>

<div style="background-color: lightblue; padding: 10px; border-style: solid; border-width: medium; margin: 10px;">
  <p>Tip: You can update certain plot settings after plot creation:</p>
  <pre><code>
    plot!(title = "New Title", xlabel = "New xlabel", ylabel = "New ylabel")
    plot!(xlims = (0, 5.5), ylims = (-2.2, 6), xticks = 0:0.5:10, yticks = [0,1,5,10])

    # or using magic:
    xaxis!("mylabel", :log10, :flip)
  </code></pre>
</div>

---

### Subplots

With `subplot`, create multiple plots at once, with flexible layout options:

```julia
y = rand(100,3)
subplot(y)                    # create an automatic grid, and let it figure out the shape
subplot(y, n = 2)             # create two plots, the third series is added to the first plot
subplot(y; nr = 1)            # create an automatic grid, but fix the number of rows
subplot(y; nc = 1)            # create an automatic grid, but fix the number of columns
subplot(y; layout = [1, 2])   # explicit layout.  Lists the number of plots in each row
```

<div style="background-color: lightblue; padding: 10px; border-style: solid; border-width: medium; margin: 10px;">
Tip: You can call `subplot!(args...; kw...)` to add to an existing subplot.*
</div>

To create a grid of existing plots `p1` and `p2`, use:
```julia
subplot(p1, p2)
```

<div style="background-color: lightblue; padding: 10px; border-style: solid; border-width: medium; margin: 10px;">
Tip: Calling `subplot!` on a `Plot` object, or `plot!` on a `Subplot` object will throw an error.
</div>

---

### Animations

Animations are created in 3 steps:

- Initialize an `Animation` object.
- Save each frame of the animation with `frame(anim)`.
- Convert the frames to an animated gif with `gif(anim, filename, fps=15)`

<div style="background-color: lightblue; padding: 10px; border-style: solid; border-width: medium; margin: 10px;">
Tip: the convenience macros `@gif` and `@animate` simplify this code immensely.  See the <a href="#simple-is-beautiful">examples above</a> for the short version, or
the <a href="examples/pyplot/#functions-adding-data-and-animations">pyplot example</a> for the long version.
</div>

---

### Tips

<div style="background-color: lightblue; padding: 10px; border-style: solid; border-width: medium; margin: 10px;">
Tip: With <a href="supported">supported backends</a>, you can pass a Plots.Shape object for the marker/markershape arguments.  Shape takes a vector of 2-tuples in the constructor, defining the points of the polygon's shape in a unit-scaled coordinate space.  To make a square, for example, you could do: Shape([(1,1),(1,-1),(-1,-1),(-1,1)])
</div>

<div style="background-color: lightblue; padding: 10px; border-style: solid; border-width: medium; margin: 10px;">
Tip: You can see the default value for a given argument with default(arg::Symbol), and set the default value with default(arg::Symbol, value) or default(; kw...).  For example set the
default window size and whether we should show a legend with default(size=(600,400), leg=false).
</div>

<div style="background-color: lightblue; padding: 10px; border-style: solid; border-width: medium; margin: 10px;">
Tip: Call `gui()` to display the plot in a window.  Interactivity depends on backend.  Plotting at the REPL (without semicolon) implicitly calls `gui()`.
</div>

<div style="background-color: lightblue; padding: 10px; border-style: solid; border-width: medium; margin: 10px;">
Tip: See the <a href="examples/pyplot">examples</a> for plotting ideas and features.
</div>

---
