
# Output


In IJulia or the REPL, **a Plot is only displayed when returned** (a semicolon will suppress the return), or if explicitly displayed with `display()`, `gui()`, or by adding `show = true` to your plot command.


<div style="background-color: lightblue; padding: 10px; border-style: solid; border-width: medium; margin: 10px;">
Tip: You can have MATLAB-like interactive behavior by setting the default value: default(show = true)
</div>

### GUI

`gui()` displays the most recent plot, or `display(plt)` works.  Returning the plot from the REPL is like calling `gui()`.


### savefig

Save the most recent plot, choosing file type automatically by the extension.

```
savefig(filename)
```

There are also shorthands `png(fn)`, etc.  You don't need the file extension for those.

