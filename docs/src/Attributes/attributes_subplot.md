
# Subplot Attributes

These attributes apply to settings for individual Subplots. These include attributes related to annotations, colorbars, legends, margins, and titles, as well as a few others.

## Contents

| Attribute | Aliases |
| :--- | :--- |
| [`annotationcolor`](@ref subplotattr_annotationcolor) | `annotationcolors` |
| [`annotationfontfamily`](@ref subplotattr_annotationfontfamily) | `annotationfontfamilys` |
| [`annotationfontsize`](@ref subplotattr_annotationfontsize) | `annotationfontsizes` |
| [`annotationhalign`](@ref subplotattr_annotationhalign) | `annotationhaligns` |
| [`annotationrotation`](@ref subplotattr_annotationrotation) | `annotationrotations` |
| [`annotations`](@ref subplotattr_annotations) | `ann` `annotate` `annotation` `anns` |
| [`annotationvalign`](@ref subplotattr_annotationvalign) | `annotationvaligns` |
| [`aspect_ratio`](@ref subplotattr_aspect_ratio) | `aspect_ratios` `aspectratio` `aspectratios` `axis_ratio` `axisratio` `ratio` |
| [`background_color_inside`](@ref subplotattr_background_color_inside) | `background_color_insides` `background_colour_inside` `background_inside` `backgroundcolorinsides` `backgroundcolourinside` `backgroundinside` `bg_color_inside` `bg_colour_inside` `bg_inside` `bgcolor_inside` `bgcolorinside` `bgcolour_inside` `bgcolourinside` `bginside` |
| [`background_color_subplot`](@ref subplotattr_background_color_subplot) | `background_color_subplots` `background_colour_subplot` `background_subplot` `backgroundcolorsubplots` `backgroundcoloursubplot` `backgroundsubplot` `bg_color_subplot` `bg_colour_subplot` `bg_subplot` `bgcolor_subplot` `bgcolorsubplot` `bgcolour_subplot` `bgcoloursubplot` `bgsubplot` |
| [`bottom_margin`](@ref subplotattr_bottom_margin) | `bottom_margins` `bottommargin` `bottommargins` |
| [`camera`](@ref subplotattr_camera) | `cam` `cameras` `view_angle` `viewangle` |
| [`clims`](@ref subplotattr_clims) | `cbar_lims` `cbarlims` `clim` `climits` `color_limits` `colorlimits` |
| [`color_palette`](@ref subplotattr_color_palette) | `color_palettes` `colorpalettes` `palette` |
| [`colorbar`](@ref subplotattr_colorbar) | `cb` `cbar` `colorbars` `colorkey` |
| [`colorbar_continuous_values`](@ref subplotattr_colorbar_continuous_values) | |
| [`colorbar_discrete_values`](@ref subplotattr_colorbar_discrete_values) | |
| [`colorbar_fontfamily`](@ref subplotattr_colorbar_fontfamily) | `colorbar_fontfamilys` `colorbarfontfamilys` |
| [`colorbar_formatter`](@ref subplotattr_colorbar_formatter) | `colorbar_formatters` `colorbarformatters` |
| [`colorbar_scale`](@ref subplotattr_colorbar_scale) | `colorbar_scales` `colorbarscales` |
| [`colorbar_tickfontcolor`](@ref subplotattr_colorbar_tickfontcolor) | `colorbar_tickfontcolors` `colorbartickfontcolors` |
| [`colorbar_tickfontfamily`](@ref subplotattr_colorbar_tickfontfamily) | `colorbar_tickfontfamilys` `colorbartickfontfamilys` |
| [`colorbar_tickfonthalign`](@ref subplotattr_colorbar_tickfonthalign) | `colorbar_tickfonthaligns` `colorbartickfonthaligns` |
| [`colorbar_tickfontrotation`](@ref subplotattr_colorbar_tickfontrotation) | `colorbar_tickfontrotations` `colorbartickfontrotations` |
| [`colorbar_tickfontsize`](@ref subplotattr_colorbar_tickfontsize) | `colorbar_tickfontsizes` `colorbartickfontsizes` |
| [`colorbar_tickfontvalign`](@ref subplotattr_colorbar_tickfontvalign) | `colorbar_tickfontvaligns` `colorbartickfontvaligns` |
| [`colorbar_ticks`](@ref subplotattr_colorbar_ticks) | |
| [`colorbar_title`](@ref subplotattr_colorbar_title) | `cb_title` `cbar_title` `cbartitle` `cbtitle` `colorbar_titles` `colorbartitle` `colorbartitles` `colorkey_title` `colorkeytitle` |
| [`colorbar_title_location`](@ref subplotattr_colorbar_title_location) | `colorbar_title_locations` `colorbartitlelocations` |
| [`colorbar_titlefontcolor`](@ref subplotattr_colorbar_titlefontcolor) | `colorbar_titlefontcolors` `colorbartitlefontcolors` |
| [`colorbar_titlefontfamily`](@ref subplotattr_colorbar_titlefontfamily) | `colorbar_titlefontfamilys` `colorbartitlefontfamilys` |
| [`colorbar_titlefonthalign`](@ref subplotattr_colorbar_titlefonthalign) | `colorbar_titlefonthaligns` `colorbartitlefonthaligns` |
| [`colorbar_titlefontrotation`](@ref subplotattr_colorbar_titlefontrotation) | `colorbar_titlefontrotations` `colorbartitlefontrotations` |
| [`colorbar_titlefontsize`](@ref subplotattr_colorbar_titlefontsize) | `colorbar_titlefontsizes` `colorbartitlefontsizes` |
| [`colorbar_titlefontvalign`](@ref subplotattr_colorbar_titlefontvalign) | `colorbar_titlefontvaligns` `colorbartitlefontvaligns` |
| [`extra_kwargs`](@ref subplotattr_extra_kwargs) | |
| [`fontfamily_subplot`](@ref subplotattr_fontfamily_subplot) | `fontfamily_subplots` `fontfamilysubplots` |
| [`foreground_color_subplot`](@ref subplotattr_foreground_color_subplot) | `fg_color_subplot` `fg_colour_subplot` `fg_subplot` `fgcolor_subplot` `fgcolorsubplot` `fgcolour_subplot` `fgcoloursubplot` `fgsubplot` `foreground_color_subplots` `foreground_colour_subplot` `foreground_subplot` `foregroundcolorsubplots` `foregroundcoloursubplot` `foregroundsubplot` |
| [`foreground_color_title`](@ref subplotattr_foreground_color_title) | `fg_color_title` `fg_colour_title` `fg_title` `fgcolor_title` `fgcolortitle` `fgcolour_title` `fgcolourtitle` `fgtitle` `foreground_color_titles` `foreground_colour_title` `foreground_title` `foregroundcolortitles` `foregroundcolourtitle` `foregroundtitle` `titlecolor` |
| [`framestyle`](@ref subplotattr_framestyle) | `axes_style` `axesstyle` `border` `border_style` `borderstyle` `box` `box_style` `boxstyle` `frame` `frame_style` `framestyle` `framestyles` |
| [`left_margin`](@ref subplotattr_left_margin) | `left_margins` `leftmargin` `leftmargins` |
| [`legend_background_color`](@ref subplotattr_legend_background_color) | `background_color_legend` `background_colour_legend` `background_legend` `backgroundcolorlegend` `backgroundcolourlegend` `backgroundlegend` `bg_color_legend` `bg_colour_legend` `bg_legend` `bgcolor_legend` `bgcolorlegend` `bgcolour_legend` `bgcolourlegend` `bglegend` `legend_background_colors` `legendbackgroundcolor` `legendbackgroundcolors` |
| [`legend_column`](@ref subplotattr_legend_column) | `legend_columns` `legendcolumn` `legendcolumns` |
| [`legend_font`](@ref subplotattr_legend_font) | `legend_fonts` `legendfont` `legendfonts` |
| [`legend_font_color`](@ref subplotattr_legend_font_color) | `legend_font_colors` `legendfontcolor` `legendfontcolors` |
| [`legend_font_family`](@ref subplotattr_legend_font_family) | `legend_font_familys` `legendfontfamily` `legendfontfamilys` |
| [`legend_font_halign`](@ref subplotattr_legend_font_halign) | `legend_font_haligns` `legendfonthalign` `legendfonthaligns` |
| [`legend_font_pointsize`](@ref subplotattr_legend_font_pointsize) | `legend_font_pointsizes` `legendfontpointsize` `legendfontpointsizes` `legendfontsize` |
| [`legend_font_rotation`](@ref subplotattr_legend_font_rotation) | `legend_font_rotations` `legendfontrotation` `legendfontrotations` |
| [`legend_font_valign`](@ref subplotattr_legend_font_valign) | `legend_font_valigns` `legendfontvalign` `legendfontvaligns` |
| [`legend_foreground_color`](@ref subplotattr_legend_foreground_color) | `fg_color_legend` `fg_colour_legend` `fg_legend` `fgcolor_legend` `fgcolorlegend` `fgcolour_legend` `fgcolourlegend` `fglegend` `foreground_color_legend` `foreground_colour_legend` `foreground_legend` `foregroundcolorlegend` `foregroundcolourlegend` `foregroundlegend` `legend_foreground_colors` `legendforegroundcolor` `legendforegroundcolors` |
| [`legend_position`](@ref subplotattr_legend_position) | `key` `leg` `legend` `legend_positions` `legendposition` `legendpositions` `legends` |
| [`legend_title`](@ref subplotattr_legend_title) | `key_title` `keytitle` `label_title` `labeltitle` `leg_title` `legend_titles` `legendtitle` `legendtitles` `legtitle` |
| [`legend_title_font`](@ref subplotattr_legend_title_font) | `legend_title_fonts` `legendtitlefont` `legendtitlefonts` |
| [`legend_title_font_color`](@ref subplotattr_legend_title_font_color) | `legend_title_font_colors` `legendtitlefontcolor` `legendtitlefontcolors` |
| [`legend_title_font_family`](@ref subplotattr_legend_title_font_family) | `legend_title_font_familys` `legendtitlefontfamily` `legendtitlefontfamilys` |
| [`legend_title_font_halign`](@ref subplotattr_legend_title_font_halign) | `legend_title_font_haligns` `legendtitlefonthalign` `legendtitlefonthaligns` |
| [`legend_title_font_pointsize`](@ref subplotattr_legend_title_font_pointsize) | `legend_title_font_pointsizes` `legendtitlefontpointsize` `legendtitlefontpointsizes` `legendtitlefontsize` |
| [`legend_title_font_rotation`](@ref subplotattr_legend_title_font_rotation) | `legend_title_font_rotations` `legendtitlefontrotation` `legendtitlefontrotations` |
| [`legend_title_font_valign`](@ref subplotattr_legend_title_font_valign) | `legend_title_font_valigns` `legendtitlefontvalign` `legendtitlefontvaligns` |
| [`margin`](@ref subplotattr_margin) | `margins` |
| [`projection`](@ref subplotattr_projection) | `proj` `projections` |
| [`projection_type`](@ref subplotattr_projection_type) | `proj_type` `projection_types` `projectiontypes` `projtype` |
| [`right_margin`](@ref subplotattr_right_margin) | `right_margins` `rightmargin` `rightmargins` |
| [`subplot_index`](@ref subplotattr_subplot_index) | `subplot_indexs` `subplotindexs` |
| [`title`](@ref subplotattr_title) | `titles` |
| [`titlefontcolor`](@ref subplotattr_titlefontcolor) | `titlefontcolors` |
| [`titlefontfamily`](@ref subplotattr_titlefontfamily) | `titlefontfamilys` |
| [`titlefonthalign`](@ref subplotattr_titlefonthalign) | `titlefonthaligns` |
| [`titlefontrotation`](@ref subplotattr_titlefontrotation) | `titlefontrotations` |
| [`titlefontsize`](@ref subplotattr_titlefontsize) | `titlefontsizes` |
| [`titlefontvalign`](@ref subplotattr_titlefontvalign) | `titlefontvaligns` |
| [`titlelocation`](@ref subplotattr_titlelocation) | `title_align` `title_alignment` `title_loc` `title_location` `title_pos` `title_position` `titlealign` `titlealignment` `titleloc` `titlelocation` `titlelocations` `titlepos` `titleposition` |
| [`top_margin`](@ref subplotattr_top_margin) | `top_margins` `topmargin` `topmargins` |

