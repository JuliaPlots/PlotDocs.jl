### Initialize

```julia
using Plots
inspectdr()
```

### Lines

A simple line plot of the columns.

```julia
plot(Plots.fakedata(50,5),w=3)
```

![](img/inspectdr/inspectdr_example_1.png)

### Parametric plots

Plot function pair (x(u), y(u)).

```julia
plot(sin,(x->begin
            sin(2x)
        end),0,2π,line=4,leg=false,fill=(0,:orange))
```

![](img/inspectdr/inspectdr_example_3.png)

### Global

Change the guides/background/limits/ticks.  Convenience args `xaxis` and `yaxis` allow
you to pass a tuple or value which will be mapped to the relevant args automatically.
The `xaxis` below will be replaced with `xlabel` and `xlims` args automatically during
the preprocessing step. You can also use shorthand functions: `title!`, `xaxis!`,
`yaxis!`, `xlabel!`, `ylabel!`, `xlims!`, `ylims!`, `xticks!`, `yticks!`

```julia
y = rand(20,3)
plot(y,xaxis=("XLABEL",(-5,30),0:2:20,:flip),background_color=RGB(0.2,0.2,0.2),leg=false)
hline!(mean(y,1) + rand(1,3),line=(4,:dash,0.6,[:lightgreen :green :darkgreen]))
vline!([5,10])
title!("TITLE")
yaxis!("YLABEL",:log10)
```

![](img/inspectdr/inspectdr_example_5.png)

### Arguments

Plot multiple series with different numbers of points.  Mix arguments that apply to all
series (marker/markersize) with arguments unique to each series (colors).  Special
arguments `line`, `marker`, and `fill` will automatically figure out what arguments to
set (for example, we are setting the `linestyle`, `linewidth`, and `color` arguments with
`line`.)  Note that we pass a matrix of colors, and this applies the colors to each
series.

```julia
ys = Vector[rand(10),rand(20)]
plot(ys,color=[:black :orange],line=(:dot,4),marker=([:hex :d],12,0.8,stroke(3,:gray)))
```

![](img/inspectdr/inspectdr_example_7.png)

and add to it later.

```julia
scatter!(rand(100),markersize=6,c=:orange)
```

![](img/inspectdr/inspectdr_example_9.png)

### Line types



```julia
linetypes = [:path :steppre :steppost :sticks :scatter]
n = length(linetypes)
x = Vector[sort(rand(20)) for i = 1:n]
y = rand(20,n)
plot(x,y,line=(linetypes,3),lab=map(string,linetypes),ms=15)
```

![](img/inspectdr/inspectdr_example_11.png)

### Line styles



```julia
styles = (filter((s->begin
            s in Plots.supported_styles()
        end),[:solid,:dash,:dot,:dashdot,:dashdotdot]))'
n = length(styles)
y = cumsum(randn(20,n),1)
plot(y,line=(5,styles),label=map(string,styles))
```

![](img/inspectdr/inspectdr_example_12.png)

### Marker types



```julia
markers = (filter((m->begin
            m in Plots.supported_markers()
        end),Plots._shape_keys))'
n = length(markers)
x = (range(0, stop=10, length=n + 2))[2:end - 1]
y = repmat((reverse(x))',n,1)
scatter(x,y,m=(8,:auto),lab=map(string,markers),bg=:linen,xlim=(0,10),ylim=(0,10))
```

![](img/inspectdr/inspectdr_example_13.png)

### Bar

x is the midpoint of the bar. (todo: allow passing of edges instead of midpoints)

```julia
bar(randn(99))
```

![](img/inspectdr/inspectdr_example_14.png)

### Histogram



```julia
histogram(randn(1000),nbins=20)
```

![](img/inspectdr/inspectdr_example_15.png)

### Subplots

Use the `layout` keyword, and optionally the convenient `@layout` macro to generate
arbitrarily complex subplot layouts.


```julia
l = @layout([a{0.1h};b [c;d e]])
plot(randn(100,5),layout=l,t=[:line :histogram :scatter :steppre :bar],
     leg=false,ticks=nothing,border=false)
```

![](img/inspectdr/inspectdr_example_16.png)

### Adding to subplots

Note here the automatic grid layout, as well as the order in which new series are added
to the plots.

```julia
plot(Plots.fakedata(100,10),layout=4,palette=[:grays :blues :heat :lightrainbow],
     bg_inside=[:orange :pink :darkblue :black])
```

![](img/inspectdr/inspectdr_example_17.png)



```julia
Random.seed!(111)
plot!(Plots.fakedata(100,10))
```

![](img/inspectdr/inspectdr_example_18.png)

### Open/High/Low/Close

Create an OHLC chart.  Pass in a list of (open,high,low,close) tuples as your `y`
argument.  This uses recipes to first convert the tuples to OHLC objects, and
subsequently create a :path series with the appropriate line segments.

```julia
n = 20
hgt = rand(n) + 1
bot = randn(n)
openpct = rand(n)
closepct = rand(n)
y = OHLC[(openpct[i] * hgt[i] + bot[i],bot[i] + hgt[i],bot[i],closepct[i] * hgt[i] +
          bot[i]) for i = 1:n]
ohlc(y)
```

![](img/inspectdr/inspectdr_example_19.png)

### Annotations

