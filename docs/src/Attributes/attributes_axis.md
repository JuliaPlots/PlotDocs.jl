
# Axis Attributes

These attributes apply by default to all Axes in a Subplot (for example, the `subplot[:xaxis]`).

For all attributes on this page, you can specify the x, y, or z-axis for each of these attributes by prefixing the attribute name with x, y, or z. For example, `xmirror` only sets the mirror attribute for the x-axis.

## Contents

| Attribute | Aliases |
| :--- | :--- |
| [`discrete_values`](@ref axisattr_discrete_values) | |
| [`draw_arrow`](@ref axisattr_draw_arrow) | |
| [`flip`](@ref axisattr_flip) | |
| [`foreground_color_axis`](@ref axisattr_foreground_color_axis) | `axiscolor` `fg_axis` `fg_color_axis` `fg_colour_axis` `fgaxis` `fgcolor_axis` `fgcoloraxis` `fgcolour_axis` `fgcolouraxis` `foreground_axis` `foreground_colour_axis` `foregroundaxis` `foregroundcolouraxis` |
| [`foreground_color_border`](@ref axisattr_foreground_color_border) | `bordercolor` `fg_border` `fg_color_border` `fg_colour_border` `fgborder` `fgcolor_border` `fgcolorborder` `fgcolour_border` `fgcolourborder` `foreground_border` `foreground_colour_border` `foregroundborder` `foregroundcolourborder` |
| [`foreground_color_grid`](@ref axisattr_foreground_color_grid) | `fg_color_grid` `fg_colour_grid` `fg_grid` `fgcolor_grid` `fgcolorgrid` `fgcolour_grid` `fgcolourgrid` `fggrid` `foreground_colour_grid` `foreground_grid` `foregroundcolourgrid` `foregroundgrid` `gridcolor` |
| [`foreground_color_guide`](@ref axisattr_foreground_color_guide) | `fg_color_guide` `fg_colour_guide` `fg_guide` `fgcolor_guide` `fgcolorguide` `fgcolour_guide` `fgcolourguide` `fgguide` `foreground_colour_guide` `foreground_guide` `foregroundcolourguide` `foregroundguide` `guidecolor` |
| [`foreground_color_minor_grid`](@ref axisattr_foreground_color_minor_grid) | `fg_color_minorgrid` `fg_colour_minor_grid` `fg_minor_grid` `fgcolor_minorgrid` `fgcolorminorgrid` `fgcolour_minorgrid` `fgcolourminorgrid` `fgminorgrid` `foreground_colour_minor_grid` `foreground_minorgrid` `foregroundcolourminorgrid` `foregroundminorgrid` `minorgridcolor` |
| [`foreground_color_text`](@ref axisattr_foreground_color_text) | `fg_color_text` `fg_colour_text` `fg_text` `fgcolor_text` `fgcolortext` `fgcolour_text` `fgcolourtext` `fgtext` `foreground_colour_text` `foreground_text` `foregroundcolourtext` `foregroundtext` `textcolor` |
| [`formatter`](@ref axisattr_formatter) | |
| [`grid`](@ref axisattr_grid) | |
| [`gridalpha`](@ref axisattr_gridalpha) | `ga` `galpha` `gopacity` `gridopacity` `gα` |
| [`gridlinewidth`](@ref axisattr_gridlinewidth) | `grid_linewidth` `grid_lw` `grid_width` `gridlinewidth` `gridlw` `gridwidth` |
| [`gridstyle`](@ref axisattr_gridstyle) | `grid_linestyle` `grid_ls` `grid_style` `gridlinestyle` `gridls` `gridstyle` |
| [`guide`](@ref axisattr_guide) | |
| [`guide_position`](@ref axisattr_guide_position) | |
| [`guidefontcolor`](@ref axisattr_guidefontcolor) | |
| [`guidefontfamily`](@ref axisattr_guidefontfamily) | |
| [`guidefonthalign`](@ref axisattr_guidefonthalign) | |
| [`guidefontrotation`](@ref axisattr_guidefontrotation) | |
| [`guidefontsize`](@ref axisattr_guidefontsize) | `labelfontsize` |
| [`guidefontvalign`](@ref axisattr_guidefontvalign) | |
| [`lims`](@ref axisattr_lims) | `lim` `limit` `limits` `range` |
| [`link`](@ref axisattr_link) | `links` |
| [`minorgrid`](@ref axisattr_minorgrid) | |
| [`minorgridalpha`](@ref axisattr_minorgridalpha) | |
| [`minorgridlinewidth`](@ref axisattr_minorgridlinewidth) | `minorgrid_linewidth` `minorgrid_lw` `minorgrid_width` `minorgridlinewidth` `minorgridlw` `minorgridwidth` |
| [`minorgridstyle`](@ref axisattr_minorgridstyle) | `minorgrid_linestyle` `minorgrid_ls` `minorgrid_style` `minorgridlinestyle` `minorgridls` `minorgridstyle` |
| [`minorticks`](@ref axisattr_minorticks) | |
| [`mirror`](@ref axisattr_mirror) | |
| [`rotation`](@ref axisattr_rotation) | `r` `rot` |
| [`scale`](@ref axisattr_scale) | |
| [`showaxis`](@ref axisattr_showaxis) | |
| [`tick_direction`](@ref axisattr_tick_direction) | `tick_dir` `tick_or` `tick_orientation` `tickdir` `tickdirection` `tickor` `tickorientation` |
| [`tickfontcolor`](@ref axisattr_tickfontcolor) | |
| [`tickfontfamily`](@ref axisattr_tickfontfamily) | |
| [`tickfonthalign`](@ref axisattr_tickfonthalign) | |
| [`tickfontrotation`](@ref axisattr_tickfontrotation) | |
| [`tickfontsize`](@ref axisattr_tickfontsize) | |
| [`tickfontvalign`](@ref axisattr_tickfontvalign) | |
| [`ticks`](@ref axisattr_ticks) | `tick` |
| [`widen`](@ref axisattr_widen) | |

