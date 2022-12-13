
# Series Attributes

Series attributes apply to individual series, such as lines, scatters, heatmaps, etc.

:label              => (AStr, "The label for a series, which appears in a legend. If empty, no legend entry is added."),
:seriescolor        => (ColorType, "The base color for this series. `:auto` (the default) will select a color from the subplot's `color_palette`, based on the order it was added to the subplot. Also describes the colormap for surfaces."),
:seriesalpha        => (Real, "The alpha/opacity override for the series. `nothing` (the default) means it will take the alpha value of the color."),
:seriestype         => (Symbol, "This is the identifier of the type of visualization for this series. Choose from $(_allTypes) or any series recipes which are defined."),
:linestyle          => (Symbol, "Style of the line (for path and bar stroke). Choose from $(_allStyles)"),
:linewidth          => (Real, "Width of the line (in pixels)."),
:linecolor          => (ColorType, "Color of the line (for path and bar stroke). `:match` will take the value from `:seriescolor`, (though histogram/bar types use `:black` as a default)."),
:linealpha          => (Real, "The alpha/opacity override for the line. `nothing` (the default) means it will take the alpha value of linecolor."),
:fillrange          => (Union{Real,AVec}, "Fills area between fillrange and `y` for line-types, sets the base for `bar`, `sticks` types, and similar for other types."),
:fillcolor          => (ColorType, "Color of the filled area of path or bar types. `:match` will take the value from `:seriescolor`."),
:fillalpha          => (Real, "The alpha/opacity override for the fill area. `nothing` (the default) means it will take the alpha value of fillcolor."),
:markershape        => (Union{Symbol,Shape,AVec}, "Choose from $(_allMarkers)."),
:fillstyle          => (Symbol, "Style of the fill area. `nothing` (the default) means solid fill. Choose from :/, :\\, :|, :-, :+, :x."),
:markercolor        => (ColorType, "Color of the interior of the marker or shape. `:match` will take the value from `:seriescolor`."),
:markeralpha        => (Real, "The alpha/opacity override for the marker interior. `nothing` (the default) means it will take the alpha value of markercolor."),
:markersize         => (Union{Real,AVec}, "Size (radius pixels) of the markers."),
:markerstrokestyle  => (Symbol, "Style of the marker stroke (border). Choose from $(_allStyles)."),
:markerstrokewidth  => (Real, "Width of the marker stroke (border) in pixels."),
:markerstrokecolor  => (ColorType, "Color of the marker stroke (border). `:match` will take the value from `:foreground_color_subplot`."),
:markerstrokealpha  => (Real, "The alpha/opacity override for the marker stroke (border). `nothing` (the default) means it will take the alpha value of markerstrokecolor."),
:bins               => (Union{Integer,NTuple{2,Integer},AVec,Symbol}, """
                    Default is :auto (the Freedman-Diaconis rule). For histogram-types, defines the approximate number of bins to aim for, or the auto-binning algorithm to use (:sturges, :sqrt, :rice, :scott or :fd).
                    For fine-grained control pass a Vector of break values, e.g. `range(minimum(x), stop = maximum(x), length = 25)`."""),