## Annotation Attributes

### [annotationcolor](@id subplotattr_annotationcolor)
```julia
annotationcolor :: Union{Integer, Symbol, ColorSchemes.ColorScheme, Colorant}
```
**Aliases:** `annotationcolors`

Annotations color.

Defaults to `:match`.

### [annotationfontfamily](@id subplotattr_annotationfontfamily)
```julia
annotationfontfamily :: Union{AbstractString, Symbol}
```
**Aliases:** `annotationfontfamilys`

Font family of annotations.

Defaults to `:match`.

### [annotationfontsize](@id subplotattr_annotationfontsize)
```julia
annotationfontsize :: Integer
```
**Aliases:** `annotationfontsizes`

Font pointsize of annotations.

Defaults to `14`.

### [annotationhalign](@id subplotattr_annotationhalign)
```julia
annotationhalign :: Symbol
```
**Aliases:** `annotationhaligns`

horizontal alignment of annotations.

Defaults to `:hcenter`.

Choose from the following:
* `:hcenter` `:left` `:right` `:center`

### [annotationrotation](@id subplotattr_annotationrotation)
```julia
annotationrotation :: Real
```
**Aliases:** `annotationrotations`

Rotation of annotations in degrees.

Defaults to `0.0`.

### [annotations](@id subplotattr_annotations)
```julia
annotations :: Union{Tuple{Real, Real, Union{AbstractString, Tuple, Plots.PlotText}}, AbstractVector{Tuple}}
```
**Aliases:** `ann` `annotate` `annotation` `anns`

