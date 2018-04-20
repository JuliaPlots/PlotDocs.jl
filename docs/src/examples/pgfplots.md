### Initialize

```@setup PGFPlots
info("Generating example images for PGFPlots backend")
```

```@example PGFPlots
using Plots
pgfplots()
srand(1234); size(600, 400); nothing # hide
```

### Lines

A simple line plot of the columns.

```@example PGFPlots
plot(Plots.fakedata(50,5),w=3)
savefig("img/pgfplots/lines.svg"); nothing # hide
```

![](img/pgfplots/lines.svg)

### Parametric plots

Plot function pair (x(u), y(u)).

```@example PGFPlots
plot(sin,(x->begin
            sin(2x)
        end),0,2π,line=4,leg=false,fill=(0,:orange))
savefig("img/pgfplots/parametric.svg"); nothing # hide
```

![](img/pgfplots/parametric.svg)

### Global

Change the guides/background/limits/ticks.  Convenience args `xaxis` and `yaxis` allow
you to pass a tuple or value which will be mapped to the relevant args automatically.
The `xaxis` below will be replaced with `xlabel` and `xlims` args automatically during
the preprocessing step. You can also use shorthand functions: `title!`, `xaxis!`,
`yaxis!`, `xlabel!`, `ylabel!`, `xlims!`, `ylims!`, `xticks!`, `yticks!`

```@example PGFPlots
y = rand(20,3)
plot(y,xaxis=("XLABEL",(-5,30),0:2:20,:flip),background_color=RGB(0.2,0.2,0.2),leg=false)
hline!(mean(y,1) + rand(1,3),line=(4,:dash,0.6,[:lightgreen :green :darkgreen]))
vline!([5,10])
title!("TITLE")
yaxis!("YLABEL",:log10)
savefig("img/pgfplots/global.svg"); nothing # hide
```

![](img/pgfplots/global.svg)

### Extra LaTeX packages

You can add LaTeX formating with support for additional LaTeX packages with
`LaTeXStrings.jl` and `PGFPlots.pushPGFPlotsPreamble`. For example, if we add the package
`amssymb`, we can get Blackboard bold symbols with the `\mathbb` control sequence:

```@example PGFPlots
Pkg.add("LaTeXStrings") # hide
using LaTeXStrings
PGFPlots.pushPGFPlotsPreamble("\\usepackage{amssymb}")
ylabel!(L"$\mathbb E[f(x)]$")
savefig("img/pgfplots/extra_latex.svg"); nothing # hide
```

![](img/pgfplots/extra_latex.svg)

### Arguments

Plot multiple series with different numbers of points.  Mix arguments that apply to all
series (marker/markersize) with arguments unique to each series (colors).  Special
arguments `line`, `marker`, and `fill` will automatically figure out what arguments to
set (for example, we are setting the `linestyle`, `linewidth`, and `color` arguments with
`line`.)  Note that we pass a matrix of colors, and this applies the colors to each
series.

```@example PGFPlots
ys = Vector[rand(10),rand(20)]
plot(ys,color=[:black :orange],line=(:dot,4),marker=([:hex :d],12,0.8,stroke(3,:gray)))
savefig("img/pgfplots/arguments.svg"); nothing # hide
```

![](img/pgfplots/arguments.svg)

### Build plot in pieces

Start with a base plot...

```@example PGFPlots
plot(rand(100) / 3,reg=true,fill=(0,:green))
savefig("img/pgfplots/pieces1.svg"); nothing # hide
```

![](img/pgfplots/pieces1.svg)

and add to it later.

```@example PGFPlots
scatter!(rand(100),markersize=6,c=:orange)
savefig("img/pgfplots/pieces2.svg"); nothing # hide
```

![](img/pgfplots/pieces2.svg)

### Line types

```@example PGFPlots
linetypes = [:path :steppre :steppost :sticks :scatter]
n = length(linetypes)
x = Vector[sort(rand(20)) for i = 1:n]
y = rand(20,n)
plot(x,y,line=(linetypes,3),lab=map(string,linetypes),ms=15)
savefig("img/pgfplots/line_types.svg"); nothing # hide
```

![](img/pgfplots/line_types.svg)

### Line styles

```@example PGFPlots
styles = reshape(setdiff(Plots.supported_styles(),[:auto]), (1,:))
plot(cumsum(randn(20,length(styles)),1),style=:auto,label=map(string,styles),w=5)
savefig("img/pgfplots/line_styles.svg"); nothing # hide
```

