
# [Output](@id output)


**A Plot is only displayed when returned** (a semicolon will suppress the return), or if explicitly displayed with `display(plt)`, `gui()`, or by adding `show = true` to your plot command.


!!! tip
    You can have MATLAB-like interactive behavior by setting the default value: default(show = true)

### Standalone window

Calling `gui(plt)` will open a standalone window.  `gui()`, like `plot!(...)`, applies to the "current" Plot.  Returning a Plot object to the REPL is like calling `gui(plt)`.


### Jupyter / IJulia

Plots are shown inline when returned to a cell.  The default output format can be changed by the `html_output_format` attribute, with alias `fmt`:

```julia
plot(rand(10), fmt = :png)
```

### Juno / Atom

Plots are shown in the Atom PlotPane when possible, either when returned to the console or to an inline code block. At any time, the plot can be opened in a standalone window using the `gui()` command. The default behavior can be switched to match the REPL behavior (i.e. opening a standalone window) by setting `ENV["PLOTS_USE_ATOM_PLOTPANE"] = "false"` before loading Plots.

Note that javascript-based libraries (for example: PlotlyJS) cannot be shown in the PlotPane due to issues within Atom's internals.

### savefig / format

Plots support 2 different versions per save-command.
Command `savefig` chooses file type automatically based on the file extension.

```julia
savefig(fn) # save the most recent fig as fn
savefig(plot_ref, fn) # save the fig referenced by plot_ref as fn
```

In addition, Plots offers shorthands like `png(fn)`, etc.
In this case the string fn containing the filename does not need a file extension.

```julia
png(fn) # save the current fig as png with filename fn
png(plot_ref, fn) # save the fig referenced by plot_ref as png with filename fn
```

#### File formats supported by most graphical backends

 - png (default output format)
 - svg
 - PDF

#### Supported output file formats

Note:   not all backends support every output file format !
A simple table showing which format is supported by which backend

| format | backends |
|--------|----------|
| eps | inspectdr, plotlyjs, pyplot |
| html | plotly,  plotlyjs |
| pdf | gr, inspectdr, pgfplots, plotlyjs, pyplot |
| png | glvisualize, gr, inspectdr, plotly, plotlyjs, pyplot |
| ps | gr, pyplot |
| svg | gr, inspectdr, pgfplots, plotly, plotlyjs, pyplot |
| tex | pgfplots |
| text | hdf5, unicodeplots |
