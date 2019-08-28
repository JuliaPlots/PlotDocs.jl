<script language="JavaScript">
<!--
function autoResize(id){
    var newheight;
    var newwidth;

    if(document.getElementById){
        newheight = document.getElementById(id).contentWindow.document .body.scrollHeight;
        newwidth = document.getElementById(id).contentWindow.document .body.scrollWidth;
    }

    document.getElementById(id).height = (newheight) + "px";
    document.getElementById(id).width = (newwidth) + "px";
}
//-->
</script>

---

# [Attributes](@id attributes)

In Plots, input data is passed positionally (for example, the `y` in `plot(y)`), and attributes are passed as keywords (for example, `plot(y, color = :blue)`).
!!! tip
	Most of the information on this page is available from your Julia session with the function `plotattr`, e.g. `plotattr(:Series)` to print a list of all series attributes, or `plotattr("ms")` to print the aliases and descriptions of `markersize`.

---

### [Aliases](@id aliases)

Keywords can take a range of values through the **alias mechanic**.  For example, `plot(y, color = :blue)` is really interpreted as `plot(y, seriescolor = :blue)`.  Each attribute has a number of aliases (see the charts below), which are available to avoid the pain of constantly looking up plotting API documentation because you forgot the argument name.  `c`, `color`, and `seriescolor` all mean the same thing, and in fact those are eventually converted into the more precise attributes `linecolor`, `markercolor`, `markerstrokecolor`, and `fillcolor` (which you can then override if desired).


!!! tip
	Use aliases for one-off analysis and visualization, but use the true keyword name for long-lived library code to avoid confusion.

!!! tip
	As of this writing, aliases do not work inside recipes!!

---

### [Magic Arguments](@id magic-arguments)


Some arguments encompass smart shorthands for setting many related arguments at the same time.  Plots uses type checking and multiple dispatch to smartly "figure out" which values apply to which argument.  Pass in a tuple of values.  Single values will be first wrapped in a tuple before processing.

##### axis (and xaxis/yaxis/zaxis)

Passing a tuple of settings to the `xaxis` argument will allow the quick definition
of `xlabel`, `xlims`, `xticks`, `xscale`, `xflip`, and `xtickfont`.  The following are equivalent:

```julia
plot(y, xaxis = ("my label", (0,10), 0:0.5:10, :log, :flip, font(20, "Courier")))

plot(y, xlabel = "my label",
		xlims = (0,10),
		xticks = 0:0.5:10,
        xscale = :log,
        xflip = true,
        xtickfont = font(20, "Courier"))
```

Note that `yaxis` and `zaxis` work similarly, and `axis` will apply to all.

Passing a tuple to `xticks` (and similarly to `yticks` and `zticks`) changes
the position of the ticks and the labels:

```julia
plot!(xticks = ([0:π:3*π;], ["0", "\\pi", "2\\pi"]))
yticks!([-1:1:1;], ["min", "zero", "max"])
```

##### line

Set attributes corresponding to a series line.  Aliases: `l`.  The following are equivalent:

```julia
plot(y, line = (:steppre, :dot, :arrow, 0.5, 4, :red))

plot(y, seriestype = :steppre,
		linestyle = :dot,
		arrow = :arrow,
		linealpha = 0.5,
		linewidth = 4,
		linecolor = :red)

```

##### fill

Set attributes corresponding to a series fill area.  Aliases: `f`, `area`.  The following are equivalent:

```julia
plot(y, fill = (0, 0.5, :red))

plot(y, fillrange = 0,
		fillalpha = 0.5,
		fillcolor = :red)
```

##### marker

Set attributes corresponding to a series marker.  Aliases: `m`, `mark`.  The following are equivalent:

```julia
scatter(y, marker = (:hexagon, 20, 0.6, :green, stroke(3, 0.2, :black, :dot)))

scatter(y, markershape = :hexagon,
		   markersize = 20,
		   markeralpha = 0.6,
		   markercolor = :green,
		   markerstrokewidth = 3,
		   markerstrokealpha = 0.2,
		   markerstrokecolor = :black,
		   markerstrokestyle = :dot)
```

---

### Series

These attributes apply to individual series (lines, scatters, heatmaps, etc)

```@raw html
<iframe src="../series_attr.html" name="series attributes" height="700" width="700", id="seriesframe" marginheight="0" frameborder="0" onLoad="autoResize('seriesframe');">You need a Frames Capable browser to view this content.</iframe>
```
---

### Plot

These attributes apply to the full Plot.  (A Plot contains a tree-like layout of Subplots)

```@raw html
<iframe src="../plot_attr.html" name="plot attributes" height="700" width="700", id="plotframe" marginheight="0" frameborder="0" onLoad="autoResize('plotframe');">You need a Frames Capable browser to view this content.</iframe>
```

---

### Subplot

These attributes apply to settings for individual Subplots.

```@raw html
<iframe src="../subplot_attr.html" name="subplot attributes" height="700" width="700", id="subplotframe" marginheight="0" frameborder="0" onLoad="autoResize('subplotframe');">You need a Frames Capable browser to view this content.</iframe>
```

---

### Axis

These attributes apply to an individual Axis in a Subplot (for example the `subplot[:xaxis]`)

```@raw html
<iframe src="../axis_attr.html" name="axis attributes" height="700" width="700", id="axisframe" marginheight="0" frameborder="0" onLoad="autoResize('axisframe');">You need a Frames Capable browser to view this content.</iframe>
```