The `annotations` keyword is used for text annotations in data-coordinates. 
Pass in a tuple `(x, y, text)`, or a vector of annotations, each of which is a
tuple of `x`, `y` and `text`. `text` may be a simple `String`, or a `PlotText`
object, which can be built with the method `text(string, attrs...)`.
This wraps font and color attributes and allows you to set text styling.
`text` may also be a tuple `(string, attrs...)` of arguments which are passed
to `Plots.text`.

`annotate!(ann)` is shorthand for `plot!(; annotation=ann)`.

Series annotations are used for annotating individual data points.
They require only the annotation; x/y values are computed.  Series annotations
require either plain `String`s or `PlotText` objects.

```julia
y = rand(10)
plot(y, annotations=(3,y[3],text("this is #3",:left)),leg=false)
annotate!([(5,y[5],("this is #5",16,:red,:center)),
          (10,y[10],("this is #10",:right,20,"courier"))])
scatter!(range(2, stop=8, length=6),rand(6),marker=(50,0.2,:orange),
         series_annotations=["series","annotations","map","to","series",
                             text("data",:green)])
```

![](img/inspectdr/inspectdr_example_20.png)

### Custom Markers

A `Plots.Shape` is a light wrapper around vertices of a polygon.  For supported backends,
pass arbitrary polygons as the marker shapes.  Note: The center is (0,0) and the size is
expected to be rougly the area of the unit circle.

```julia
verts =[(-1.0,1.0),(-1.28,0.6),(-0.2,-1.4),(0.2,-1.4),(1.28,0.6),(1.0,1.0),
        (-1.0,1.0),(-0.2,-0.6),(0.0,-0.2),(-0.4,0.6),(1.28,0.6),(0.2,-1.4),
        (-0.2,-1.4),(0.6,0.2),(-0.2,0.2),(0.0,-0.2),(0.2,0.2),(-0.2,-0.6)]
x = 0.1:0.2:0.9
y = 0.7 * rand(5) + 0.15
plot(x,y,line=(3,:dash,:lightblue),marker=(Shape(verts),30,RGBA(0,0,0,0.2)),
     bg=:pink,fg=:darkblue,xlim=(0,1),ylim=(0,1),leg=false)
```

![](img/inspectdr/inspectdr_example_21.png)

### Groups and Subplots



```julia
group = rand(map((i->begin
                    "group $(i)"
                end),1:4),100)
plot(rand(100),layout=@layout([a b;c]),group=group,linetype=[:bar :scatter :steppre])
```

![](img/inspectdr/inspectdr_example_26.png)

- Supported arguments: `annotations`, `background_color`, `background_color_inside`, `background_color_legend`, `background_color_outside`, `background_color_subplot`, `bottom_margin`, `color_palette`, `discrete_values`, `dpi`, `fillalpha`, `fillcolor`, `foreground_color`, `foreground_color_axis`, `foreground_color_border`, `foreground_color_grid`, `foreground_color_guide`, `foreground_color_legend`, `foreground_color_subplot`, `foreground_color_text`, `foreground_color_title`, `grid`, `group`, `guide`, `guidefont`, `html_output_format`, `label`, `layout`, `left_margin`, `legend`, `legendfont`, `lims`, `linealpha`, `linecolor`, `linestyle`, `linewidth`, `link`, `margin`, `markeralpha`, `markercolor`, `markershape`, `markersize`, `markerstrokealpha`, `markerstrokecolor`, `markerstrokestyle`, `markerstrokewidth`, `match_dimensions`, `overwrite_figure`, `polar`, `primary`, `projection`, `right_margin`, `scale`, `series_annotations`, `seriesalpha`, `seriescolor`, `seriestype`, `show`, `size`, `smooth`, `subplot`, `subplot_index`, `tickfont`, `title`, `title_location`, `titlefont`, `top_margin`, `window_title`, `x`, `xdiscrete_values`, `xerror`, `xforeground_color_axis`, `xforeground_color_border`, `xforeground_color_guide`, `xforeground_color_text`, `xguide`, `xguidefont`, `xlims`, `xlink`, `xscale`, `xtickfont`, `y`, `ydiscrete_values`, `yerror`, `yforeground_color_axis`, `yforeground_color_border`, `yforeground_color_guide`, `yforeground_color_text`, `yguide`, `yguidefont`, `ylims`, `ylink`, `yscale`, `ytickfont`, `z`, `zdiscrete_values`, `zforeground_color_axis`, `zforeground_color_border`, `zforeground_color_guide`, `zforeground_color_text`, `zguide`, `zguidefont`, `zlims`, `zlink`, `zscale`, `ztickfont`
- Supported values for linetype: `:path`, `:scatter`, `:shape`
- Supported values for linestyle: `:auto`, `:dash`, `:dashdot`, `:dot`, `:solid`
- Supported values for marker: `:+`, `:auto`, `:circle`, `:cross`, `:diamond`, `:dtriangle`, `:heptagon`, `:hexagon`, `:hline`, `:ltriangle`, `:none`, `:octagon`, `:pentagon`, `:rect`, `:rtriangle`, `:star4`, `:star5`, `:star6`, `:star7`, `:star8`, `:utriangle`, `:vline`, `:x`, `:xcross`
(Automatically generated: 2017-05-31T16:38:34.425)
