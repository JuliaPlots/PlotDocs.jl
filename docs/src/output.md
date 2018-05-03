
# Output


**A Plot is only displayed when returned** (a semicolon will suppress the return), or if explicitly displayed with `display(plt)`, `gui()`, or by adding `show = true` to your plot command.


<div style="background-color: lightblue; padding: 10px; border-style: solid; border-width: medium; margin: 10px;">
Tip: You can have MATLAB-like interactive behavior by setting the default value: default(show = true)
</div>

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
The 1-argument command saves the most recent plot, while the 2-argument command saves the referenced plot.

To save with `savefig`, choosing file type automatically by the extension of filename `fn`, use

```julia
savefig(fn) # save the most recent fig as fn
savefig(plot_ref, fn) # save the fig referenced by plot_ref as fn
```

In addition, Plots offers shorthands like `png(fn)`, etc, to save into a file.
In this case the string fn containing the filename may lack the file extension for those.

```julia
png(fn) # save the current fig as png with filename fn
png(plot_ref, fn) # save the fig referenced by plot_ref as png with filename fn
```

These examples are given using png.  The use of the others is equivalent.

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