## Foreground Attributes

### [foreground_color_axis](@id axisattr_foreground_color_axis)
```julia
foreground_color_axis :: Union{Integer, Symbol, ColorSchemes.ColorScheme, Colorant}
```
**Aliases:** `axiscolor` `fg_axis` `fg_color_axis` `fg_colour_axis` `fgaxis` `fgcolor_axis` `fgcoloraxis` `fgcolour_axis` `fgcolouraxis` `foreground_axis` `foreground_colour_axis` `foregroundaxis` `foregroundcolouraxis`

Color of axis ticks. `:match` matches `:foreground_color_subplot`.

Defaults to `:match`.

### [foreground_color_border](@id axisattr_foreground_color_border)
```julia
foreground_color_border :: Union{Integer, Symbol, ColorSchemes.ColorScheme, Colorant}
```
**Aliases:** `bordercolor` `fg_border` `fg_color_border` `fg_colour_border` `fgborder` `fgcolor_border` `fgcolorborder` `fgcolour_border` `fgcolourborder` `foreground_border` `foreground_colour_border` `foregroundborder` `foregroundcolourborder`

Color of plot area border/spines. `:match` matches `:foreground_color_subplot`.

Defaults to `:match`.

### [foreground_color_grid](@id axisattr_foreground_color_grid)
```julia
foreground_color_grid :: Union{Integer, Symbol, ColorSchemes.ColorScheme, Colorant}
```
**Aliases:** `fg_color_grid` `fg_colour_grid` `fg_grid` `fgcolor_grid` `fgcolorgrid` `fgcolour_grid` `fgcolourgrid` `fggrid` `foreground_colour_grid` `foreground_grid` `foregroundcolourgrid` `foregroundgrid` `gridcolor`

Color of grid lines. `:match` matches `:foreground_color_subplot`.

Defaults to `:match`.

### [foreground_color_guide](@id axisattr_foreground_color_guide)
```julia
foreground_color_guide :: Union{Integer, Symbol, ColorSchemes.ColorScheme, Colorant}
```
**Aliases:** `fg_color_guide` `fg_colour_guide` `fg_guide` `fgcolor_guide` `fgcolorguide` `fgcolour_guide` `fgcolourguide` `fgguide` `foreground_colour_guide` `foreground_guide` `foregroundcolourguide` `foregroundguide` `guidecolor`

Color of axis guides/labels. `:match` matches `:foreground_color_subplot`.

Defaults to `:match`.

### [foreground_color_minor_grid](@id axisattr_foreground_color_minor_grid)
```julia
foreground_color_minor_grid :: Union{Integer, Symbol, ColorSchemes.ColorScheme, Colorant}
```
**Aliases:** `fg_color_minorgrid` `fg_colour_minor_grid` `fg_minor_grid` `fgcolor_minorgrid` `fgcolorminorgrid` `fgcolour_minorgrid` `fgcolourminorgrid` `fgminorgrid` `foreground_colour_minor_grid` `foreground_minorgrid` `foregroundcolourminorgrid` `foregroundminorgrid` `minorgridcolor`

Color of minor grid lines. `:match` matches `:foreground_color_subplot`.

Defaults to `:match`.

### [foreground_color_text](@id axisattr_foreground_color_text)
```julia
foreground_color_text :: Union{Integer, Symbol, ColorSchemes.ColorScheme, Colorant}
```
**Aliases:** `fg_color_text` `fg_colour_text` `fg_text` `fgcolor_text` `fgcolortext` `fgcolour_text` `fgcolourtext` `fgtext` `foreground_colour_text` `foreground_text` `foregroundcolourtext` `foregroundtext` `textcolor`

