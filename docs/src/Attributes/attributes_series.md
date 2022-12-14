
# Series Attributes

Series attributes apply to individual series, such as lines, scatters, heatmaps, etc. The detailed documentation will contain a list of series types for which the given attribute is relevant.

## Contents

| Attribute | Aliases |
| :--- | :--- |
| [`arrow`](@ref seriesattr_arrow) | `arrows` |
| [`bar_edges`](@ref seriesattr_bar_edges) | |
| [`bar_position`](@ref seriesattr_bar_position) | `bar_positions` `barpositions` |
| [`bar_width`](@ref seriesattr_bar_width) | `bar_widths` `barwidths` |
| [`bins`](@ref seriesattr_bins) | `bin` `nb` `nbin` `nbins` |
| [`colorbar_entry`](@ref seriesattr_colorbar_entry) | `colorbar_entrys` `colorbarentrys` |
| [`connections`](@ref seriesattr_connections) | |
| [`contour_labels`](@ref seriesattr_contour_labels) | `clabels` `clabs` `contourlabels` |
| [`contours`](@ref seriesattr_contours) | |
| [`extra_kwargs`](@ref seriesattr_extra_kwargs) | |
| [`fill_z`](@ref seriesattr_fill_z) | `fill_zs` `fillz` `fillzs` `fz` `sc` `surfacecolor` `surfacecolour` `surfcolor` `surfcolour` |
| [`fillalpha`](@ref seriesattr_fillalpha) | `fa` `falpha` `fillalphas` `fillopacity` `fopacity` `fα` |
| [`fillcolor`](@ref seriesattr_fillcolor) | `fc` `fcolor` `fcolour` `fillcolors` `fillcolour` |
| [`fillrange`](@ref seriesattr_fillrange) | `fill_between` `fillbetween` `fillranges` `fillrng` `fillto` `frange` |
| [`fillstyle`](@ref seriesattr_fillstyle) | `fillstyles` |
| [`group`](@ref seriesattr_group) | `g` `grouping` `groups` |
| [`hover`](@ref seriesattr_hover) | `hovers` |
| [`label`](@ref seriesattr_label) | `lab` `labels` |
| [`levels`](@ref seriesattr_levels) | `levs` `nlev` `nlevels` |
| [`line_z`](@ref seriesattr_line_z) | `line_zs` `linez` `linezs` `lz` `zline` |
| [`linealpha`](@ref seriesattr_linealpha) | `la` `lalpha` `linealphas` `lineopacity` `lopacity` `lα` |
| [`linecolor`](@ref seriesattr_linecolor) | `lc` `lcolor` `lcolour` `linecolors` `linecolour` |
| [`linestyle`](@ref seriesattr_linestyle) | `linestyles` `ls` `s` `style` |
| [`linewidth`](@ref seriesattr_linewidth) | `linewidths` `lw` `w` `width` |
| [`marker_z`](@ref seriesattr_marker_z) | `marker_zs` `markerz` `markerzs` `mz` `zcolor` |
| [`markeralpha`](@ref seriesattr_markeralpha) | `ma` `malpha` `markeralphas` `markeropacity` `mopacity` `mα` |
| [`markercolor`](@ref seriesattr_markercolor) | `markercolors` `markercolour` `mc` `mcolor` `mcolour` |
| [`markershape`](@ref seriesattr_markershape) | `markershapes` `shape` |
| [`markersize`](@ref seriesattr_markersize) | `markersizes` `ms` `msize` |
| [`markerstrokealpha`](@ref seriesattr_markerstrokealpha) | `markerstrokealphas` `markerstrokeopacity` `msa` `msalpha` `msopacity` `msα` |
| [`markerstrokecolor`](@ref seriesattr_markerstrokecolor) | `markerstrokecolors` `markerstrokecolour` `msc` `mscolor` `mscolour` |
| [`markerstrokestyle`](@ref seriesattr_markerstrokestyle) | `markerstrokestyles` |
| [`markerstrokewidth`](@ref seriesattr_markerstrokewidth) | `markerstrokewidths` `msw` `mswidth` |
| [`match_dimensions`](@ref seriesattr_match_dimensions) | |
| [`normalize`](@ref seriesattr_normalize) | `norm` `normalized` `normalizes` `normed` |
| [`orientation`](@ref seriesattr_orientation) | `dir` `direction` `orientations` |
| [`permute`](@ref seriesattr_permute) | `permutes` |
| [`primary`](@ref seriesattr_primary) | `primarys` |
| [`quiver`](@ref seriesattr_quiver) | `gradient` `quiver2d` `quivers` `vectorfield` `velocity` |
| [`ribbon`](@ref seriesattr_ribbon) | `rib` `ribbons` |
| [`series_annotations`](@ref seriesattr_series_annotations) | `series_ann` `series_annotation` `series_anns` `seriesann` `seriesannotation` `seriesanns` `text` `texts` `txt` `txts` |
| [`seriesalpha`](@ref seriesattr_seriesalpha) | `alpha` `opacity` `seriesalphas` `α` |
| [`seriescolor`](@ref seriesattr_seriescolor) | `c` `cmap` `color` `colormap` `colour` `seriescolors` |
| [`seriestype`](@ref seriesattr_seriestype) | `linetype` `lt` `seriestypes` `st` `t` `typ` |
| [`show_empty_bins`](@ref seriesattr_show_empty_bins) | `show_empty` `showempty` `showemptybins` |
| [`smooth`](@ref seriesattr_smooth) | `reg` `regression` `smooths` |
| [`stride`](@ref seriesattr_stride) | `str` `strides` `surf_str` `surface_stride` `surfacestride` `surfstr` `wirefame_stride` `wirefamestride` |
| [`subplot`](@ref seriesattr_subplot) | `sp` `splt` `subplots` `subplt` |
| [`weights`](@ref seriesattr_weights) | |
| [`x`](@ref seriesattr_x) | `xs` |
| [`xerror`](@ref seriesattr_xerror) | `xerr` `xerrorbar` `xerrors` |
| [`y`](@ref seriesattr_y) | `ys` |
| [`yerror`](@ref seriesattr_yerror) | `err` `errorbar` `yerr` `yerrorbar` `yerrors` |
| [`z`](@ref seriesattr_z) | `zs` |
| [`z_order`](@ref seriesattr_z_order) | `z_orders` `zorders` |
| [`zerror`](@ref seriesattr_zerror) | `zerr` `zerrorbar` `zerrors` |

