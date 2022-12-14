
# Plot Attributes

A Plot contains a tree-like layout of Subplots. These attributes apply to the full Plot.

## Contents

| Attribute | Aliases |
| :--- | :--- |
| [`background_color`](@ref plotattr_background_color) | `background` `background_colors` `background_colour` `backgroundcolors` `backgroundcolour` `bg` `bg_color` `bg_colour` `bgcolor` `bgcolour` |
| [`background_color_outside`](@ref plotattr_background_color_outside) | `background_color_outsides` `background_colour_outside` `background_outside` `backgroundcoloroutsides` `backgroundcolouroutside` `backgroundoutside` `bg_color_outside` `bg_colour_outside` `bg_outside` `bgcolor_outside` `bgcoloroutside` `bgcolour_outside` `bgcolouroutside` `bgoutside` |
| [`display_type`](@ref plotattr_display_type) | `display_types` `displaytypes` |
| [`dpi`](@ref plotattr_dpi) | `dpis` |
| [`extra_kwargs`](@ref plotattr_extra_kwargs) | |
| [`extra_plot_kwargs`](@ref plotattr_extra_plot_kwargs) | |
| [`fontfamily`](@ref plotattr_fontfamily) | `fontfamilys` |
| [`foreground_color`](@ref plotattr_foreground_color) | `fg` `fg_color` `fg_colour` `fgcolor` `fgcolour` `foreground` `foreground_colors` `foreground_colour` `foregroundcolors` `foregroundcolour` |
| [`html_output_format`](@ref plotattr_html_output_format) | `fmt` `format` `html_format` `html_output_formats` `htmlformat` `htmloutputformats` |
| [`inset_subplots`](@ref plotattr_inset_subplots) | `floating` `inset` |
| [`layout`](@ref plotattr_layout) | `layouts` |
| [`link`](@ref plotattr_link) | `links` |
| [`overwrite_figure`](@ref plotattr_overwrite_figure) | `clearfig` `clf` `overwrite` `overwrite_figures` `overwritefigures` `reuse` |
| [`plot_title`](@ref plotattr_plot_title) | `plot_titles` `plottitles` |
| [`plot_titlefontcolor`](@ref plotattr_plot_titlefontcolor) | `plot_titlefontcolors` `plottitlefontcolors` |
| [`plot_titlefontfamily`](@ref plotattr_plot_titlefontfamily) | `plot_titlefontfamilys` `plottitlefontfamilys` |
| [`plot_titlefonthalign`](@ref plotattr_plot_titlefonthalign) | `plot_titlefonthaligns` `plottitlefonthaligns` |
| [`plot_titlefontrotation`](@ref plotattr_plot_titlefontrotation) | `plot_titlefontrotations` `plottitlefontrotations` |
| [`plot_titlefontsize`](@ref plotattr_plot_titlefontsize) | `plot_titlefontsizes` `plottitlefontsizes` |
| [`plot_titlefontvalign`](@ref plotattr_plot_titlefontvalign) | `plot_titlefontvaligns` `plottitlefontvaligns` |
| [`plot_titleindex`](@ref plotattr_plot_titleindex) | `plot_titleindexs` `plottitleindexs` |
| [`plot_titlelocation`](@ref plotattr_plot_titlelocation) | `plot_titlelocations` `plottitlelocations` |
| [`plot_titlevspan`](@ref plotattr_plot_titlevspan) | `plot_titlevspans` `plottitlevspans` |
| [`pos`](@ref plotattr_pos) | |
| [`show`](@ref plotattr_show) | `display` `gui` `shows` |
| [`size`](@ref plotattr_size) | `sizes` `windowsize` `wsize` |
| [`tex_output_standalone`](@ref plotattr_tex_output_standalone) | `tex_output_standalones` `texoutputstandalones` |
| [`thickness_scaling`](@ref plotattr_thickness_scaling) | `thickness_scalings` `thicknessscalings` |
| [`warn_on_unsupported`](@ref plotattr_warn_on_unsupported) | `warn` `warn_on_unsupporteds` `warnonunsupporteds` |
| [`window_title`](@ref plotattr_window_title) | `window_titles` `windowtitle` `windowtitles` `wtitle` |

## Documentation