`(x, y, text)` tuple(s), where text can be `String`, `PlotText` (created with `text(args...)`), or a tuple of arguments to `text` (e.g. `("Label", 8, :red, :top)`). Add one-off text annotations at the (x, y) coordinates.

Defaults to `Any[]`.

### [annotationvalign](@id subplotattr_annotationvalign)
```julia
annotationvalign :: Symbol
```
**Aliases:** `annotationvaligns`

Vertical alignment of annotations.

Defaults to `:vcenter`.

Choose from the following:
* `:vcenter` `:top` `:bottom` `:center`

## Colorbar Attributes

### [clims](@id subplotattr_clims)
```julia
clims :: Union{Function, Symbol, Tuple{Real, Real}}
```
**Aliases:** `cbar_lims` `cbarlims` `clim` `climits` `color_limits` `colorlimits`

Fixes the limits of the colorbar: values, `:auto`, or a function taking series data in and returning an `NTuple{2, Real}`.

Defaults to `:auto`.

### [colorbar](@id subplotattr_colorbar)
```julia
colorbar :: Union{Bool, Symbol}
```
**Aliases:** `cbar_lims` `cbarlims` `clim` `climits` `color_limits` `colorlimits`

Show the colorbar. A symbol specifies a colorbar position. 

Defaults to `:legend`.