![](img/pgfplots/line_styles.svg)

### Marker types

```@example PGFPlots
markers = reshape(setdiff(Plots.supported_markers(),[:none,:auto,Shape]), (1,:))
n = length(markers)
x = (linspace(0,10,n + 2))[2:end - 1]
y = repmat(reverse(x)',n,1)
scatter(x,y,m=(8,:auto),lab=map(string,markers),bg=:linen,xlim=(0,10),ylim=(0,10))
savefig("img/pgfplots/markers.svg"); nothing # hide
```

![](img/pgfplots/markers.svg)

### Bar

x is the midpoint of the bar. (todo: allow passing of edges instead of midpoints)

```@example PGFPlots
bar(randn(99))
savefig("img/pgfplots/bar.svg"); nothing # hide
```

![](img/pgfplots/bar.svg)

### Histogram

```@example PGFPlots
histogram(randn(1000),nbins=20)
savefig("img/pgfplots/histogram.svg"); nothing # hide
```

![](img/pgfplots/histogram.svg)

### Subplots

Use the `layout` keyword, and optionally the convenient `@layout` macro to generate
arbitrarily complex subplot layouts.


```@example PGFPlots
l = @layout([a{0.1h};b [c;d e]])
plot(randn(100,5),layout=l,
     t=[:line :histogram :scatter :steppre :bar],leg=false,ticks=nothing,border=false)
savefig("img/pgfplots/subplots1.svg"); nothing # hide
```

![](img/pgfplots/subplots1.svg)

### Adding to subplots

Note here the automatic grid layout, as well as the order in which new series are added
to the plots.

```@example PGFPlots
plot(Plots.fakedata(100,10),layout=4,
     palette=[:grays :blues :heat :lightrainbow],
     bg_inside=[:orange :pink :darkblue :black])
savefig("img/pgfplots/subplots2.svg"); nothing # hide
```

![](img/pgfplots/subplots2.svg)

```@example PGFPlots
plot!(Plots.fakedata(100,10))
savefig("img/pgfplots/subplots3.svg"); nothing # hide
```

![](img/pgfplots/subplots3.svg)

### Open/High/Low/Close

Create an OHLC chart.  Pass in a list of (open,high,low,close) tuples as your `y`
argument.  This uses recipes to first convert the tuples to OHLC objects, and
subsequently create a :path series with the appropriate line segments.

```@example PGFPlots
n = 20
hgt = rand(n) + 1
bot = randn(n)
openpct = rand(n)
closepct = rand(n)
y = OHLC[(openpct[i] * hgt[i] + bot[i],bot[i] + hgt[i],bot[i],closepct[i] * hgt[i] +
          bot[i]) for i = 1:n]
ohlc(y)
savefig("img/pgfplots/ohlc.svg"); nothing # hide
```

![](img/pgfplots/ohlc.svg)

### Annotations

The `annotations` keyword is used for text annotations in data-coordinates.  Pass in a
tuple (x,y,text) or a vector of annotations.  `annotate!(ann)` is shorthand for `plot!(;
annotation=ann)`.  Series annotations are used for annotating individual data points.
They require only the annotation... x/y values are computed.  A `PlotText` object can be
build with the method `text(string, attr...)`, which wraps font and color attributes.

```@example PGFPlots
y = rand(10)
plot(y,annotations=(3,y[3],text("this is #3",:left)),leg=false)
annotate!([(5,y[5],text("this is #5",16,:red,:center)),
          (10,y[10],text("this is #10",:right,20,"courier"))])
scatter!(linspace(2,8,6),rand(6),marker=(50,0.2,:orange),
         series_annotations=["series","annotations","map","to","series",
                             text("data",:green)])
savefig("img/pgfplots/annotations.svg"); nothing # hide
```

![](img/pgfplots/annotations.svg)

### Custom Markers

A `Plots.Shape` is a light wrapper around vertices of a polygon.  For supported backends,
pass arbitrary polygons as the marker shapes.  Note: The center is (0,0) and the size is
expected to be rougly the area of the unit circle.