## Documentation

### [arrow](@id seriesattr_arrow)
```julia
arrow :: Union{Bool, Plots.Arrow}
```
**Aliases:** `arrows`

Defines arrowheads that should be displayed at the end of path line segments (just before a NaN and the last non-NaN point). Used in quiverplot, streamplot, or similar.

Defaults to `nothing`.

### [bar_edges](@id seriesattr_bar_edges)
```julia
bar_edges :: Bool
```

Align bars to edges with `true`, or centers with `false`.

Defaults to `false`.

### [bar_position](@id seriesattr_bar_position)
```julia
bar_position :: Symbol
```
**Aliases:** `bar_positions` `barpositions`

Choose from `:overlay` or `:stack`. (Warning: may only be partially implemented)

Defaults to `:overlay`.

### [bar_width](@id seriesattr_bar_width)
```julia
bar_width :: Real
```
**Aliases:** `bar_widths` `barwidths`

Width of bars in data coordinates. When `nothing`, chooses based on `x` (or `y` when `orientation = :h`).

### [bins](@id seriesattr_bins)
```julia
bins :: Union{Integer, Symbol, Tuple{Integer, Integer}, AbstractVector}
```
**Aliases:** `bin` `nb` `nbin` `nbins`

Defines the number of bins. 

Defaults to `:auto`, the Freedman-Diaconis rule.

Can take in one of the following types:
* `Integer` – defines the approximate number of bins to aim for. Not guaranteed to give the exact value.
    * `bins=10` gives a 1D histogram with about 10 bins.
    * `bins=10` gives  a 2D histogram with about 10 bins for each dimension.
* `Tuple{Integer, Integer}` – for two-dimensional histograms, defines the approximate number of bins per dimension. Not guaranteed to give the exact values.
    * `bins=(10, 20)` gives a 2D histogram with about 10 bins for the `x` dimension and about 20 bins for the `y` dimension.
