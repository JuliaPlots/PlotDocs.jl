### Initialize

```@setup PlotlyJS
info("Generating example images for PlotlyJS backend")
```

```@example PlotlyJS
using Plots
plotlyjs()
srand(1234); size(600, 400); nothing # hide
```

### Lines

A simple line plot of the columns.

```@example PlotlyJS
plot(Plots.fakedata(50,5),w=3)
savefig("img/plotlyjs/lines.svg"); nothing # hide
```

![](img/plotlyjs/lines.svg)

### Parametric plots

Plot function pair (x(u), y(u)).

```@example PlotlyJS
plot(sin,(x->begin
            sin(2x)
        end),0,2π,line=4,leg=false,fill=(0,:orange))
savefig("img/plotlyjs/parametric.svg"); nothing # hide
```

![](img/plotlyjs/parametric.svg)

### Colors

Access predefined palettes (or build your own with the `colorscheme` method).
Line/marker colors are auto-generated from the plot's palette, unless overridden.  Set
the `z` argument to turn on series gradients.

```@example PlotlyJS
y = rand(100)
plot(0:10:100,rand(11,4),lab="lines",w=3,palette=:grays,fill=0,α=0.6)
scatter!(y,zcolor=abs.(y - 0.5),
         m=(:heat,0.8,stroke(1,:green)),ms=10 * abs.(y - 0.5) + 4,lab="grad")
savefig("img/plotlyjs/colors.svg"); nothing # hide
```

![](img/plotlyjs/colors.svg)

### Global

Change the guides/background/limits/ticks.  Convenience args `xaxis` and `yaxis` allow
you to pass a tuple or value which will be mapped to the relevant args automatically.
The `xaxis` below will be replaced with `xlabel` and `xlims` args automatically during
the preprocessing step. You can also use shorthand functions: `title!`, `xaxis!`,
`yaxis!`, `xlabel!`, `ylabel!`, `xlims!`, `ylims!`, `xticks!`, `yticks!`

```@example PlotlyJS
y = rand(20,3)
plot(y,xaxis=("XLABEL",(-5,30),0:2:20,:flip),background_color=RGB(0.2,0.2,0.2),leg=false)
hline!(mean(y,1) + rand(1,3),line=(4,:dash,0.6,[:lightgreen :green :darkgreen]))
vline!([5,10])
title!("TITLE")
yaxis!("YLABEL",:log10)
savefig("img/plotlyjs/global.svg"); nothing # hide
```

![](img/plotlyjs/global.svg)

### Arguments

Plot multiple series with different numbers of points.  Mix arguments that apply to all
series (marker/markersize) with arguments unique to each series (colors).  Special
arguments `line`, `marker`, and `fill` will automatically figure out what arguments to
set (for example, we are setting the `linestyle`, `linewidth`, and `color` arguments with
`line`.)  Note that we pass a matrix of colors, and this applies the colors to each
series.

```@example PlotlyJS
ys = Vector[rand(10),rand(20)]
plot(ys,color=[:black :orange],line=(:dot,4),marker=([:hex :d],12,0.8,stroke(3,:gray)))
savefig("img/plotlyjs/arguments.svg"); nothing # hide
```

![](img/plotlyjs/arguments.svg)

### Build plot in pieces

Start with a base plot...

```@example PlotlyJS
plot(rand(100) / 3,reg=true,fill=(0,:green))
savefig("img/plotlyjs/pieces1.svg"); nothing # hide
```

![](img/plotlyjs/pieces1.svg)

and add to it later.

```@example PlotlyJS
scatter!(rand(100),markersize=6,c=:orange)
savefig("img/plotlyjs/pieces2.svg"); nothing # hide
```

![](img/plotlyjs/pieces2.svg)

### Histogram2D

```@example PlotlyJS
histogram2d(randn(10000),randn(10000),nbins=20)
savefig("img/plotlyjs/histogram2d.svg"); nothing # hide
```