Color of tick labels. `:match` matches `:foreground_color_subplot`.

Defaults to `:match`.

## Grid Attributes

### [grid](@id axisattr_grid)
```julia
grid :: Union{Bool, AbstractString, Symbol}
```

Defines the grid lines.

Defaults to `true`.

Choose from the following:
 * `true` `false` `:show` `:hide` `:yes` `:no` `:x` `:y` `:z` `:xy` ... `:all` `:none` `:off`

### [gridalpha](@id axisattr_gridalpha)
```julia
gridalpha :: Real
```
**Aliases:** `ga` `galpha` `gopacity` `gridopacity` `gα`

The alpha/opacity override for the grid lines.

Defaults to `0.1`.

### [gridlinewidth](@id axisattr_gridlinewidth)
```julia
gridlinewidth :: Real
```
**Aliases:** `grid_linewidth` `grid_lw` `grid_width` `gridlw` `gridwidth`

Width of the grid lines (in pixels).

Defaults to `0.5`.

### [gridstyle](@id axisattr_gridstyle)
```julia
gridstyle :: Symbol
```
**Aliases:** `grid_linestyle` `grid_ls` `grid_style` `gridlinestyle` `gridls`

Style of the grid lines. 

Defaults to `:solid`.

Choose from the following:
* `:auto` `:solid` `:dash` `:dot` `:dashdot` `:dashdotdot`

### [minorgrid](@id axisattr_minorgrid)
```julia
minorgrid :: Bool
```

Adds minor grid lines and ticks to the plot. Set `minorticks` to change number of gridlines.

Defaults to `false`.

### [minorgridalpha](@id axisattr_minorgridalpha)
```julia
minorgridalpha :: Real
```

The alpha/opacity override for the minorgrid lines.

Defaults to `0.05`.

### [minorgridlinewidth](@id axisattr_minorgridlinewidth)
```julia
minorgridlinewidth :: Real
```
**Aliases:** `minorgrid_linewidth` `minorgrid_lw` `minorgrid_width` `minorgridlinewidth` `minorgridlw` `minorgridwidth`

Width of the minor grid lines (in pixels).

Defaults to `0.5`.

### [minorgridstyle](@id axisattr_minorgridstyle)
```julia
minorgridlinewidth :: Symbol
```
**Aliases:** `minorgrid_linestyle` `minorgrid_ls` `minorgrid_style` `minorgridlinestyle` `minorgridls` `minorgridstyle`

Style of the minor grid lines.

Defaults to `:solid`.

Choose from the following:
* `:auto` `:solid` `:dash` `:dot` `:dashdot` `:dashdotdot`

## Guide (Axes Label) Attributes

### [guide](@id axisattr_guide)
```julia
guide :: AbstractString
```

Axis guide (label).

Defaults to `""` (empty string).

### [guide_position](@id axisattr_guide_position)
```julia
guide_position :: Symbol
```

Position of axis guides. 

Defaults to `:auto`. 

Choose from the following:
* `:top` `:bottom` `:left` `:right`

### [guidefontcolor](@id axisattr_guidefontcolor)
```julia
guidefontcolor :: Union{Integer, Symbol, ColorSchemes.ColorScheme, Colorant}
```

Font color of axes guides.

Defaults to `:match`.

### [guidefontfamily](@id axisattr_guidefontfamily)
```julia
guidefontfamily :: Union{AbstractString, Symbol}
```

Font family of axes guides.

Defaults to `:match`.

### [guidefonthalign](@id axisattr_guidefonthalign)
```julia
guidefonthalign :: Symbol
```

Font horizontal alignment of axes guides. 

Defaults to `:hcenter`.

Choose from the following:
* `:hcenter` `:left` `:right` `:center`

### [guidefontrotation](@id axisattr_guidefontrotation)
```julia
guidefontrotation :: Real
```

Font rotation of axes guides.

Defaults to `0.0`.

### [guidefontsize](@id axisattr_guidefontsize)
```julia
guidefontsize :: Integer
```
**Aliases:** `labelfontsize`

Font pointsize of axes guides.

Defaults to `11`.

### [guidefontvalign](@id axisattr_guidefontvalign)
```julia
guidefontvalign :: Symbol
```

Font vertical alignment of axes guides.

Defaults to `:vcenter`.

Choose from the following:
* `:vcenter` `:top` `:bottom` `:center`

## Tick Attributes

### [minorticks](@id axisattr_minorticks)
```julia
minorticks :: Integer
```

Number of minor intervals between major ticks.

Defaults to `:auto`.

### [tick_direction](@id axisattr_tick_direction)
```julia
tick_direction :: Integer
```
**Aliases:** `tick_dir` `tick_or` `tick_orientation` `tickdir` `tickdirection` `tickor` `tickorientation`