* `Symbol` – defines the auto-binning algorithm to use.
    * `:sturges` – [Sturges' rule](https://en.wikipedia.org/wiki/Histogram#Sturges'_formula)
    * `:sqrt` – [Square root rule](https://en.wikipedia.org/wiki/Histogram#Square-root_choice)
    * `:rice` – [Rice rule](https://en.wikipedia.org/wiki/Histogram#Rice_rule) 
    * `:scott` – [Scott's normal reference rule](https://en.wikipedia.org/wiki/Histogram#Scott's_normal_reference_rule)
    * `:fd` (default) – [Freedman-Diaconis' rule](https://en.wikipedia.org/wiki/Histogram#Freedman%E2%80%93Diaconis'_choice)
* `AbstractVector` – defines a vector of values for bin edges.
    * `bins=range(-10, 10, length=21)` gives a histogram with bins starting from -10, ending at 10, and containing 21 break values, giving 20 bins.

Relevant attribute for the following series types:
* [`histogram`](https://docs.juliaplots.org/stable/api/#Plots.histogram-Tuple)
* [`histogram2d`](https://docs.juliaplots.org/stable/api/#Plots.histogram2d-Tuple)

### [colorbar_entry](@id seriesattr_colorbar_entry)
```julia
colorbar_entry :: Bool
```
**Aliases:** `colorbar_entrys` `colorbarentrys`

Include this series in the color bar?  Set to `false` to exclude.

Defaults to `true`.

### [connections](@id seriesattr_connections)
```julia
connections :: Any
```

Defaults to `nothing`.

### [contour_labels](@id seriesattr_contour_labels)
```julia
contour_labels :: Bool
```
**Aliases:** `clabels` `clabs` `contourlabels`

Show labels at the contour lines?

Defaults to `false`.

### [contours](@id seriesattr_contours)
```julia
contours :: Bool
```

Add contours to the side-grids of 3D plots?  Used in surface/wireframe.

Defaults to `false`.

### [extra_kwargs](@id seriesattr_extra_kwargs)
```julia
extra_kwargs :: Symbol
```

Specify for which element extra keyword args are collected or a KW (`Dict{Symbol, Any}`) to pass a map of extra keyword args which may be specific to a backend. Choose from (`:plot`, `:subplot`, `:series`), defaults to `:series`. Example: `pgfplotsx(); scatter(1:5, extra_kwargs=Dict(:subplot=>Dict("axis line shift" => "10pt"))`.

Defaults to `Dict{Any, Any}()`.

### [fill_z](@id seriesattr_fill_z)
```julia
fill_z :: AbstractMatrix
```
**Aliases:** `fill_zs` `fillz` `fillzs` `fz` `sc` `surfacecolor` `surfacecolour` `surfcolor` `surfcolour`

Matrix of the same size as z matrix, which specifies the color of the 3D surface.

Defaults to `nothing`.

### [fillalpha](@id seriesattr_fillalpha)
```julia
fillalpha :: Real
```
**Aliases:** `fa` `falpha` `fillalphas` `fillopacity` `fopacity` `fα`

The alpha/opacity override for the fill area. `nothing` means it will take the alpha value of fillcolor.

Defaults to `nothing`.

### [fillcolor](@id seriesattr_fillcolor)
```julia
fillcolor :: Union{Integer, Symbol, ColorSchemes.ColorScheme, Colorant}
```
**Aliases:** `fc` `fcolor` `fcolour` `fillcolors` `fillcolour`

Color of the filled area of path or bar types. `:match` will take the value from `:seriescolor`.

Defaults to `:match`.

### [fillrange](@id seriesattr_fillrange)
```julia
fillrange :: Union{Real, AbstractVector}
```
**Aliases:** `fill_between` `fillbetween` `fillranges` `fillrng` `fillto` `frange`

Fills area between fillrange and `y` for line-types, sets the base for `bar`, `sticks` types, and similar for other types.

Defaults to `nothing`.

### [fillstyle](@id seriesattr_fillstyle)
```julia
fillstyle :: Symbol
```
**Aliases:** `fillstyles`

Style of the fill area. `nothing` means solid fill. Choose from `:/`, `:\\`, `:|`, `:-`, `:+`, `:x`.

Defaults to `nothing`.

### [group](@id seriesattr_group)
```julia
group :: AbstractVector
```
**Aliases:** `g` `grouping` `groups`

Data is split into a separate series, one for each unique value in `group`.

Defaults to `nothing`.

### [hover](@id seriesattr_hover)
```julia
hover :: AbstractVector{AbstractString}
```
**Aliases:** `hovers`

Text to display when hovering over each data point.

Defaults to `nothing`.

### [label](@id seriesattr_label)
```julia
label :: AbstractString
```
**Aliases:** `lab` `labels`

The label for a series, which appears in a legend. If empty, no legend entry is added.

Defaults to `:auto`.

### [levels](@id seriesattr_levels)
```julia
levels :: Union{Integer, AbstractVector}
```
**Aliases:** `levs` `nlev` `nlevels`

Singleton for number of contours or iterable for contour values. Determines contour levels for a contour type.

Defaults to `15`.

### [line_z](@id seriesattr_line_z)
```julia
line_z :: Union{Function, AbstractVector}
```
**Aliases:** `line_zs` `linez` `linezs` `lz` `zline`

z-values for each series line segment, which correspond to the color to be used from a linecolor gradient. Note that for N points, only the first N-1 values are used (one per line-segment).

Defaults to `nothing`.

### [linealpha](@id seriesattr_linealpha)
```julia
linealpha :: Real
```
**Aliases:** `la` `lalpha` `linealphas` `lineopacity` `lopacity` `lα`

The alpha/opacity override for the line. `nothing` means it will take the alpha value of linecolor.

Defaults to `nothing`.

### [linecolor](@id seriesattr_linecolor)
```julia
linecolor :: Union{Integer, Symbol, ColorSchemes.ColorScheme, Colorant}
```
**Aliases:** `lc` `lcolor` `lcolour` `linecolors` `linecolour`

Color of the line (for path and bar stroke). `:match` will take the value from `:seriescolor`, (though histogram/bar types use `:black` as a default).

Defaults to `:auto`.

### [linestyle](@id seriesattr_linestyle)
```julia
linestyle :: Symbol
```
**Aliases:** `linestyles` `ls` `s` `style`

Style of the line (for path and bar stroke). 

Defaults to `:solid`.

Choose from the following:
* `:auto` `:solid` `:dash` `:dot` `:dashdot` `:dashdotdot`

### [linewidth](@id seriesattr_linewidth)
```julia
linewidth :: Real
```
**Aliases:** `linewidths` `lw` `w` `width`

Width of the line (in pixels).

Defaults to `:auto`.

### [marker_z](@id seriesattr_marker_z)
```julia
marker_z :: Union{Function, AbstractVector}
```
**Aliases:** `marker_zs` `markerz` `markerzs` `mz` `zcolor`

z-values for each series data point, which correspond to the color to be used from a markercolor gradient (`f(x,y,z) -> z_value` or `f(x,y) -> z_value`).

Defaults to `nothing`.

### [markeralpha](@id seriesattr_markeralpha)
```julia
markeralpha :: Real
```
**Aliases:** `ma` `malpha` `markeralphas` `markeropacity` `mopacity` `mα`

The alpha/opacity override for the marker interior. `nothing` means it will take the alpha value of markercolor.

Defaults to `nothing`.

### [markercolor](@id seriesattr_markercolor)
```julia
markercolor :: Union{Integer, Symbol, ColorSchemes.ColorScheme, Colorant}
```
**Aliases:** `markercolors` `markercolour` `mc` `mcolor` `mcolour`

Color of the interior of the marker or shape. `:match` will take the value from `:seriescolor`.

Defaults to `:match`.

### [markershape](@id seriesattr_markershape)
```julia
markershape :: Union{Symbol, AbstractVector, Shape}
```
**Aliases:** `markershapes` `shape`	

Defaults to `:none`.

Choose from the following:
* `:none` `:auto` `:cross` `:xcross` `:vline` `:hline` `:+` `:x`
* `:circle` `:rect` `:diamond`  
* `:utriangle` `:dtriangle` `:rtriangle` `:ltriangle`
* `:star4` `:star5` `:star6` `:star7` `:star8`
* `:pentagon` `:hexagon` `:heptagon` `:octagon`

### [markersize](@id seriesattr_markersize)
```julia
markersize :: Union{Real, AbstractVector}
```
**Aliases:** `markersizes` `ms` `msize`

Size (radius pixels) of the markers.

Defaults to `4`.

### [markerstrokealpha](@id seriesattr_markerstrokealpha)
```julia
markerstrokealpha :: Real
```
**Aliases:** `markerstrokealphas` `markerstrokeopacity` `msa` `msalpha` `msopacity` `msα`

The alpha/opacity override for the marker stroke (border). `nothing` means it will take the alpha value of `markerstrokecolor`.

Defaults to `nothing`.

### [markerstrokecolor](@id seriesattr_markerstrokecolor)
```julia
markerstrokecolor :: Union{Integer, Symbol, ColorSchemes.ColorScheme, Colorant}
```
**Aliases:** `markerstrokecolors` `markerstrokecolour` `msc` `mscolor` `mscolour`

Color of the marker stroke (border). `:match` will take the value from `:foreground_color_subplot`.

Defaults to `:match`.

### [markerstrokestyle](@id seriesattr_markerstrokestyle)
```julia
markerstrokestyle :: Symbol
```
**Aliases:** `markerstrokestyles`

Style of the marker stroke (border).

Defaults to `:solid`.

Choose from the following:
* `:auto` `:solid` `:dash` `:dot` `:dashdot` `:dashdotdot`

### [markerstrokewidth](@id seriesattr_markerstrokewidth)
```julia
markerstrokewidth :: Real
```
**Aliases:** `markerstrokewidths` `msw` `mswidth`

Width of the marker stroke (border) in pixels.

Defaults to `1`.

### [match_dimensions](@id seriesattr_match_dimensions)
```julia
match_dimensions :: Bool
```

For heatmap types: should the first dimension of a matrix (rows) correspond to the first dimension of the plot (x-axis)? 

Defaults to `false` (which matches the behavior of matplotlib, Plotly, and others).

Note: when passing a function for `z`, the function should still map `(x,y) -> z`.

### [normalize](@id seriesattr_normalize)
```julia
normalize :: Union{Bool, Symbol}
```
**Aliases:** `norm` `normalized` `normalizes` `normed`

Normalizes the histogram.

Defaults to `false`.

Can take in one of the following types:
* `Symbol` – defines the normalization scheme.
    * `:none` – no normalization
    * `:pdf` – normalize to a discrete PDF, where the total area of the bins is 1
    * `:density` – the area of each bin, rather than the height, is equal to the counts (useful for uneven bin sizes)
* `Bool` – defines the normalization scheme.
    * `false` (default) – same as `:none`
    * `true` – same as `:pdf`

### [orientation](@id seriesattr_orientation)
```julia
orientation :: Symbol
```
**Aliases:** `dir` `direction` `orientations`

(deprecated) Horizontal or vertical orientation for bar types. Values `:h`, `:hor`, `:horizontal` correspond to horizontal (sideways, anchored to y-axis), and `:v`, `:vert`, and `:vertical` correspond to vertical.

Defaults to `:vertical`.

### [permute](@id seriesattr_permute)
```julia
permute :: Tuple{Symbol, Symbol}
```
**Aliases:** `permutes`

Permutes data and axis properties of the axes given in the tuple, e.g. `(:x, :y)`.

Defaults to `:none`.

### [primary](@id seriesattr_primary)
```julia
primary :: Bool
```
**Aliases:** `primarys`

Does this count as a "real series?" For example, you could have a path (primary) and a scatter (secondary) as two separate series, maybe with different data (see `sticks` recipe for an example). The secondary series will get the same color, etc. as the primary.

Defaults to `true`.

### [quiver](@id seriesattr_quiver)
```julia
quiver :: Union{Tuple{AbstractVector, AbstractVector}, AbstractVector}
```
**Aliases:** `gradient` `quiver2d` `quivers` `vectorfield` `velocity`

The directional vectors `(U, V)` which specify velocity/gradient vectors for a quiver plot.

Defaults to `nothing`.

### [ribbon](@id seriesattr_ribbon)
```julia
ribbon :: Union{Real, AbstractVector}
```
**Aliases:** `rib` `ribbons`

Creates a fillrange around the data points.

Defaults to `nothing`.

### [series_annotations](@id seriesattr_series_annotations)
```julia
series_annotations :: Union{AbstractString, Plots.PlotText, AbstractVector}
```
**Aliases:** `series_ann` `series_annotation` `series_anns` `seriesann` `seriesannotation` `seriesanns` `text` `texts` `txt` `txts`

Annotations which are mapped to data points/positions.

Defaults to `nothing`.

### [seriesalpha](@id seriesattr_seriesalpha)
```julia
seriesalpha :: Real
```
**Aliases:** `alpha` `opacity` `seriesalphas` `α`

The alpha/opacity override for the series. `nothing` means it will take the alpha value of the color.

Defaults to `nothing`.

### [seriescolor](@id seriesattr_seriescolor)
```julia
seriescolor :: Union{Integer, Symbol, ColorSchemes.ColorScheme, Colorant}
```
**Aliases:** `c` `cmap` `color` `colormap` `colour` `seriescolors`

The base color for this series. `:auto` will select a color from the subplot's `color_palette`, based on the order it was added to the subplot. Also describes the colormap for surfaces.

Defaults to `:auto`.

### [seriestype](@id seriesattr_seriestype)
```julia
seriestype :: Symbol
```
**Aliases:** `linetype` `lt` `seriestypes` `st` `t` `typ`

Identifier of the type of visualization for this series. 

Defaults to `:path`.

Choose from any series recipes which are defined, or the following:
* `:none` `:line` `:path` `:steppre` `:stepmid` `:steppost` `:sticks` `:scatter` `:heatmap` `:hexbin` `:barbins` `:barhist` `:histogram` `:scatterbins` `:scatterhist` `:stepbins` `:stephist` `:bins2d` `:histogram2d` `:histogram3d` `:density` `:bar` `:hline` `:vline` `:contour` `:pie` `:shape` `:image` `:path3d` `:scatter3d` `:surface` `:wireframe` `:contour3d` `:volume` `:mesh3d`

### [show_empty_bins](@id seriesattr_show_empty_bins)
```julia
show_empty_bins :: Bool
```
**Aliases:** `show_empty` `showempty` `showemptybins`

Whether empty bins in a 2D histogram are colored as 0  with `true`, or transparent with `false`.

Defaults to `false`.

### [smooth](@id seriesattr_smooth)
```julia
smooth :: Bool
```
**Aliases:** `reg` `regression` `smooths`

Add a regression line?

Defaults to `false`.

### [stride](@id seriesattr_stride)
```julia
stride :: Any
```
**Aliases:** `str` `strides` `surf_str` `surface_stride` `surfacestride` `surfstr` `wirefame_stride` `wirefamestride`

Defaults to `(1, 1)`.

### [subplot](@id seriesattr_subplot)
```julia
subplot :: Union{Integer, Plots.Subplot}
```
**Aliases:** `sp` `splt` `subplots` `subplt`

The subplot that this series belongs to.

Defaults to `:auto`.

### [weights](@id seriesattr_weights)
```julia
weights :: AbstractVector
```

Used in histogram types for weighted counts.

Defaults to `nothing`.

### [x](@id seriesattr_x)
```julia
x :: Any
```
**Aliases:** `xs`

Input data (first dimension).

Defaults to `nothing`.

### [xerror](@id seriesattr_xerror)
```julia
xerror :: Union{Tuple{AbstractVector, AbstractVector}, AbstractVector}
```
**Aliases:** `xerr` `xerrorbar` `xerrors`

`x` (horizontal) error relative to x-value. If 2-tuple of vectors, the first vector corresponds to the left error (and the second to the right).

Defaults to `nothing`.

### [y](@id seriesattr_y)
```julia
y :: Any
```
**Aliases:** `ys`

Input data (second dimension).

Defaults to `nothing`.

### [yerror](@id seriesattr_yerror)
```julia
yerror :: Union{Tuple{AbstractVector, AbstractVector}, AbstractVector}
```
**Aliases:** `err` `errorbar` `yerr` `yerrorbar` `yerrors` 

`y` (vertical) error relative to y-value. If 2-tuple of vectors, the first vector corresponds to the bottom error (and the second to the top).

Defaults to `nothing`.

### [z](@id seriesattr_z)
```julia
z :: Any
```
**Aliases:** `zs`

Input data (third dimension). May be wrapped by a `Surface` for surface and heatmap types.

Defaults to `nothing`.

### [z_order](@id seriesattr_z_order)
```julia
z_order :: Union{Integer, Symbol}
```
**Aliases:** `z_orders` `zorders`

`:front`, `:back`, or index of position where 1 is furthest in the background.

Defaults to `:front`.

### [zerror](@id seriesattr_zerror)
```julia
zerror :: Any
```
**Aliases:** `zerr` `zerrorbar` `zerrors`

Defaults to `nothing`.