![](img/plotlyjs/histogram2d.svg)

### Line types

```@example PlotlyJS
linetypes = [:path :steppre :steppost :sticks :scatter]
n = length(linetypes)
x = Vector[sort(rand(20)) for i = 1:n]
y = rand(20,n)
plot(x,y,line=(linetypes,3),lab=map(string,linetypes),ms=15)
savefig("img/plotlyjs/line_types.svg"); nothing # hide
```

![](img/plotlyjs/line_types.svg)

### Line styles

```@example PlotlyJS
styles = reshape(filter((s->begin
            s in Plots.supported_styles()
        end),[:solid,:dash,:dot,:dashdot,:dashdotdot]), (1,:))
n = length(styles)
y = cumsum(randn(20,n),1)
plot(y,line=(5,styles),label=map(string,styles))
savefig("img/plotlyjs/line_styles.svg"); nothing # hide
```

![](img/plotlyjs/line_styles.svg)

### Marker types

```@example PlotlyJS
markers = reshape(filter((m->begin
            m in Plots.supported_markers()
        end),Plots._shape_keys), (1,:))
n = length(markers)
x = (linspace(0,10,n + 2))[2:end - 1]
y = repmat((reverse(x))',n,1)
scatter(x,y,m=(8,:auto),lab=map(string,markers),bg=:linen,xlim=(0,10),ylim=(0,10))
savefig("img/plotlyjs/markers.svg"); nothing # hide
```

![](img/plotlyjs/markers.svg)

### Bar

x is the midpoint of the bar. (todo: allow passing of edges instead of midpoints)

```@example PlotlyJS
bar(randn(99))
savefig("img/plotlyjs/bar.svg"); nothing # hide
```

![](img/plotlyjs/bar.svg)

### Histogram

```@example PlotlyJS
histogram(randn(1000),nbins=20)
savefig("img/plotlyjs/histogram.svg"); nothing # hide
```

![](img/plotlyjs/histogram.svg)

### Subplots

Use the `layout` keyword, and optionally the convenient `@layout` macro to generate
arbitrarily complex subplot layouts.


```@example PlotlyJS
l = @layout([a{0.1h};b [c;d e]])
plot(randn(100,5),layout=l,
     t=[:line :histogram :scatter :steppre :bar],leg=false,ticks=nothing,border=false)
savefig("img/plotlyjs/subplots1.svg"); nothing # hide
```

![](img/plotlyjs/subplots1.svg)

### Adding to subplots

Note here the automatic grid layout, as well as the order in which new series are added
to the plots.

```@example PlotlyJS
plot(Plots.fakedata(100,10),layout=4,
     palette=[:grays :blues :heat :lightrainbow],
     bg_inside=[:orange :pink :darkblue :black])
savefig("img/plotlyjs/subplots2.svg"); nothing # hide
```

![](img/plotlyjs/subplots2.svg)

```@example PlotlyJS
srand(111)
plot!(Plots.fakedata(100,10))
savefig("img/plotlyjs/subplots3.svg"); nothing # hide
```

![](img/plotlyjs/subplots3.svg)

### Open/High/Low/Close

Create an OHLC chart.  Pass in a list of (open,high,low,close) tuples as your `y`
argument.  This uses recipes to first convert the tuples to OHLC objects, and
subsequently create a :path series with the appropriate line segments.

```@example PlotlyJS
n = 20
hgt = rand(n) + 1
bot = randn(n)
openpct = rand(n)
closepct = rand(n)
y = OHLC[(openpct[i] * hgt[i] + bot[i],bot[i] + hgt[i],bot[i],closepct[i] * hgt[i] +
          bot[i]) for i = 1:n]
ohlc(y)
savefig("img/plotlyjs/ohlc.svg"); nothing # hide
```

![](img/plotlyjs/ohlc.svg)

### Annotations