### [background_color](@id plotattr_background_color)
```julia
background_color :: Union{Integer, Symbol, ColorSchemes.ColorScheme, Colorant}
```
**Aliases:** `background` `background_colors` `background_colour` `backgroundcolors` `backgroundcolour` `bg` `bg_color` `bg_colour` `bgcolor` `bgcolour`

Base color for all backgrounds.

Defaults to `RGB{N0f8}(1.0, 1.0, 1.0)` (white).

### [background_color_outside](@id plotattr_background_color_outside)
```julia
background_color_outside :: Union{Integer, Symbol, ColorSchemes.ColorScheme, Colorant}
```
**Aliases:** `background_color_outsides` `background_colour_outside` `background_outside` `backgroundcoloroutsides` `backgroundcolouroutside` `backgroundoutside` `bg_color_outside` `bg_colour_outside` `bg_outside` `bgcolor_outside` `bgcoloroutside` `bgcolour_outside` `bgcolouroutside` `bgoutside`

Color outside the plot area(s). `:match` matches `:background_color`.

Defaults to `:match`.

### [display_type](@id plotattr_display_type)
```julia
display_type :: Symbol
```
**Aliases:** `display_types` `displaytypes`

When supported, `display` will either open a GUI window or plot inline. Choose from `:auto`, `:gui`, or `:inline`.

Defaults to `:auto`.

### [dpi](@id plotattr_dpi)
```julia
dpi :: Real
```
**Aliases:** `dpis`

Dots per inch of output figures.

Defaults to `100`.

### [extra_kwargs](@id plotattr_extra_kwargs)
```julia
extra_kwargs :: Symbol
```

Specify for which element extra keyword args are collected or a KW (`Dict{Symbol, Any}`) to pass a map of extra keyword args which may be specific to a backend. Choose from (`:plot`, `:subplot`, `:series`), defaults to `:series`. Example: `pgfplotsx(); scatter(1:5, extra_kwargs=Dict(:subplot=>Dict("axis line shift" => "10pt"))`.

Defaults to `:series`.

### [extra_plot_kwargs](@id plotattr_extra_plot_kwargs)
```julia
extra_plot_kwargs :: Any
```

Defaults to `Dict{Any, Any}()`.

### [fontfamily](@id plotattr_fontfamily)
```julia
fontfamily :: Union{AbstractString, Symbol}
```
**Aliases:** `fontfamilys`

Default font family for title, legend entries, tick labels and guides.

Defaults to `"sans-serif"`.

### [foreground_color](@id plotattr_foreground_color)
```julia
foreground_color :: Union{Integer, Symbol, ColorSchemes.ColorScheme, Colorant}
```
**Aliases:** `fg` `fg_color` `fg_colour` `fgcolor` `fgcolour` `foreground` `foreground_colors` `foreground_colour` `foregroundcolors` `foregroundcolour`

Base color for all foregrounds.

Defaults to `:auto`.

### [html_output_format](@id plotattr_html_output_format)
```julia
html_output_format :: Symbol
```
**Aliases:** `fmt` `format` `html_format` `html_output_formats` `htmlformat` `htmloutputformats`

When writing HTML output, what is the format? `:png` and `:svg` are currently supported.

Defaults to `:auto`.

### [inset_subplots](@id plotattr_inset_subplots)
```julia
inset_subplots :: AbstractVector{Tuple{Any, Any}}
```
**Aliases:** `floating` `inset`

Optionally pass a vector of `(parent, bbox)` tuples which are the parent layout and the relative bounding box of inset subplots.

Defaults to `nothing`.

### [layout](@id plotattr_layout)
```julia
layout :: Union{Integer, Tuple{Integer, Integer}, AbstractLayout}
```
**Aliases:** `layouts`

Number of subplot, grid dimensions, layout (for example `grid(2,2)`), or the return from the `@layout` macro. This builds the layout of subplots.

Defaults to `1`.

### [link](@id plotattr_link)
```julia
link :: Symbol
```
**Aliases:** `links`

How/whether to link axis limits between subplots.

Defaults to `:none`.

Choose from the following:
* `:none`
* `:x` – x axes are linked by columns
* `:y` – y axes are linked by rows
* `:both` – x and y are linked
* `:all` – every subplot is linked together regardless of layout position

### [overwrite_figure](@id plotattr_overwrite_figure)
```julia
overwrite_figure :: Bool
```
**Aliases:** `clearfig` `clf` `overwrite` `overwrite_figures` `overwritefigures` `reuse`

