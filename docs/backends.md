# Backends

Backends are the lifeblood of Plots, and the diversity between features, approaches, and strengths/weaknesses was 
one of the primary reasons that I started this package.

For those who haven't had the pleasure of hacking on 15 different plotting APIs:  First, consider yourself lucky.  However,
you will probably have a hard time choosing the right backend for your task at hand.  This document is meant to be a guide and 
introduction to making that choice.

# For the impatient

My favorites: GR for speed, PlotlyJS otherwise, PyPlot as a backup.

If your plot requires... | ... then use...
----------- | -----------------
Lots of features    | Gadfly, PyPlot, Plotly, GR
Speed               | GR, PyPlot
Interactivity       | Plotly, PyPlot, PlotlyJS
Beauty              | Plotly, Gadfly
REPL Plotting       | UnicodePlots
Standalone GUI      | GR, Immerse, PyPlot, PlotlyJS
Minimal Dependencies | Plotly, UnicodePlots

Of course nothing in life is that simple.  Likely there are subtle tradeoffs between backends, long hidden bugs, and more excitement.
Don't be shy to try out something new!

---

### [Gadfly](https://github.com/dcjones/Gadfly.jl)

A Julia implementation inspired by the "Grammar of Graphics".

Pros:

- Clean look
- Lots of features
- Flexible when combined with Compose.jl (inset plots, etc)

Cons:

- Do not support 3D
- Slow time-to-first-plot
- Lots of dependencies
- No interactivity

Primary author: Daniel C Jones

### [PyPlot](https://github.com/stevengj/PyPlot.jl)

A Julia wrapper around the popular python package PyPlot (Matplotlib).  It uses PyCall.jl to pass data with minimal overhead.

Pros:

- Tons of functionality
- 2D and 3D
- Mature library
- Standalone or inline

Cons:

- Uses python
- Dependencies frequently cause setup issues
- Inconsistent output depending on Matplotlib version

Primary author: Steven G Johnson

### [Plotly / PlotlyJS](https://github.com/spencerlyon2/PlotlyJS.jl)

These are treated as separate backends, though they share much of the code and use the Plotly javascript API.  `plotly()` is the only dependency-free plotting option,
as the required javascript is bundled with Plots.  It can create inline plots in IJulia, or open standalone browser windows when run from the Julia REPL.

`plotlyjs()` is the preferred option, and taps into the great functionality of Spencer Lyon's PlotlyJS.jl.  Inline IJulia plots can be updated from any cell... something that
makes this backend stand out.  From the Julia REPL, it taps into Blink.jl and Electron to plot within a standalone GUI window... also very cool.

Pros:

- [Tons of functionality](https://plot.ly/javascript/)
- 2D and 3D
- Mature library
- Interactivity (even when inline)
- Standalone or inline

Cons:

- No custom shapes
- JSON may limit performance

Primary author: Spencer Lyon

### [GR](https://github.com/jheinen/GR.jl)

Super fast with lots of plot types.  Still actively developed and improving daily.

Pros:

- Speed
- 2D and 3D
- Standalone or inline

Cons:

- Limited interactivity
- Plots integration is still a work in progress

Primary author: Josef Heinen

### [Immerse](https://github.com/JuliaGraphics/Immerse.jl)

Built on top of Gadfly, Immerse adds some interactivity and a standalone GUI window, including zoom/pan and a cool "point lasso" tool to save Julia vectors with the selected data points.

Pros:

- Same as Gadfly
- Interactivity
- Standalone or inline
- Lasso functionality

Cons:

- Same as Gadfly

Primary author: Tim Holy

### [UnicodePlots](https://github.com/Evizero/UnicodePlots.jl)

Simple and lightweight.  Plot directly in your terminal.  You won't produce anything publication quality, but for a quick look at your data it is awesome.

Pros:

- Minimal dependencies
- Lightweight
- Fast
- REPL plotting

Cons:

- Limited functionality

Primary author: Christof Stocker

---

# The future: works in progress

### [GLVisualize](https://github.com/JuliaGL/GLVisualize.jl)

A really awesome 2D/3D visualization library written in Julia and OpenGL.  It is feature-packed and fast, and author Simon Danisch has put a ton of energy into its development.  I'm very excited for the day that this is cleanly wrapped.

### [PGFPlots](https://github.com/sisl/PGFPlots.jl)

LaTeX plotting.  Seems really cool, though I have yet to try it out myself.

---

# Deprecated backends

### [Qwt](https://github.com/tbreloff/Qwt.jl)

My package which wraps PyQwt.  Similar to PyPlot, it uses PyCall to convert calls to python.  Though Qwt.jl was the "first draft" of Plots, the functionality is superceded by other backends, and it's not worth my time to maintain.

### [Bokeh](https://github.com/bokeh/Bokeh.jl)

Unfinished, but very similar to PlotlyJS... use that instead.

### [Winston](https://github.com/nolta/Winston.jl)

Functionality incomplete... I never finished wrapping it, and I don't think it offers anything beyond other backends.  However, the plots are clean looking and it's relatively fast.