The `annotations` keyword is used for text annotations in data-coordinates.  Pass in a
tuple (x,y,text) or a vector of annotations.  `annotate!(ann)` is shorthand for `plot!(;
annotation=ann)`.  Series annotations are used for annotating individual data points.
They require only the annotation... x/y values are computed.  A `PlotText` object can be
build with the method `text(string, attr...)`, which wraps font and color attributes.

```@example PlotlyJS
y = rand(10)
plot(y,annotations=(3,y[3],text("this is #3",:left)),leg=false)
annotate!([(5,y[5],text("this is #5",16,:red,:center)),
          (10,y[10],text("this is #10",:right,20,"courier"))])
scatter!(linspace(2,8,6),rand(6),marker=(50,0.2,:orange),
         series_annotations=["series","annotations","map","to","series",
                             text("data",:green)])
savefig("img/plotlyjs/annotations.svg"); nothing # hide
```

![](img/plotlyjs/annotations.svg)

### Custom Markers

A `Plots.Shape` is a light wrapper around vertices of a polygon.  For supported backends, pass arbitrary polygons as the marker shapes.  Note: The center is (0,0) and the size is expected to be rougly the area of the unit circle.

```@example PlotlyJS
verts = [(-1.0,1.0),(-1.28,0.6),(-0.2,-1.4),(0.2,-1.4),(1.28,0.6),(1.0,1.0),(-1.0,1.0),
         (-0.2,-0.6),(0.0,-0.2),(-0.4,0.6),(1.28,0.6),(0.2,-1.4),(-0.2,-1.4),(0.6,0.2),
         (-0.2,0.2),(0.0,-0.2),(0.2,0.2),(-0.2,-0.6)]
x = 0.1:0.2:0.9
y = 0.7 * rand(5) + 0.15
plot(x,y,line=(3,:dash,:lightblue),marker=(Shape(verts),30,RGBA(0,0,0,0.2)),bg=:pink,
     fg=:darkblue,xlim=(0,1),ylim=(0,1),leg=false)
savefig("img/plotlyjs/custom_markers.svg"); nothing # hide
```

![](img/plotlyjs/custom_markers.svg)

### Contours

Any value for fill works here.  We first build a filled contour from a function, then an unfilled contour from a matrix.

```@example PlotlyJS
x = 1:0.5:20
y = 1:0.5:10
f(x,y) = begin
        (3x + y ^ 2) * abs(sin(x) + cos(y))
    end
X = repmat(x',length(y),1)
Y = repmat(y,1,length(x))
Z = map(f,X,Y)
p1 = contour(x,y,f,fill=true)
p2 = contour(x,y,Z)
plot(p1,p2)
savefig("img/plotlyjs/contours.svg"); nothing # hide
```

![](img/plotlyjs/contours.svg)

### Pie

```@example PlotlyJS
x = ["Nerds","Hackers","Scientists"]
y = [0.4,0.35,0.25]
pie(x,y,title="The Julia Community",l=0.5)
savefig("img/plotlyjs/pie.svg"); nothing # hide
```

![](img/plotlyjs/pie.svg)

### 3D

```@example PlotlyJS
n = 100
ts = linspace(0,8π,n)
x = ts .* map(cos,ts)
y = (0.1ts) .* map(sin,ts)
z = 1:n
plot(x,y,z,zcolor=reverse(z),m=(10,0.8,:blues,stroke(0)),leg=false,cbar=true,w=5)
plot!(zeros(n),zeros(n),1:n,w=10)
savefig("img/plotlyjs/3d.svg"); nothing # hide
```

![](img/plotlyjs/3d.svg)

### Groups and Subplots

```@example PlotlyJS
group = rand(map((i->begin
                    "group $(i)"
                end),1:4),100)
plot(rand(100),layout=@layout([a b;c]),group=group,linetype=[:bar :scatter :steppre])
savefig("img/plotlyjs/groups.svg"); nothing # hide
```

![](img/plotlyjs/groups.svg)

### Heatmap, categorical axes, and aspect_ratio

