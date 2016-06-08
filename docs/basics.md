
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