:smooth             => (Bool, "Add a regression line ?"),
:group              => (AVec, "Data is split into a separate series, one for each unique value in `group`."),
:x                  => (Any, "Input data (first dimension)."),
:y                  => (Any, "Input data (second dimension)."),
:z                  => (Any, "Input data (third dimension). May be wrapped by a `Surface` for surface and heatmap types."),
:marker_z           => (Union{AVec,Function}, "z-values for each series data point, which correspond to the color to be used from a markercolor gradient (`f(x,y,z) -> z_value` or `f(x,y) -> z_value`)."),
:line_z             => (Union{AVec,Function}, "z-values for each series line segment, which correspond to the color to be used from a linecolor gradient. Note that for N points, only the first N-1 values are used (one per line-segment)."),
:fill_z             => (AMat, "Matrix of the same size as z matrix, which specifies the color of the 3D surface."),
:levels             => (Union{AVec,Integer}, "Singleton for number of contours or iterable for contour values. Determines contour levels for a contour type."),
:permute            => (NTuple{2,Symbol}, "Permutes data and axis properties of the axes given in the tuple, e.g. (:x, :y)."),
:orientation        => (Symbol, "(deprecated) Horizontal or vertical orientation for bar types. Values `:h`, `:hor`, `:horizontal` correspond to horizontal (sideways, anchored to y-axis), and `:v`, `:vert`, and `:vertical` correspond to vertical (the default)."),
:xerror             => (Union{AVec,NTuple{2,AVec}}, "`x` (horizontal) error relative to x-value. If 2-tuple of vectors, the first vector corresponds to the left error (and the second to the right)."),
:yerror             => (Union{AVec,NTuple{2,AVec}}, "`y` (vertical) error relative to y-value. If 2-tuple of vectors, the first vector corresponds to the bottom error (and the second to the top)."),
:ribbon             => (Union{Real,AVec}, "Creates a fillrange around the data points."),
:quiver             => (Union{AVec,NTuple{2,AVec}}, "The directional vectors U,V which specify velocity/gradient vectors for a quiver plot."),
:normalize          => (Union{Bool,Symbol}, "Histogram normalization mode. Possible values are: false/:none (no normalization, default), true/:pdf (normalize to a discrete PDF, where the total area of the bins is 1), :probability (bin heights sum to 1) and :density (the area of each bin, rather than the height, is equal to the counts - useful for uneven bin sizes)."),
:weights            => (AVec, "Used in histogram types for weighted counts."),
:show_empty_bins    => (Bool, "Whether empty bins in a 2D histogram are colored as 0 (true), or transparent (the default)."),
:contours           => (Bool, "Add contours to the side-grids of 3D plots?  Used in surface/wireframe."),
:contour_labels     => (Bool, "Show labels at the contour lines ?"),
:match_dimensions   => (Bool, "For heatmap types: should the first dimension of a matrix (rows) correspond to the first dimension of the plot (`x`-axis) ? Defaults to `false`, which matches the behavior of Matplotlib, Plotly, and others. Note: when passing a function for `z`, the function should still map `(x,y) -> z`."),
:subplot            => (Union{Integer,Subplot}, "The subplot that this series belongs to."),
:series_annotations => (Union{AVec,AStr,PlotText}, "These are annotations which are mapped to data points/positions."),
:primary            => (Bool, "Does this count as a 'real series'? For example, you could have a path (primary), and a scatter (secondary) as two separate series, maybe with different data (see `sticks` recipe for an example). The secondary series will get the same color, etc as the primary."),
:hover              => (AVec{AStr}, "Text to display when hovering over each data point."),
:colorbar_entry     => (Bool, "Include this series in the color bar?  Set to `false` to exclude."),
:z_order            => (Union{Symbol,Integer}, ":front (default), :back or index of position where 1 is farest in the background."),

### arrow
```julia
arrow :: Union{Bool, Plots.Arrow}
```
Defines arrowheads that should be displayed at the end of path line segments (just before a NaN and the last non-NaN point). Used in quiverplot, streamplot, or similar.

Alias `:arrows`.

Defaults to `nothing`.

### bar_edges
```julia
bar_edges :: Bool
```
Align bars to edges with `true`, or centers with `false`.

Defaults to `false`.

### bar_position
```julia
bar_position :: Symbol
```
Choose from `:overlay` (default) or `:stack`. (Warning: may only be partially implemented)

Aliases `bar_positions`, `barpositions`.


### bar_width
    :bar_width          => (Real, " Width of bars in data coordinates. When `nothing`, chooses based on `x` (or `y` when `orientation = :h`)."),

### bins
```julia
bins :: Union{Integer, Symbol, Tuple{Integer, Integer}, AbstractVector}
```
Defines the number of bins. 

Aliases `:bin`, `:nb`, `:nbin`, `:nbins`. 

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

### colorbar_entry


### connections


### contour_labels


### contours


### extra_kwargs


### fill_z


### fillalpha


### fillcolor


### fillrange


### fillstyle


### group


### hover


### label


### levels


### line_z


### linealpha


### linecolor


### linestyle


### linewidth


### marker_z


### markeralpha


### markercolor


### markershape


### markersize


### markerstrokealpha


### markerstrokestyle


### markerstrokewidth


### normalize


### orientation


### permute


### primary


### quiver


### ribbon


### series_annotations


### seriesalpha


### seriescolor


### seriestype


### show_empty_bins


### smooth


### stride


### subplot


### weights


### x


### xerror


### y


### yerror


### z


### z_order


### zerror