```@example PlotlyJS
xs = [string("x",i) for i = 1:10]
ys = [string("y",i) for i = 1:4]
z = float((1:4) * (1:10)')
heatmap(xs,ys,z,aspect_ratio=1)
savefig("img/plotlyjs/heatmap_cataxes_aspectratio.svg"); nothing # hide
```

![](img/plotlyjs/heatmap_cataxes_aspectratio.svg)

### Layouts, margins, label rotation, title location

```@example PlotlyJS
import Plots: mm, px
plot(rand(100,6),layout=@layout([a b;c]),title=["A" "B" "C"],title_location=:left,left_margin=[20mm 0mm],bottom_margin=50px,xrotation=60)
savefig("img/plotlyjs/layouts_margins_labelrot_titleloc.svg"); nothing # hide
```

![](img/plotlyjs/layouts_margins_labelrot_titleloc.svg)

```@example PlotlyJS
println("Example plots automatically generated: $(Dates.DateTime(now()))") # hide
```

- Supported arguments: `annotations`, `aspect_ratio`, `background_color`, `background_color_inside`, `background_color_legend`, `background_color_outside`, `background_color_subplot`, `bar_width`, `bins`, `bottom_margin`, `clims`, `color_palette`, `colorbar`, `colorbar_title`, `discrete_values`, `fill_z`, `fillalpha`, `fillcolor`, `fillrange`, `flip`, `foreground_color`, `foreground_color_border`, `foreground_color_guide`, `foreground_color_legend`, `foreground_color_subplot`, `foreground_color_text`, `foreground_color_title`, `grid`, `group`, `guide`, `guidefont`, `hover`, `html_output_format`, `inset_subplots`, `label`, `layout`, `left_margin`, `legend`, `legendfont`, `levels`, `lims`, `linealpha`, `linecolor`, `linestyle`, `linewidth`, `link`, `margin`, `marker_z`, `markeralpha`, `markercolor`, `markershape`, `markersize`, `markerstrokealpha`, `markerstrokecolor`, `markerstrokestyle`, `markerstrokewidth`, `normalize`, `orientation`, `polar`, `primary`, `projection`, `quiver`, `ribbon`, `right_margin`, `rotation`, `scale`, `series_annotations`, `seriesalpha`, `seriescolor`, `seriestype`, `show`, `size`, `smooth`, `subplot`, `subplot_index`, `tickfont`, `ticks`, `title`, `title_location`, `titlefont`, `top_margin`, `weights`, `window_title`, `x`, `xdiscrete_values`, `xerror`, `xflip`, `xforeground_color_border`, `xforeground_color_guide`, `xforeground_color_text`, `xguide`, `xguidefont`, `xlims`, `xlink`, `xrotation`, `xscale`, `xtickfont`, `xticks`, `y`, `ydiscrete_values`, `yerror`, `yflip`, `yforeground_color_border`, `yforeground_color_guide`, `yforeground_color_text`, `yguide`, `yguidefont`, `ylims`, `ylink`, `yrotation`, `yscale`, `ytickfont`, `yticks`, `z`, `zdiscrete_values`, `zflip`, `zforeground_color_border`, `zforeground_color_guide`, `zforeground_color_text`, `zguide`, `zguidefont`, `zlims`, `zlink`, `zrotation`, `zscale`, `ztickfont`, `zticks`
- Supported values for linetype: `:bar`, `:contour`, `:heatmap`, `:path`, `:path3d`, `:pie`, `:scatter`, `:scatter3d`, `:scattergl`, `:shape`, `:surface`, `:wireframe`
- Supported values for linestyle: `:auto`, `:dash`, `:dashdot`, `:dot`, `:solid`
- Supported values for marker: `:auto`, `:circle`, `:cross`, `:diamond`, `:dtriangle`, `:hexagon`, `:hline`, `:none`, `:octagon`, `:pentagon`, `:rect`, `:utriangle`, `:vline`, `:xcross`
(Automatically generated: 2017-05-31T15:24:42.231)