Should we reuse the same GUI window/figure when plotting (true), or open a new one (false)?

Defaults to `true`.

### [plot_title](@id plotattr_plot_title)
```julia
plot_title :: AbstractString
```
**Aliases:** `plot_titles` `plottitles`

Whole plot title (not to be confused with the title for individual subplots).

Defaults to `""` (empty string).

### [plot_titlefontcolor](@id plotattr_plot_titlefontcolor)
```julia
plot_titlefontcolor :: Any
```
**Aliases:** `plot_titlefontcolors` `plottitlefontcolors`

Defaults to `:match`.

### [plot_titlefontfamily](@id plotattr_plot_titlefontfamily)
```julia
plot_titlefontfamily :: Any
```
**Aliases:** `plot_titlefontfamilys` `plottitlefontfamilys`

Defaults to `:match`.

### [plot_titlefonthalign](@id plotattr_plot_titlefonthalign)
```julia
plot_titlefonthalign :: Any
```
**Aliases:** `plot_titlefonthaligns` `plottitlefonthaligns`

Defaults to `:hcenter`.

### [plot_titlefontrotation](@id plotattr_plot_titlefontrotation)
```julia
plot_titlefontrotation :: Any
```
**Aliases:** `plot_titlefontrotations` `plottitlefontrotations`

Defaults to `0.0`.

### [plot_titlefontsize](@id plotattr_plot_titlefontsize)
```julia
plot_titlefontsize :: Any
```
**Aliases:** `plot_titlefontsizes` `plottitlefontsizes`

Defaults to `16`.

### [plot_titlefontvalign](@id plotattr_plot_titlefontvalign)
```julia
plot_titlefontvalign :: Any
```
**Aliases:** `plot_titlefontvaligns` `plottitlefontvaligns`

Defaults to `:vcenter`.

### [plot_titleindex](@id plotattr_plot_titleindex)
```julia
plot_titleindex :: Any
```
**Aliases:** `plot_titleindexs` `plottitleindexs`

Defaults to `0`.

### [plot_titlelocation](@id plotattr_plot_titlelocation)
```julia
plot_titlelocation :: Any
```
**Aliases:** `plot_titlelocations` `plottitlelocations`

Defaults to `:center`.

### [plot_titlevspan](@id plotattr_plot_titlevspan)
```julia
plot_titlevspan :: Real
```
**Aliases:** `plot_titlevspans` `plottitlevspans`

Vertical span of the whole plot title (fraction of the plot height).

Defaults to `0.05`.

### [pos](@id plotattr_pos)
```julia
pos :: Tuple{Integer, Integer}
```

`(left_px, top_px)` position of the GUI window (note: currently unimplemented).

Defaults to `(0, 0)`.

### [show](@id plotattr_show)
```julia
show :: Bool
```
**Aliases:** `display` `gui` `shows`

Should this command open/refresh a GUI/display? Allows to display plots in scripts or functions without explicitly calling `display`.

Defaults to `false`.

### [size](@id plotattr_size)
```julia
size :: Tuple{Integer, Integer}
```
**Aliases:** `sizes` `windowsize` `wsize`

`(width_px, height_px)` of the whole Plot.

Defaults to `(600, 400)`.

### [tex_output_standalone](@id plotattr_tex_output_standalone)
```julia
tex_output_standalone :: Bool
```
**Aliases:** `tex_output_standalones` `texoutputstandalones`

When writing TeX output, should the source include a preamble for a standalone document class?

Defaults to `false`.

### [thickness_scaling](@id plotattr_thickness_scaling)
```julia
thickness_scaling :: Real
```
**Aliases:** `thickness_scalings` `thicknessscalings`

Scale for the thickness of all line elements like lines, borders, axes, grid lines, etc.

Defaults to `1`.

### [warn_on_unsupported](@id plotattr_warn_on_unsupported)
```julia
warn_on_unsupported :: Bool
```
**Aliases:** `warn` `warn_on_unsupporteds` `warnonunsupporteds`

Warn on unsupported attributes, series types, and marker shapes.

Defaults to `true`.

### [window_title](@id plotattr_window_title)
```julia
window_title :: AbstractString
```
**Aliases:** `window_titles` `windowtitle` `windowtitles` `wtitle`

Title of the standalone gui-window.

Defaults to `"Plots.jl"`.
