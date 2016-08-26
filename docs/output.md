
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

Plots are shown in the Atom PlotPane when possible, either when returned to the console or to an inline code block.  The REPL behavior (i.e. opening a standalone window) can be acheived by setting `ENV["PLOTS_USE_ATOM_PLOTPANE"] = "false"` before loading Plots.

Note that javascript-based libraries (for example: PlotlyJS) cannot be shown in the PlotPane due to issues within Atom's internals.

### savefig / png

Save the most recent plot, choosing file type automatically by the extension.

```julia
savefig(filename)
```

There are also shorthands `png(fn)`, etc.  You don't need the file extension for those.