Direction of the ticks. 

Defaults to `in`.

Choose from the following:
* `:in` `:out` `:none`

### [tickfontcolor](@id axisattr_tickfontcolor)
```julia
tickfontcolor :: Union{Integer, Symbol, ColorSchemes.ColorScheme, Colorant}
```

Font color of tick labels.

Defaults to `:match`.

### [tickfontfamily](@id axisattr_tickfontfamily)
```julia
tickfontfamily :: Union{AbstractString, Symbol}
```

Font family of tick labels.

Defaults to `:match`.

### [tickfonthalign](@id axisattr_tickfonthalign)
```julia
tickfonthalign :: Symbol
```

Font horizontal alignment of tick labels. 

Defaults to `:hcenter`.

Choose from the following:
* `:hcenter` `:left` `:right` `:center`

### [tickfontrotation](@id axisattr_tickfontrotation)
```julia
tickfontrotation :: Real
```

Font rotation of tick labels.

Defaults to `0.0`.

### [tickfontsize](@id axisattr_tickfontsize)
```julia
tickfontsize :: Integer
```

Font pointsize of tick labels. 

Defaults to `8`.

### [tickfontvalign](@id axisattr_tickfontvalign)
```julia
tickfontvalign :: Symbol
```

Font vertical alignment of tick labels.

Defaults to `:vcenter`.

Choose from the following:
* `:vcenter` `:top` `:bottom` `:center`

### [ticks](@id axisattr_ticks)
```julia
ticks :: Union{Symbol, Tuple{AbstractVector{Real}, AbstractVector{AbstractString}}, AbstractVector{Real}}
```
**Aliases:** `tick`

Tick values `(tickvalues, ticklabels)`, or `:auto`.

Defaults to `:auto`.

## Other Axis Attributes

### [discrete_values](@id axisattr_discrete_values)
```julia
discrete_values :: Any
```

Defaults to `Any[]`.

### [draw_arrow](@id axisattr_draw_arrow)
```julia
draw_arrow :: Bool
```

Draw arrow at the end of the axis.

Defaults to `false`.

### [flip](@id axisattr_flip)
```julia
flip :: Bool
```

Flips (reverses) the axis.

Defaults to `false`.

### [formatter](@id axisattr_formatter)
```julia
formatter :: Union{Function, Symbol}
```

Choose from `:scientific`, `:plain`, `:auto`, or a method which converts a number to a string for tick labeling.

Defaults to `:auto`.

### [lims](@id axisattr_lims)
```julia
lims :: Union{Symbol, Tuple{Real, Real}}
```
**Aliases:** `lim` `limit` `limits` `range`

Force axis limits. Only finite values are used (for example, you can set only the right limit with `xlims = (-Inf, 2)`). `:round` widens the limit to the nearest round number, i.e. `[0.1,3.6]=>[0.0,4.0]`. `:symmetric` sets the limits to be symmetric around zero. Set `widen=true` to widen the specified limits (which occurs when limits are not specified).

Defaults to `:auto`.

### [link](@id axisattr_link)
```julia
link :: Symbol
```
**Aliases:** `links`

How/whether to link axis limits between subplots.

Defaults to `Any[]`.

Choose from the following:
* `:none`
* `:x` – x axes are linked by columns
* `:y` – y axes are linked by rows
* `:both` – x and y are linked
* `:all` – every subplot is linked together regardless of layout position

### [mirror](@id axisattr_mirror)
```julia
mirror :: Bool
```

Switch the side of the tick labels (right or top).

Defaults to `false`.

### [rotation](@id axisattr_rotation)
```julia
rotation :: Real
```
**Aliases:** `r` `rot`

Degrees rotation of tick labels.

Defaults to `0.0`.

### [scale](@id axisattr_scale)
```julia
scale :: Symbol
```

Scale of the axis. 

Defaults to `:identity`.

Choose from the following:
* `:identity` (linear scale)
* `:ln` `:log2` `:log10`
* `:asinh` 
* `:sqrt`

### [showaxis](@id axisattr_showaxis)
```julia
showaxis :: Union{Bool, AbstractString, Symbol}
```

Show the axis.

Defaults to `true`.

Choose from the following:
 * `true` `false` `:show` `:hide` `:yes` `:no` `:x` `:y` `:z` `:xy` ... `:all` `:none` `:off`

### [widen](@id axisattr_widen)
```julia
widen :: Union{Real, Symbol}
```

Widen the axis limits by a small factor to avoid cut-off markers and lines at the borders. If set to `true`, scale the axis limits by the default factor of `Base.RefValue{Float64}(1.06)`. A different factor may be specified by setting `widen` to a number. `:auto` widens by the default factor unless limits were manually set. See also the `scale_limits!` function for scaling axis limits in an existing plot.

Defaults to `:auto`.