Choose from the following (note: only some may be supported in each backend):
* `:none` 
* `:best` 
* `:right` `:left` `:top` `:bottom` 
* `:legend` – matches legend value

### [colorbar_continuous_values](@id subplotattr_colorbar_continuous_values)
```julia
colorbar_continuous_values :: Any
```

Defaults to `Float64[]`.

### [colorbar_discrete_values](@id subplotattr_colorbar_discrete_values)
```julia
colorbar_discrete_values :: Any
```

Defaults to `Any[]`.

### [colorbar_fontfamily](@id subplotattr_colorbar_fontfamily)
```julia
colorbar_fontfamily :: Union{AbstractString, Symbol}
```
**Aliases:** `colorbar_fontfamilys` `colorbarfontfamilys`

Font family of colobar entries.

Defaults to `:match`.

### [colorbar_formatter](@id subplotattr_colorbar_formatter)
```julia
colorbar_formatter :: Union{Function, Symbol}
```
**Aliases:** `colorbar_fontfamilys` `colorbarfontfamilys`

Choose from `:scientific`, `:plain`, `:none`, `:auto`, or a method which converts a number to a string for tick labeling.

Defaults to `:auto`.

### [colorbar_scale](@id subplotattr_colorbar_scale)
```julia
colorbar_scale :: Symbol
```
**Aliases:** `colorbar_scales` `colorbarscales`

Scale of the colorbar axis.

Defaults to `:identity`.

Choose from the following:
* `:identity`
* `:ln` `:log2` `:log10`
* `:asinh`
* `:sqrt`

### [colorbar_tickfontcolor](@id subplotattr_colorbar_tickfontcolor)
```julia
colorbar_tickfontcolor :: Union{Integer, Symbol, ColorSchemes.ColorScheme, Colorant}
```
**Aliases:** `colorbar_tickfontcolors` `colorbartickfontcolors`

Font color of colorbar tick entries.

Defaults to `:match`.

### [colorbar_tickfontfamily](@id subplotattr_colorbar_tickfontfamily)
```julia
colorbar_tickfontfamily :: Union{AbstractString, Symbol}
```
**Aliases:** `colorbar_tickfontfamilys` `colorbartickfontfamilys`

Font family of colorbar tick labels.

Defaults to `:match`.

### [colorbar_tickfonthalign](@id subplotattr_colorbar_tickfonthalign)
```julia
colorbar_tickfonthalign :: Any
```
**Aliases:** `colorbar_tickfonthaligns` `colorbartickfonthaligns`

Defaults to `:hcenter`.

### [colorbar_tickfontrotation](@id subplotattr_colorbar_tickfontrotation)
```julia
colorbar_tickfontrotation :: Any
```
**Aliases:** `colorbar_tickfontrotations` `colorbartickfontrotations`

Defaults to `0.0`.

### [colorbar_tickfontsize](@id subplotattr_colorbar_tickfontsize)
```julia
colorbar_tickfontsize :: Integer
```
**Aliases:** `colorbar_tickfontsizes` `colorbartickfontsizes`

Font pointsize of colorbar tick entries.

Defaults to `8`.

### [colorbar_tickfontvalign](@id subplotattr_colorbar_tickfontvalign)
```julia
colorbar_tickfontvalign :: Any
```
**Aliases:** `colorbar_tickfontvaligns` `colorbartickfontvaligns`

Defaults to `:vcenter`.

### [colorbar_ticks](@id subplotattr_colorbar_ticks)
```julia
colorbar_ticks :: Union{Symbol, Tuple{AbstractVector{Real}, AbstractVector{AbstractString}}, AbstractVector{Real}}
```

Tick values, `(tickvalues, ticklabels)`, or `:auto`.

Defaults to `:auto`.

