### Initialize

```@setup InspectDR
info("Generating example images for InspectDR backend")
Pkg.add("InspectDR")
srand(1234)
```


```@example InspectDR
using Plots
inspectdr()
size(600, 400); nothing # hide
```

### Lines

A simple line plot of the columns.

```@example InspectDR
plot(Plots.fakedata(50,5),w=3)
savefig("img/inspectdr/lines.svg"); nothing # hide
```

![](img/inspectdr/lines.svg)

### Parametric plots

Plot function pair (x(u), y(u)).

```@example InspectDR
plot(sin,(x->begin
            sin(2x)
        end),0,2π,line=4,leg=false,fill=(0,:orange))
savefig("img/inspectdr/parametric.svg"); nothing # hide
```

![](img/inspectdr/parametric.svg)

### Global

Change the guides/background/limits/ticks.  Convenience args `xaxis` and `yaxis` allow
you to pass a tuple or value which will be mapped to the relevant args automatically.
The `xaxis` below will be replaced with `xlabel` and `xlims` args automatically during
the preprocessing step. You can also use shorthand functions: `title!`, `xaxis!`,
`yaxis!`, `xlabel!`, `ylabel!`, `xlims!`, `ylims!`, `xticks!`, `yticks!`

```@example InspectDR
y = rand(20,3)
plot(y,xaxis=("XLABEL",(-5,30),0:2:20,:flip),background_color=RGB(0.2,0.2,0.2),leg=false)
hline!(mean(y,1) + rand(1,3),line=(4,:dash,0.6,[:lightgreen :green :darkgreen]))
vline!([5,10])
title!("TITLE")
yaxis!("YLABEL",:log10)
savefig("img/inspectdr/global.svg"); nothing # hide
```

![](img/inspectdr/global.svg)

### Arguments

Plot multiple series with different numbers of points.  Mix arguments that apply to all
series (marker/markersize) with arguments unique to each series (colors).  Special
arguments `line`, `marker`, and `fill` will automatically figure out what arguments to
set (for example, we are setting the `linestyle`, `linewidth`, and `color` arguments with
`line`.)  Note that we pass a matrix of colors, and this applies the colors to each
series.

```@example InspectDR
ys = Vector[rand(10),rand(20)]
plot(ys,color=[:black :orange],line=(:dot,4),marker=([:hex :d],12,0.8,stroke(3,:gray)))
savefig("img/inspectdr/arguments.svg"); nothing # hide
```

![](img/inspectdr/arguments.svg)

### Build plot in pieces

Start with a base plot...

```@example InspectDR
plot(rand(100) / 3,reg=true,fill=(0,:green))
savefig("img/inspectdr/pieces1.svg"); nothing # hide
```

![](img/inspectdr/pieces1.svg)

and add to it later.

```@example InspectDR
scatter!(rand(100),markersize=6,c=:orange)
savefig("img/inspectdr/pieces2.svg"); nothing # hide
```

![](img/inspectdr/pieces2.svg)

### Line types

```@example InspectDR
linetypes = [:path :steppre :steppost :sticks :scatter]
n = length(linetypes)
x = Vector[sort(rand(20)) for i = 1:n]
y = rand(20,n)
plot(x,y,line=(linetypes,3),lab=map(string,linetypes),ms=15)
savefig("img/inspectdr/line_types.svg"); nothing # hide
```

![](img/inspectdr/line_types.svg)

### Line styles

```@example InspectDR
styles = reshape(filter((s->begin
            s in Plots.supported_styles()
        end),[:solid,:dash,:dot,:dashdot,:dashdotdot]), (1,:))
n = length(styles)
y = cumsum(randn(20,n),1)
plot(y,line=(5,styles),label=map(string,styles))
savefig("img/inspectdr/line_styles.svg"); nothing # hide
```

![](img/inspectdr/line_styles.svg)

### Marker types