```@example PGFPlots
verts =[(-1.0,1.0),(-1.28,0.6),(-0.2,-1.4),(0.2,-1.4),(1.28,0.6),(1.0,1.0),(-1.0,1.0),
        (-0.2,-0.6),(0.0,-0.2),(-0.4,0.6),(1.28,0.6),(0.2,-1.4),(-0.2,-1.4),(0.6,0.2),
        (-0.2,0.2),(0.0,-0.2),(0.2,0.2),(-0.2,-0.6)]
x = 0.1:0.2:0.9
y = 0.7 * rand(5) + 0.15
plot(x,y,line=(3,:dash,:lightblue),marker=(Shape(verts),30,RGBA(0,0,0,0.2)),bg=:pink,
     fg=:darkblue,xlim=(0,1),ylim=(0,1),leg=false)
savefig("img/pgfplots/custom_markers.svg"); nothing # hide
```

![](img/pgfplots/custom_markers.svg)

### 3D

```@example PGFPlots
n = 100
ts = linspace(0,8π,n)
x = ts .* map(cos,ts)
y = (0.1ts) .* map(sin,ts)
z = 1:n
plot(x,y,z,zcolor=reverse(z),m=(10,0.8,:blues,stroke(0)),leg=false,cbar=true,w=5)
plot!(zeros(n),zeros(n),1:n,w=10)
savefig("img/pgfplots/3d.svg"); nothing # hide
```

![](img/pgfplots/3d.svg)

### DataFrames

Plot using DataFrame column symbols.

```@example PGFPlots
Pkg.add("RDatasets") # hide
import RDatasets
iris = RDatasets.dataset("datasets","iris")
@df iris scatter(:SepalLength,:SepalWidth,group=:Species,title="My awesome plot",xlabel="Length",ylabel="Width",marker=(0.5,[:+ :h :star7],12),bg=RGB(0.2,0.2,0.2))
savefig("img/pgfplots/dataframes.svg"); nothing # hide
```

![](img/pgfplots/dataframes.svg)

### Polar Plots

```@example PGFPlots
Θ = linspace(0,1.5π,100)
r = abs(0.1 * randn(100) + sin.(3Θ))
plot(Θ,r,proj=:polar,m=2)
savefig("img/pgfplots/polar.svg"); nothing # hide
```

![](img/pgfplots/polar.svg)

### Layouts, margins, label rotation, title location



```@example PGFPlots
import Plots: mm, px
plot(rand(100,6),layout=@layout([a b;c]),
     title=["A" "B" "C"],title_location=:left,
     left_margin=[20mm 0mm],bottom_margin=50px,xrotation=60)
savefig("img/pgfplots/layouts_margins_labelrot_titleloc.svg"); nothing # hide
```

![](img/pgfplots/layouts_margins_labelrot_titleloc.svg)

```@example GR
println("Example plots automatically generated: $(Dates.DateTime(now()))") # hide
```

- Supported arguments: `aspect_ratio`, `background_color`, `background_color_inside`, `bins`, `color_palette`, `fillalpha`, `fillcolor`, `fillrange`, `foreground_color`, `grid`, `group`, `guidefont`, `label`, `layout`, `legend`, `legendfont`, `linealpha`, `linecolor`, `linestyle`, `linewidth`, `markeralpha`, `markercolor`, `markershape`, `markersize`, `markerstrokealpha`, `markerstrokecolor`, `markerstrokewidth`, `seriesalpha`, `seriescolor`, `seriestype`, `show`, `size`, `tickfont`, `title`, `x`, `xflip`, `xguide`, `xlims`, `xrotation`, `xscale`, `xticks`, `y`, `yflip`, `yguide`, `ylims`, `yrotation`, `yscale`, `yticks`, `z`, `zflip`, `zguide`, `zlims`, `zrotation`, `zscale`, `zticks`
- Supported values for axis: `:auto`, `:left`
- Supported values for linetype: `:contour`, `:histogram2d`, `:path`, `:path3d`, `:scatter`, `:stepmid`, `:steppost`, `:steppre`, `:xsticks`, `:ysticks`
- Supported values for linestyle: `:auto`, `:dash`, `:dashdot`, `:dashdotdot`, `:dot`, `:solid`
- Supported values for marker: `:auto`, `:cross`, `:diamond`, `:dtriangle`, `:circle`, `:none`, `:pentagon`, `:rect`, `:star5`, `:utriangle`, `:xcross`
- Is `subplot`/`subplot!` supported? No

(Automatically generated: 2016-06-09T17:39:13)