### [colorbar_title](@id subplotattr_colorbar_title)
```julia
colorbar_title :: AbstractString
```
**Aliases:** `cb_title` `cbar_title` `cbartitle` `cbtitle` `colorbar_titles` `colorbartitle` `colorbartitles` `colorkey_title` `colorkeytitle`

Title of colorbar.

Defaults to `""` (empty string).

### [colorbar_title_location](@id subplotattr_colorbar_title_location)
```julia
colorbar_title_location :: Any
```
**Aliases:** `colorbar_title_locations` `colorbartitlelocations`

Defaults to `:center`.

### [colorbar_titlefontcolor](@id subplotattr_colorbar_titlefontcolor)
```julia
colorbar_titlefontcolor :: Any
```
**Aliases:** `colorbar_titlefontcolors` `colorbartitlefontcolors`

Defaults to `:match`.

### [colorbar_titlefontfamily](@id subplotattr_colorbar_titlefontfamily)
```julia
colorbar_titlefontfamily :: Any
```
**Aliases:** `colorbar_titlefontfamilys` `colorbartitlefontfamilys`

Defaults to `:match`.

### [colorbar_titlefonthalign](@id subplotattr_colorbar_titlefonthalign)
```julia
colorbar_titlefonthalign :: Any
```
**Aliases:** `colorbar_titlefonthaligns` `colorbartitlefonthaligns`

Defaults to `:hcenter`.

### [colorbar_titlefontrotation](@id subplotattr_colorbar_titlefontrotation)
```julia
colorbar_titlefontrotation :: Any
```
**Aliases:** `colorbar_titlefontrotations` `colorbartitlefontrotations`

Defaults to `0.0`.

### [colorbar_titlefontsize](@id subplotattr_colorbar_titlefontsize)
```julia
colorbar_titlefontsize :: Any
```
**Aliases:** `colorbar_titlefontsizes` `colorbartitlefontsizes`

Defaults to `10`.

### [colorbar_titlefontvalign](@id subplotattr_colorbar_titlefontvalign)
```julia
colorbar_titlefontvalign :: Any
```
**Aliases:** `colorbar_titlefontvaligns` `colorbartitlefontvaligns`

Defaults to `:vcenter`.

## Legend Attributes

### [legend_background_color](@id subplotattr_legend_background_color)
```julia
legend_background_color :: Union{Integer, Symbol, ColorSchemes.ColorScheme, Colorant}
```
**Aliases:** `background_color_legend` `background_colour_legend` `background_legend` `backgroundcolorlegend` `backgroundcolourlegend` `backgroundlegend` `bg_color_legend` `bg_colour_legend` `bg_legend` `bgcolor_legend` `bgcolorlegend` `bgcolour_legend` `bgcolourlegend` `bglegend` `legend_background_colors` `legendbackgroundcolor` `legendbackgroundcolors`

Background color of the legend. `:match` matches :background_color_subplot`.

Defaults to `:match`.

### [legend_column](@id subplotattr_legend_column)
```julia
legend_column :: Integer
```
**Aliases:** `legend_columns` `legendcolumn` `legendcolumns`

Number of columns in the legend. `-1` stands for maximum number of columns (horizontal legend).

Defaults to `1`.

### [legend_font](@id subplotattr_legend_font)
```julia
legend_font :: Plots.Font
```
**Aliases:** `legend_fonts` `legendfont` `legendfonts`

Font of legend items.

Defaults to `Plots.Font("sans-serif", 8, :hcenter, :vcenter, 0.0, RGB{N0f8}(0.0,0.0,0.0))`.

### [legend_font_color](@id subplotattr_legend_font_color)
```julia
legend_font_color :: Any
```
**Aliases:** `legend_font_colors` `legendfontcolor` `legendfontcolors`

Defaults to `:match`.

### [legend_font_family](@id subplotattr_legend_font_family)
```julia
legend_font_family :: Union{AbstractString, Symbol}
```
**Aliases:** `legend_font_familys` `legendfontfamily` `legendfontfamilys`

Font family of legend entries.

Defaults to `:match`.

### [legend_font_halign](@id subplotattr_legend_font_halign)
```julia
legend_font_halign :: Symbol
```
**Aliases:** `legend_font_haligns` `legendfonthalign` `legendfonthaligns`

Font horizontal alignment of legend entries.

Defaults to `:hcenter`.

Choose from the following:
* `:hcenter` `:left` `:right` `:center`

### [legend_font_pointsize](@id subplotattr_legend_font_pointsize)
```julia
legend_font_pointsize :: Integer
```
**Aliases:** `legend_font_pointsizes` `legendfontpointsize` `legendfontpointsizes` `legendfontsize`

Font pointsize of legend entries.

Defaults to `8`.

### [legend_font_rotation](@id subplotattr_legend_font_rotation)
```julia
legend_font_rotation :: Real
```
**Aliases:** `legend_font_rotations` `legendfontrotation` `legendfontrotations`

Font rotation of legend entries.

Defaults to `0.0`.

### [legend_font_valign](@id subplotattr_legend_font_valign)
```julia
legend_font_valign :: Symbol
```
**Aliases:** `legend_font_valigns` `legendfontvalign` `legendfontvaligns`

Font vertical alignment of legend entries.

Defaults to `:vcenter`.

Choose from the following:
* `:vcenter` `:top` `:bottom` `:center`

### [legend_foreground_color](@id subplotattr_legend_foreground_color)
```julia
legend_foreground_color :: Union{Integer, Symbol, ColorSchemes.ColorScheme, Colorant}
```
**Aliases:** `fg_color_legend` `fg_colour_legend` `fg_legend` `fgcolor_legend` `fgcolorlegend` `fgcolour_legend` `fgcolourlegend` `fglegend` `foreground_color_legend` `foreground_colour_legend` `foreground_legend` `foregroundcolorlegend` `foregroundcolourlegend` `foregroundlegend` `legend_foreground_colors` `legendforegroundcolor` `legendforegroundcolors`

Foreground color of the legend. `:match` matches :foreground_color_subplot`.