```@example InspectDR
markers = reshape(filter((m->begin
            m in Plots.supported_markers()
        end),Plots._shape_keys), (1,:))
n = length(markers)
x = (linspace(0,10,n + 2))[2:end - 1]
y = repmat((reverse(x))',n,1)
scatter(x,y,m=(8,:auto),lab=map(string,markers),bg=:linen,xlim=(0,10),ylim=(0,10))
savefig("img/inspectdr/markers.svg"); nothing # hide
```

![](img/inspectdr/markers.svg)

### Bar

x is the midpoint of the bar. (todo: allow passing of edges instead of midpoints)

```@example InspectDR
bar(randn(99))
savefig("img/inspectdr/bar.svg"); nothing # hide
```

![](img/inspectdr/bar.svg)

### Histogram

```@example InspectDR
histogram(randn(1000),nbins=20)
savefig("img/inspectdr/histogram.svg"); nothing # hide
```

![](img/inspectdr/histogram.svg)

### Subplots

Use the `layout` keyword, and optionally the convenient `@layout` macro to generate
arbitrarily complex subplot layouts.


```@example InspectDR
l = @layout([a{0.1h};b [c;d e]])
plot(randn(100,5),layout=l,t=[:line :histogram :scatter :steppre :bar],
     leg=false,ticks=nothing,border=false)
savefig("img/inspectdr/subplots1.svg"); nothing # hide
```

![](img/inspectdr/subplots1.svg)

### Adding to subplots

Note here the automatic grid layout, as well as the order in which new series are added
to the plots.

```@example InspectDR
plot(Plots.fakedata(100,10),layout=4,palette=[:grays :blues :heat :lightrainbow],
     bg_inside=[:orange :pink :darkblue :black])
savefig("img/inspectdr/subplots2.svg"); nothing # hide
```

![](img/inspectdr/subplots2.svg)

```@example InspectDR
plot!(Plots.fakedata(100,10))
savefig("img/inspectdr/subplots3.svg"); nothing # hide
```

![](img/inspectdr/subplots3.svg)

### Open/High/Low/Close

Create an OHLC chart.  Pass in a list of (open,high,low,close) tuples as your `y`
argument.  This uses recipes to first convert the tuples to OHLC objects, and
subsequently create a :path series with the appropriate line segments.

```@example InspectDR
n = 20
hgt = rand(n) + 1
bot = randn(n)
openpct = rand(n)
closepct = rand(n)
y = OHLC[(openpct[i] * hgt[i] + bot[i],bot[i] + hgt[i],bot[i],closepct[i] * hgt[i] +
          bot[i]) for i = 1:n]
ohlc(y)
savefig("img/inspectdr/ohlc.svg"); nothing # hide
```

![](img/inspectdr/ohlc.svg)

### Annotations

The `annotations` keyword is used for text annotations in data-coordinates.  Pass in a
tuple (x,y,text) or a vector of annotations.  `annotate!(ann)` is shorthand for `plot!(;
annotation=ann)`.  Series annotations are used for annotating individual data points.
They require only the annotation... x/y values are computed.  A `PlotText` object can be
build with the method `text(string, attr...)`, which wraps font and color attributes.

```@example InspectDR
y = rand(10)
plot(y,annotations=(3,y[3],text("this is #3",:left)),leg=false)
annotate!([(5,y[5],text("this is #5",16,:red,:center)),
          (10,y[10],text("this is #10",:right,20,"courier"))])
scatter!(linspace(2,8,6),rand(6),marker=(50,0.2,:orange),
         series_annotations=["series","annotations","map","to","series",
                             text("data",:green)])
savefig("img/inspectdr/annotations.svg"); nothing # hide
```

![](img/inspectdr/annotations.svg)

### Custom Markers

A `Plots.Shape` is a light wrapper around vertices of a polygon.  For supported backends,
pass arbitrary polygons as the marker shapes.  Note: The center is (0,0) and the size is
expected to be rougly the area of the unit circle.

