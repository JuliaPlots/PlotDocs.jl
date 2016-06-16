
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

---

### GR

For the GR backend there are some additional optional settings:  (Thanks @jheinen!)

The GKS_WSTYPE environment variable can be used to set the output device. The default workstation type is automatically selected depending on the platform:
 -  211 = X11 (Un*x)
 -  400 = Quartz (macOS only)
 -  42 = GDI (Windows only)

Add this to your `~/.juliarc.jl` file to switch the default output device:

```julia
ENV["GKS_WSTYPE"] = "x11"
```

Choose from:

| Type |Description |
|---------------|--------------|
| x11	| X11 (Un*x + macOS) |
| quartz	| Quartz (macOS only) |
| win	| GDI (Windows only) |
| ps, eps | 	PostScript |
| pdf	| Portable Document Format |
| bmp	 | Windows Bitmap (BMP) |
| pgf	 | PGF / TikZ |
| mov	| MPEG-4 video |
| jpeg, jpg | 	JPEG image file |
| png	| Portable Network Graphics file (PNG) |
| tiff, tif	| Tagged Image File Format (TIFF) |
| fig  | Xfig vector graphics file |
| svg	| Scalable Vector Graphics |
| wmf	| Windows Metafile |


---