Defaults to `:match`.

### [legend_position](@id subplotattr_legend_position)
```julia
legend_position :: Union{Bool, Symbol, Tuple{Real, Real}}
```
**Aliases:** `key` `leg` `legend` `legend_positions` `legendposition` `legendpositions` `legends`

Show the legend. Can also be an `(x, y)` tuple or `Symbol` (legend position) or angle `(angle, inout)` tuple. Bottom left corner of legend is placed at `(x, y)`. Choose from (`:none`, `:best`, `:inline`, `:inside`, `:legend`) or any valid combination of `:(outer ?)(top/bottom ?)(right/left ?)`, i.e.: `:top`, `:topright`, `:outerleft`, `:outerbottomright` ... (note: only some may be supported in each backend)

Defaults to `:best`.

### [legend_title](@id subplotattr_legend_title)
```julia
legend_title :: AbstractString
```
**Aliases:** `key_title` `keytitle` `label_title` `labeltitle` `leg_title` `legend_titles` `legendtitle` `legendtitles` `legtitle`

Legend title.

Defaults to `nothing`.

### [legend_title_font](@id subplotattr_legend_title_font)
```julia
legend_title_font :: Plots.Font
```
**Aliases:** `legend_title_fonts` `legendtitlefont` `legendtitlefonts`

Font of the legend title.

Defaults to `Plots.Font("sans-serif", 11, :hcenter, :vcenter, 0.0, RGB{N0f8}(0.0,0.0,0.0))`.

### [legend_title_font_color](@id subplotattr_legend_title_font_color)
```julia
legend_title_font_color :: Union{Integer, Symbol, ColorSchemes.ColorScheme, Colorant}
```
**Aliases:** `legend_title_font_colors` `legendtitlefontcolor` `legendtitlefontcolors`

Font color of the legend title.

Defaults to `:match`.

### [legend_title_font_family](@id subplotattr_legend_title_font_family)
```julia
legend_title_font_family :: Union{AbstractString, Symbol}
```
**Aliases:** `legend_title_font_familys` `legendtitlefontfamily` `legendtitlefontfamilys`

Font family of the legend title.

Defaults to `:match`.

### [legend_title_font_halign](@id subplotattr_legend_title_font_halign)
```julia
legend_title_font_halign :: Symbol
```
**Aliases:** `legend_title_font_haligns` `legendtitlefonthalign` `legendtitlefonthaligns`

Font horizontal alignment of the legend title. 

Defaults to `:hcenter`.

Choose from the following:
* `:hcenter` `:left` `:right` `:center`

### [legend_title_font_pointsize](@id subplotattr_legend_title_font_pointsize)
```julia
legend_title_font_pointsize :: Integer
```
**Aliases:** `legend_title_font_pointsizes` `legendtitlefontpointsize` `legendtitlefontpointsizes` `legendtitlefontsize`

Font pointsize of the legend title.

Defaults to `11`.

### [legend_title_font_rotation](@id subplotattr_legend_title_font_rotation)
```julia
legend_title_font_rotation :: Real
```
**Aliases:** `legend_title_font_rotations` `legendtitlefontrotation` `legendtitlefontrotations`

Font rotation of the legend title.

Defaults to `0.0`.

### [legend_title_font_valign](@id subplotattr_legend_title_font_valign)
```julia
legend_title_font_valign :: Symbol
```
**Aliases:** `legend_title_font_valigns` `legendtitlefontvalign` `legendtitlefontvaligns`

Font vertical alignment of the legend title.

Defaults to `:vcenter`.

Choose from the following:
* `:vcenter` `:top` `:bottom` `:center`

## Margin Attributes

