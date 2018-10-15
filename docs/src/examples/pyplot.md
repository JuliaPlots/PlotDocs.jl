### Initialize

```julia
using Plots
pyplot()
```

### Lines

A simple line plot of the columns.

```julia
plot(Plots.fakedata(50, 5), w=3)
```

![](https://raw.githubusercontent.com/JuliaPlots/PlotReferenceImages.jl/master/PlotDocs/pyplot/ref1.png)

### Functions, adding data, and animations

Plot multiple functions.  You can also put the function first, or use the form `plot(f,
xmin, xmax)` where f is a Function or AbstractVector{Function}.

Get series data:
`x, y = plt[i]`.  Set series data: `plt[i] = (x,y)`. Add to the series with
`push!`/`append!`.

Easily build animations.  (`convert` or `ffmpeg` must be available
to generate the animation.)  Use command `gif(anim, filename, fps=15)` to save the
animation.


```julia
p = plot([sin, cos], zeros(0), leg=false)
anim = Animation()
for x = range(0, stop=10π, length=100)
    push!(p, x, Float64[sin(x), cos(x)])
    frame(anim)
end
```

![](https://raw.githubusercontent.com/JuliaPlots/PlotReferenceImages.jl/master/PlotDocs/pyplot/ref2.gif)

### Parametric plots

Plot function pair (x(u), y(u)).

```julia
plot(sin, (x->begin
            sin(2x)
        end), 0, 2π, line=4, leg=false, fill=(0, :orange))
```

![](https://raw.githubusercontent.com/JuliaPlots/PlotReferenceImages.jl/master/PlotDocs/pyplot/ref3.png)

### Colors

Access predefined palettes (or build your own with the `colorscheme` method).
Line/marker colors are auto-generated from the plot's palette, unless overridden.  Set
the `z` argument to turn on series gradients.


```julia
y = rand(100)
plot(0:10:100, rand(11, 4), lab="lines", w=3, palette=:grays, fill=0, α=0.6)
scatter!(y, zcolor=abs.(y .- 0.5), m=(:heat, 0.8, Plots.stroke(1, :green)), ms=10 * abs.(y .- 0.5) .+ 4, lab="grad")
```

![](https://raw.githubusercontent.com/JuliaPlots/PlotReferenceImages.jl/master/PlotDocs/pyplot/ref4.png)

### Global

Change the guides/background/limits/ticks.  Convenience args `xaxis` and `yaxis` allow
you to pass a tuple or value which will be mapped to the relevant args automatically.
The `xaxis` below will be replaced with `xlabel` and `xlims` args automatically during
the preprocessing step. You can also use shorthand functions: `title!`, `xaxis!`,
`yaxis!`, `xlabel!`, `ylabel!`, `xlims!`, `ylims!`, `xticks!`, `yticks!`


```julia
using Statistics
y = rand(20, 3)
plot(y, xaxis=("XLABEL", (-5, 30), 0:2:20, :flip), background_color=RGB(0.2, 0.2, 0.2), leg=false)
hline!(mean(y, dims=1) + rand(1, 3), line=(4, :dash, 0.6, [:lightgreen :green :darkgreen]))
vline!([5, 10])
title!("TITLE")
yaxis!("YLABEL", :log10)
```

![](https://raw.githubusercontent.com/JuliaPlots/PlotReferenceImages.jl/master/PlotDocs/pyplot/ref5.png)

### Images

Plot an image.  y-axis is set to flipped

```julia
import FileIO, PlotReferenceImages
img = FileIO.load(joinpath(dirname(pathof(PlotReferenceImages)), "..", "Plots", "pyplot", "0.7.0", "ref1.png"))
plot(img)
```

![](https://raw.githubusercontent.com/JuliaPlots/PlotReferenceImages.jl/master/PlotDocs/pyplot/ref6.png)

### Arguments

Plot multiple series with different numbers of points.  Mix arguments that apply to all
series (marker/markersize) with arguments unique to each series (colors).  Special
arguments `line`, `marker`, and `fill` will automatically figure out what arguments to
set (for example, we are setting the `linestyle`, `linewidth`, and `color` arguments with
`line`.)  Note that we pass a matrix of colors, and this applies the colors to each
series.


```julia
ys = Vector[rand(10), rand(20)]
plot(ys, color=[:black :orange], line=(:dot, 4), marker=([:hex :d], 12, 0.8, Plots.stroke(3, :gray)))
```

![](https://raw.githubusercontent.com/JuliaPlots/PlotReferenceImages.jl/master/PlotDocs/pyplot/ref7.png)

### Build plot in pieces

Start with a base plot...

```julia
plot(rand(100) / 3, reg=true, fill=(0, :green))
```

![](https://raw.githubusercontent.com/JuliaPlots/PlotReferenceImages.jl/master/PlotDocs/pyplot/ref8.png)

### 

and add to it later.

```julia
scatter!(rand(100), markersize=6, c=:orange)
```

![](https://raw.githubusercontent.com/JuliaPlots/PlotReferenceImages.jl/master/PlotDocs/pyplot/ref9.png)

### Histogram2D



```julia
histogram2d(randn(10000), randn(10000), nbins=20)
```

![](https://raw.githubusercontent.com/JuliaPlots/PlotReferenceImages.jl/master/PlotDocs/pyplot/ref10.png)

### Line types



```julia
linetypes = [:path :steppre :steppost :sticks :scatter]
n = length(linetypes)
x = Vector[sort(rand(20)) for i = 1:n]
y = rand(20, n)
plot(x, y, line=(linetypes, 3), lab=map(string, linetypes), ms=15)
```

![](https://raw.githubusercontent.com/JuliaPlots/PlotReferenceImages.jl/master/PlotDocs/pyplot/ref11.png)

### Line styles



```julia
styles = filter((s->begin
                s in Plots.supported_styles()
            end), [:solid, :dash, :dot, :dashdot, :dashdotdot])
styles = reshape(styles, 1, length(styles))
n = length(styles)
y = cumsum(randn(20, n), dims=1)
plot(y, line=(5, styles), label=map(string, styles), legendtitle="linestyle")
```

![](https://raw.githubusercontent.com/JuliaPlots/PlotReferenceImages.jl/master/PlotDocs/pyplot/ref12.png)

### Marker types



```julia
markers = filter((m->begin
                m in Plots.supported_markers()
            end), Plots._shape_keys)
markers = reshape(markers, 1, length(markers))
n = length(markers)
x = (range(0, stop=10, length=n + 2))[2:end - 1]
y = repeat(reshape(reverse(x), 1, :), n, 1)
scatter(x, y, m=(8, :auto), lab=map(string, markers), bg=:linen, xlim=(0, 10), ylim=(0, 10))
```

![](https://raw.githubusercontent.com/JuliaPlots/PlotReferenceImages.jl/master/PlotDocs/pyplot/ref13.png)

### Bar

x is the midpoint of the bar. (todo: allow passing of edges instead of midpoints)

```julia
bar(randn(99))
```

![](https://raw.githubusercontent.com/JuliaPlots/PlotReferenceImages.jl/master/PlotDocs/pyplot/ref14.png)

### Histogram



```julia
histogram(randn(1000), bins=:scott, weights=repeat(1:5, outer=200))
```

![](https://raw.githubusercontent.com/JuliaPlots/PlotReferenceImages.jl/master/PlotDocs/pyplot/ref15.png)

### Subplots

Use the `layout` keyword, and optionally the convenient `@layout` macro to generate
arbitrarily complex subplot layouts.


```julia
l = @layout()
plot(randn(100, 5), layout=l, t=[:line :histogram :scatter :steppre :bar], leg=false, ticks=nothing, border=:none)
```

![](https://raw.githubusercontent.com/JuliaPlots/PlotReferenceImages.jl/master/PlotDocs/pyplot/ref16.png)

### Adding to subplots

Note here the automatic grid layout, as well as the order in which new series are added
to the plots.


```julia
plot(Plots.fakedata(100, 10), layout=4, palette=[:grays :blues :heat :lightrainbow], bg_inside=[:orange :pink :darkblue :black])
```

![](https://raw.githubusercontent.com/JuliaPlots/PlotReferenceImages.jl/master/PlotDocs/pyplot/ref17.png)

### 



```julia
using Random
Random.seed!(111)
plot!(Plots.fakedata(100, 10))
```

![](https://raw.githubusercontent.com/JuliaPlots/PlotReferenceImages.jl/master/PlotDocs/pyplot/ref18.png)

### Open/High/Low/Close

Create an OHLC chart.  Pass in a list of (open,high,low,close) tuples as your `y`
argument.  This uses recipes to first convert the tuples to OHLC objects, and
subsequently create a :path series with the appropriate line segments.


```julia
n = 20
hgt = rand(n) .+ 1
bot = randn(n)
openpct = rand(n)
closepct = rand(n)
y = OHLC[(openpct[i] * hgt[i] + bot[i], bot[i] + hgt[i], bot[i], closepct[i] * hgt[i] + bot[i]) for i = 1:n]
ohlc(y)
```

![](https://raw.githubusercontent.com/JuliaPlots/PlotReferenceImages.jl/master/PlotDocs/pyplot/ref19.png)

### Annotations

The `annotations` keyword is used for text annotations in data-coordinates.  Pass in a
tuple (x,y,text) or a vector of annotations.  `annotate!(ann)` is shorthand for `plot!(;
annotation=ann)`.  Series annotations are used for annotating individual data points.
They require only the annotation... x/y values are computed.  A `PlotText` object can be
build with the method `text(string, attr...)`, which wraps font and color attributes.


```julia
y = rand(10)
plot(y, annotations=(3, y[3], text("this is #3", :left)), leg=false)
annotate!([(5, y[5], text("this is #5", 16, :red, :center)), (10, y[10], text("this is #10", :right, 20, "courier"))])
scatter!(range(2, stop=8, length=6), rand(6), marker=(50, 0.2, :orange), series_annotations=["series", "annotations", "map", "to", "series", text("data", :green)])
```

![](https://raw.githubusercontent.com/JuliaPlots/PlotReferenceImages.jl/master/PlotDocs/pyplot/ref20.png)

### Custom Markers

A `Plots.Shape` is a light wrapper around vertices of a polygon.  For supported
backends, pass arbitrary polygons as the marker shapes.  Note: The center is (0,0) and
the size is expected to be rougly the area of the unit circle.


```julia
verts = [(-1.0, 1.0), (-1.28, 0.6), (-0.2, -1.4), (0.2, -1.4), (1.28, 0.6), (1.0, 1.0), (-1.0, 1.0), (-0.2, -0.6), (0.0, -0.2), (-0.4, 0.6), (1.28, 0.6), (0.2, -1.4), (-0.2, -1.4), (0.6, 0.2), (-0.2, 0.2), (0.0, -0.2), (0.2, 0.2), (-0.2, -0.6)]
x = 0.1:0.2:0.9
y = 0.7 * rand(5) .+ 0.15
plot(x, y, line=(3, :dash, :lightblue), marker=(Shape(verts), 30, RGBA(0, 0, 0, 0.2)), bg=:pink, fg=:darkblue, xlim=(0, 1), ylim=(0, 1), leg=false)
```

![](https://raw.githubusercontent.com/JuliaPlots/PlotReferenceImages.jl/master/PlotDocs/pyplot/ref21.png)

### Contours

Any value for fill works here.  We first build a filled contour from a function, then an
unfilled contour from a matrix.


```julia
x = 1:0.5:20
y = 1:0.5:10
f(x, y) = begin
        (3x + y ^ 2) * abs(sin(x) + cos(y))
    end
X = repeat(reshape(x, 1, :), length(y), 1)
Y = repeat(y, 1, length(x))
Z = map(f, X, Y)
p1 = contour(x, y, f, fill=true)
p2 = contour(x, y, Z)
plot(p1, p2)
```

![](https://raw.githubusercontent.com/JuliaPlots/PlotReferenceImages.jl/master/PlotDocs/pyplot/ref22.png)

### Pie



```julia
x = ["Nerds", "Hackers", "Scientists"]
y = [0.4, 0.35, 0.25]
pie(x, y, title="The Julia Community", l=0.5)
```

![](https://raw.githubusercontent.com/JuliaPlots/PlotReferenceImages.jl/master/PlotDocs/pyplot/ref23.png)

### 3D



```julia
n = 100
ts = range(0, stop=8π, length=n)
x = ts .* map(cos, ts)
y = (0.1ts) .* map(sin, ts)
z = 1:n
plot(x, y, z, zcolor=reverse(z), m=(10, 0.8, :blues, Plots.stroke(0)), leg=false, cbar=true, w=5)
plot!(zeros(n), zeros(n), 1:n, w=10)
```

![](https://raw.githubusercontent.com/JuliaPlots/PlotReferenceImages.jl/master/PlotDocs/pyplot/ref24.png)

### Groups and Subplots



```julia
group = rand(map((i->begin
                    "group $(i)"
                end), 1:4), 100)
plot(rand(100), layout=@layout(), group=group, linetype=[:bar :scatter :steppre], linecolor=:match)
```

![](https://raw.githubusercontent.com/JuliaPlots/PlotReferenceImages.jl/master/PlotDocs/pyplot/ref26.png)

### Polar Plots



```julia
Θ = range(0, stop=1.5π, length=100)
r = abs.(0.1 * randn(100) + sin.(3Θ))
plot(Θ, r, proj=:polar, m=2)
```

![](https://raw.githubusercontent.com/JuliaPlots/PlotReferenceImages.jl/master/PlotDocs/pyplot/ref27.png)

### Heatmap, categorical axes, and aspect_ratio



```julia
xs = [string("x", i) for i = 1:10]
ys = [string("y", i) for i = 1:4]
z = float((1:4) * reshape(1:10, 1, :))
heatmap(xs, ys, z, aspect_ratio=1)
```

![](https://raw.githubusercontent.com/JuliaPlots/PlotReferenceImages.jl/master/PlotDocs/pyplot/ref28.png)

### Layouts, margins, label rotation, title location



```julia
using Plots.PlotMeasures
plot(rand(100, 6), layout=@layout(), title=["A" "B" "C"], title_location=:left, left_margin=[20mm 0mm], bottom_margin=10px, xrotation=60)
```

![](https://raw.githubusercontent.com/JuliaPlots/PlotReferenceImages.jl/master/PlotDocs/pyplot/ref29.png)

### Animation with subplots

The `layout` macro can be used to create an animation with subplots.

```julia
l = @layout()
p = plot(plot([sin, cos], 1, leg=false), scatter([atan, cos], 1, leg=false), plot(log, 1, xlims=(1, 10π), ylims=(0, 5), leg=false), layout=l)
anim = Animation()
for x = range(1, stop=10π, length=100)
    plot(push!(p, x, Float64[sin(x), cos(x), atan(x), cos(x), log(x)]))
    frame(anim)
end
```

![](https://raw.githubusercontent.com/JuliaPlots/PlotReferenceImages.jl/master/PlotDocs/pyplot/ref31.png)

### Spy

For a matrix `mat` with unique nonzeros `spy(mat)` returns a colorless plot. If `mat` has
various different nonzero values, a colorbar is added. The colorbar can be disabled with
`legend = nothing`.


```julia
using SparseArrays
a = spdiagm(0 => ones(50), 1 => ones(49), -1 => ones(49), 10 => ones(40), -10 => ones(40))
b = spdiagm(0 => 1:50, 1 => 1:49, -1 => 1:49, 10 => 1:40, -10 => 1:40)
plot(spy(a), spy(b), title=["Unique nonzeros" "Different nonzeros"])
```

![](https://raw.githubusercontent.com/JuliaPlots/PlotReferenceImages.jl/master/PlotDocs/pyplot/ref32.png)

### Magic grid argument

The grid lines can be modified individually for each axis with the magic `grid` argument.


```julia
x = rand(10)
p1 = plot(x, title="Default looks")
p2 = plot(x, grid=(:y, :olivedrab, :dot, 1, 0.9), title="Modified y grid")
p3 = plot(deepcopy(p2), title="Add x grid")
xgrid!(p3, :on, :cadetblue, 2, :dashdot, 0.4)
plot(p1, p2, p3, layout=(1, 3), label="", fillrange=0, fillalpha=0.3)
```

![](https://raw.githubusercontent.com/JuliaPlots/PlotReferenceImages.jl/master/PlotDocs/pyplot/ref33.png)

### Framestyle

The style of the frame/axes of a (sub)plot can be changed with the `framestyle`
attribute. The default framestyle is `:axes`.


```julia
scatter(fill(randn(10), 6), fill(randn(10), 6), framestyle=[:box :semi :origin :zerolines :grid :none], title=[":box" ":semi" ":origin" ":zerolines" ":grid" ":none"], color=permutedims(1:6), layout=6, label="", markerstrokewidth=0, ticks=-2:2)
```

![](https://raw.githubusercontent.com/JuliaPlots/PlotReferenceImages.jl/master/PlotDocs/pyplot/ref34.png)

### Lines and markers with varying colors

You can use the `line_z` and `marker_z` properties to associate a color with
each line segment or marker in the plot.


```julia
t = range(0, stop=1, length=100)
θ = (6π) .* t
x = t .* cos.(θ)
y = t .* sin.(θ)
p1 = plot(x, y, line_z=t, linewidth=3, legend=false)
p2 = scatter(x, y, marker_z=((x, y)->begin
                    x + y
                end), color=:bluesreds, legend=false)
plot(p1, p2)
```

![](https://raw.githubusercontent.com/JuliaPlots/PlotReferenceImages.jl/master/PlotDocs/pyplot/ref35.png)

- Supported arguments: `annotations`, `arrow`, `aspect_ratio`, `background_color`, `background_color_inside`, `background_color_legend`, `background_color_outside`, `background_color_subplot`, `bar_edges`, `bar_position`, `bar_width`, `bins`, `bottom_margin`, `camera`, `clims`, `color_palette`, `colorbar`, `colorbar_title`, `contour_labels`, `contours`, `discrete_values`, `dpi`, `fill_z`, `fillalpha`, `fillcolor`, `fillrange`, `flip`, `foreground_color`, `foreground_color_axis`, `foreground_color_border`, `foreground_color_grid`, `foreground_color_guide`, `foreground_color_legend`, `foreground_color_subplot`, `foreground_color_text`, `foreground_color_title`, `framestyle`, `grid`, `gridalpha`, `gridlinewidth`, `gridstyle`, `group`, `guide`, `guide_position`, `guidefontcolor`, `guidefontfamily`, `guidefontsize`, `html_output_format`, `inset_subplots`, `label`, `layout`, `left_margin`, `legend`, `legendfontcolor`, `legendfontfamily`, `legendfontsize`, `legendtitle`, `levels`, `lims`, `line_z`, `linealpha`, `linecolor`, `linestyle`, `linewidth`, `link`, `margin`, `marker_z`, `markeralpha`, `markercolor`, `markershape`, `markersize`, `markerstrokealpha`, `markerstrokecolor`, `markerstrokewidth`, `match_dimensions`, `normalize`, `orientation`, `overwrite_figure`, `polar`, `primary`, `projection`, `quiver`, `ribbon`, `right_margin`, `rotation`, `scale`, `series_annotations`, `seriesalpha`, `seriescolor`, `seriestype`, `show`, `size`, `smooth`, `stride`, `subplot`, `subplot_index`, `tick_direction`, `tickfontcolor`, `tickfontfamily`, `tickfontsize`, `ticks`, `title`, `title_location`, `titlefont`, `titlefontcolor`, `titlefontfamily`, `titlefontsize`, `top_margin`, `weights`, `window_title`, `x`, `xdiscrete_values`, `xerror`, `xflip`, `xforeground_color_axis`, `xforeground_color_border`, `xforeground_color_grid`, `xforeground_color_guide`, `xforeground_color_text`, `xgrid`, `xgridalpha`, `xgridlinewidth`, `xgridstyle`, `xguide`, `xguide_position`, `xguidefontcolor`, `xguidefontfamily`, `xguidefontsize`, `xlims`, `xlink`, `xrotation`, `xscale`, `xtick_direction`, `xtickfontcolor`, `xtickfontfamily`, `xtickfontsize`, `xticks`, `y`, `ydiscrete_values`, `yerror`, `yflip`, `yforeground_color_axis`, `yforeground_color_border`, `yforeground_color_grid`, `yforeground_color_guide`, `yforeground_color_text`, `ygrid`, `ygridalpha`, `ygridlinewidth`, `ygridstyle`, `yguide`, `yguide_position`, `yguidefontcolor`, `yguidefontfamily`, `yguidefontsize`, `ylims`, `ylink`, `yrotation`, `yscale`, `ytick_direction`, `ytickfontcolor`, `ytickfontfamily`, `ytickfontsize`, `yticks`, `z`, `zdiscrete_values`, `zflip`, `zforeground_color_axis`, `zforeground_color_border`, `zforeground_color_grid`, `zforeground_color_guide`, `zforeground_color_text`, `zgrid`, `zgridalpha`, `zgridlinewidth`, `zgridstyle`, `zguide`, `zguide_position`, `zguidefontcolor`, `zguidefontfamily`, `zguidefontsize`, `zlims`, `zlink`, `zrotation`, `zscale`, `ztick_direction`, `ztickfontcolor`, `ztickfontfamily`, `ztickfontsize`, `zticks`
- Supported values for linetype: `:contour`, `:contour3d`, `:heatmap`, `:hexbin`, `:image`, `:path`, `:path3d`, `:pie`, `:scatter`, `:scatter3d`, `:shape`, `:steppost`, `:steppre`, `:straightline`, `:surface`, `:wireframe`
- Supported values for linestyle: `:auto`, `:dash`, `:dashdot`, `:dot`, `:solid`
- Supported values for marker: `:+`, `:auto`, `:circle`, `:cross`, `:diamond`, `:dtriangle`, `:heptagon`, `:hexagon`, `:hline`, `:ltriangle`, `:none`, `:octagon`, `:pentagon`, `:pixel`, `:rect`, `:rtriangle`, `:star4`, `:star5`, `:star6`, `:star7`, `:star8`, `:utriangle`, `:vline`, `:x`, `:xcross`
(Automatically generated: 2018-10-15T16:48:13.372)