```@example InspectDR
verts =[(-1.0,1.0),(-1.28,0.6),(-0.2,-1.4),(0.2,-1.4),(1.28,0.6),(1.0,1.0),
        (-1.0,1.0),(-0.2,-0.6),(0.0,-0.2),(-0.4,0.6),(1.28,0.6),(0.2,-1.4),
        (-0.2,-1.4),(0.6,0.2),(-0.2,0.2),(0.0,-0.2),(0.2,0.2),(-0.2,-0.6)]
x = 0.1:0.2:0.9
y = 0.7 * rand(5) + 0.15
plot(x,y,line=(3,:dash,:lightblue),marker=(Shape(verts),30,RGBA(0,0,0,0.2)),
     bg=:pink,fg=:darkblue,xlim=(0,1),ylim=(0,1),leg=false)
savefig("img/inspectdr/custom_markers.svg"); nothing # hide
```

![](img/inspectdr/custom_markers.svg)

### Groups and Subplots

```@example InspectDR
group = rand(map((i->begin
                    "group $(i)"
                end),1:4),100)
plot(rand(100),layout=@layout([a b;c]),group=group,linetype=[:bar :scatter :steppre])
savefig("img/inspectdr/groups.svg"); nothing # hide
```

![](img/inspectdr/groups.svg)

```@example InspectDR
println("Example plots automatically generated: $(Dates.DateTime(now()))") # hide
```

- Supported arguments: `annotations`, `background_color`, `background_color_inside`, `background_color_legend`, `background_color_outside`, `background_color_subplot`, `bottom_margin`, `color_palette`, `discrete_values`, `dpi`, `fillalpha`, `fillcolor`, `foreground_color`, `foreground_color_axis`, `foreground_color_border`, `foreground_color_grid`, `foreground_color_guide`, `foreground_color_legend`, `foreground_color_subplot`, `foreground_color_text`, `foreground_color_title`, `grid`, `group`, `guide`, `guidefont`, `html_output_format`, `label`, `layout`, `left_margin`, `legend`, `legendfont`, `lims`, `linealpha`, `linecolor`, `linestyle`, `linewidth`, `link`, `margin`, `markeralpha`, `markercolor`, `markershape`, `markersize`, `markerstrokealpha`, `markerstrokecolor`, `markerstrokestyle`, `markerstrokewidth`, `match_dimensions`, `overwrite_figure`, `polar`, `primary`, `projection`, `right_margin`, `scale`, `series_annotations`, `seriesalpha`, `seriescolor`, `seriestype`, `show`, `size`, `smooth`, `subplot`, `subplot_index`, `tickfont`, `title`, `title_location`, `titlefont`, `top_margin`, `window_title`, `x`, `xdiscrete_values`, `xerror`, `xforeground_color_axis`, `xforeground_color_border`, `xforeground_color_guide`, `xforeground_color_text`, `xguide`, `xguidefont`, `xlims`, `xlink`, `xscale`, `xtickfont`, `y`, `ydiscrete_values`, `yerror`, `yforeground_color_axis`, `yforeground_color_border`, `yforeground_color_guide`, `yforeground_color_text`, `yguide`, `yguidefont`, `ylims`, `ylink`, `yscale`, `ytickfont`, `z`, `zdiscrete_values`, `zforeground_color_axis`, `zforeground_color_border`, `zforeground_color_guide`, `zforeground_color_text`, `zguide`, `zguidefont`, `zlims`, `zlink`, `zscale`, `ztickfont`
- Supported values for linetype: `:path`, `:scatter`, `:shape`
- Supported values for linestyle: `:auto`, `:dash`, `:dashdot`, `:dot`, `:solid`
- Supported values for marker: `:+`, `:auto`, `:circle`, `:cross`, `:diamond`, `:dtriangle`, `:heptagon`, `:hexagon`, `:hline`, `:ltriangle`, `:none`, `:octagon`, `:pentagon`, `:rect`, `:rtriangle`, `:star4`, `:star5`, `:star6`, `:star7`, `:star8`, `:utriangle`, `:vline`, `:x`, `:xcross`
(Automatically generated: 2017-05-31T16:38:34.425)