### [bottom_margin](@id subplotattr_bottom_margin)
```julia
bottom_margin :: Union{Real, Symbol, Tuple}
```
**Aliases:** `bottom_margins` `bottommargin` `bottommargins`

Specifies the extra padding on the bottom of the subplot. `:match` matches `:margin`.

Defaults to `:match`.

### [left_margin](@id subplotattr_left_margin)
```julia
left_margin :: Union{Real, Symbol, Tuple}
```
**Aliases:** `left_margins` `leftmargin` `leftmargins`

Specifies the extra padding on the left of the subplot. `:match` matches `:margin`.

Defaults to `:match`.

### [margin](@id subplotattr_margin)
```julia
margin :: Union{Real, Tuple}
```
**Aliases:** `margins`

Number multiplied by `mm`, `px`, etc... or `Tuple` `(0, :mm)`. Base for individual margins (not directly used). Specifies the extra padding around subplots.

Defaults to `1.0mm`.

### [right_margin](@id subplotattr_right_margin)
```julia
right_margin :: Union{Real, Symbol, Tuple}
```
**Aliases:** `right_margins` `rightmargin` `rightmargins`

Specifies the extra padding on the right of the subplot. `:match` matches `:margin`.

Defaults to `:match`.

### [top_margin](@id subplotattr_top_margin)
```julia
top_margin :: Union{Real, Symbol, Tuple}
```
**Aliases:** `top_margins` `topmargin` `topmargins`

Specifies the extra padding on the top of the subplot. `:match` matches `:margin`.

Defaults to `:match`.

## Title Attributes

### [title](@id subplotattr_title)
```julia
title :: AbstractString
```
**Aliases:** `titles`

Subplot title.

Defaults to `""` (empty string).

### [titlefontcolor](@id subplotattr_titlefontcolor)
```julia
titlefontcolor :: Union{Integer, Symbol, ColorSchemes.ColorScheme, Colorant}
```
**Aliases:** `titlefontcolors`

Font color of subplot title.

Defaults to `:match`.

### [titlefontfamily](@id subplotattr_titlefontfamily)
```julia
titlefontfamily :: Union{AbstractString, Symbol}
```
**Aliases:** `titlefontfamilys`

Font family of subplot title.

Defaults to `:match`.

### [titlefonthalign](@id subplotattr_titlefonthalign)
```julia
titlefonthalign :: Symbol
```
**Aliases:** `titlefonthaligns`

Font horizontal alignment of subplot title.

Defaults to `:hcenter`.

Choose from the following:
* `:hcenter` `:left` `:right` `:center`

### [titlefontrotation](@id subplotattr_titlefontrotation)
```julia
titlefontrotation :: Real
```
**Aliases:** `titlefontrotations`

Font rotation of subplot title.

Defaults to `0.0`.

### [titlefontsize](@id subplotattr_titlefontsize)
```julia
titlefontsize :: Integer
```
**Aliases:** `titlefontrotations`

Font pointsize of subplot title.

Defaults to `14`.

### [titlefontvalign](@id subplotattr_titlefontvalign)
```julia
titlefontvalign :: Symbol
```
**Aliases:** `titlefontvaligns`

Font vertical alignment of subplot title.

Defaults to `:vcenter`.

Choose from the following:
* `:vcenter` `:top` `:bottom` `:center`

### [titlelocation](@id subplotattr_titlelocation)
```julia
titlelocation :: Symbol
```
**Aliases:** `title_align` `title_alignment` `title_loc` `title_location` `title_pos` `title_position` `titlealign` `titlealignment` `titleloc` `titlelocation` `titlelocations` `titlepos` `titleposition`

Position of subplot title.

Defaults to `:center`.

Choose from the following:
* `:left` `:center` `:right`

## 3D-Specific Attributes

### [camera](@id subplotattr_camera)
```julia
camera :: Tuple{Real, Real}
```
**Aliases:** `cam` `cameras` `view_angle` `viewangle`

Sets the view angle `(azimuthal, elevation)` for 3D plots.

Defaults to `(30, 30)`.

### [projection](@id subplotattr_projection)
```julia
projection :: Union{AbstractString, Symbol}
```
**Aliases:** `proj` `projections`

`3d` or `polar`.

Defaults to `:none`.

### [projection_type](@id subplotattr_projection_type)
```julia
projection_type :: Symbol
```
**Aliases:** `proj_type` `projection_types` `projectiontypes` `projtype`

3d plots projection type: :auto (backend dependent), :persp(ective), :ortho(graphic).

Defaults to `:auto`.

## Other Subplot Attributes

### [aspect_ratio](@id subplotattr_aspect_ratio)
```julia
aspect_ratio :: Union{Real, Symbol}
```
**Aliases:** `aspect_ratios` `aspectratio` `aspectratios` `axis_ratio` `axisratio` `ratio`

Plot area is resized so that 1 y-unit is the same size as `aspect_ratio` x-units. With `:none`, images inherit aspect ratio of the plot area. Use `:equal` for unit aspect ratio.

Defaults to `:auto`.

### [background_color_inside](@id subplotattr_background_color_inside)
```julia
background_color_inside :: Union{Integer, Symbol, ColorSchemes.ColorScheme, Colorant}
```
**Aliases:** `background_color_insides` `background_colour_inside` `background_inside` `backgroundcolorinsides` `backgroundcolourinside` `backgroundinside` `bg_color_inside` `bg_colour_inside` `bg_inside` `bgcolor_inside` `bgcolorinside` `bgcolour_inside` `bgcolourinside` `bginside`

Background color inside the plot area (under the grid).`:match` matches :background_color_subplot`.

Defaults to `:match`.

### [background_color_subplot](@id subplotattr_background_color_subplot)
```julia
background_color_subplot :: Union{Integer, Symbol, ColorSchemes.ColorScheme, Colorant}
```
**Aliases:** `background_color_subplots` `background_colour_subplot` `background_subplot` `backgroundcolorsubplots` `backgroundcoloursubplot` `backgroundsubplot` `bg_color_subplot` `bg_colour_subplot` `bg_subplot` `bgcolor_subplot` `bgcolorsubplot` `bgcolour_subplot` `bgcoloursubplot` `bgsubplot`

Base background color of the subplot.`:match` matches `:background_color`.

Defaults to `:match`.

### [color_palette](@id subplotattr_color_palette)
```julia
color_palette :: Union{Symbol, AbstractVector{Union{Integer, Symbol, ColorSchemes.ColorScheme, Colorant}}}
```
**Aliases:** `color_palettes` `colorpalettes` `palette`

Iterable (cycle through) or color gradient (generate list from gradient) or `:auto` (generate a color list using `Colors.distiguishable_colors` and custom seed colors chosen to contrast with the background). The color palette is a color list from which series colors are automatically chosen.

Defaults to `:auto`.

### [extra_kwargs](@id subplotattr_extra_kwargs)
```julia
extra_kwargs :: Symbol
```

Specify for which element extra keyword args are collected or a KW (`Dict{Symbol, Any}`) to pass a map of extra keyword args which may be specific to a backend. Choose from `:plot`, `:subplot`, `:series`, defaults to `:series`. Example: `pgfplotsx(); scatter(1:5, extra_kwargs=Dict(:subplot=>Dict("axis line shift" => "10pt"))`.

Defaults to `Dict{Any, Any}()`.

### [fontfamily_subplot](@id subplotattr_fontfamily_subplot)
```julia
fontfamily_subplot :: Any
```
**Aliases:** `fontfamily_subplots` `fontfamilysubplots`

Defaults to `:match`.

### [foreground_color_subplot](@id subplotattr_foreground_color_subplot)
```julia
foreground_color_subplot :: Union{Integer, Symbol, ColorSchemes.ColorScheme, Colorant}
```
**Aliases:** `fg_color_subplot` `fg_colour_subplot` `fg_subplot` `fgcolor_subplot` `fgcolorsubplot` `fgcolour_subplot` `fgcoloursubplot` `fgsubplot` `foreground_color_subplots` `foreground_colour_subplot` `foreground_subplot` `foregroundcolorsubplots` `foregroundcoloursubplot` `foregroundsubplot`

Base foreground color of the subplot. `:match` matches :foreground_color`.

Defaults to `:match`.

### [foreground_color_title](@id subplotattr_foreground_color_title)
```julia
foreground_color_title :: Union{Integer, Symbol, ColorSchemes.ColorScheme, Colorant}
```
**Aliases:** `fg_color_title` `fg_colour_title` `fg_title` `fgcolor_title` `fgcolortitle` `fgcolour_title` `fgcolourtitle` `fgtitle` `foreground_color_titles` `foreground_colour_title` `foreground_title` `foregroundcolortitles` `foregroundcolourtitle` `foregroundtitle` `titlecolor`

Color of subplot title. `:match` matches :foreground_color_subplot`.

Defaults to `:match`.

### [framestyle](@id subplotattr_framestyle)
```julia
framestyle :: Symbol
```
**Aliases:** `axes_style` `axesstyle` `border` `border_style` `borderstyle` `box` `box_style` `boxstyle` `frame` `frame_style` `framestyle` `framestyles`

Style of the axes frame.

Defaults to `:axes`.

Choose from the following:
* `:box` `:semi` `:axes` `:origin` `:zerolines` `:grid` `:none`

### [subplot_index](@id subplotattr_subplot_index)
```julia
subplot_index :: Integer
```
**Aliases:** `subplot_indexs` `subplotindexs`

Internal (not set by user). Specifies the index of this subplot in the Plot's `plt.subplot` list.

Defaults to `-1`.
