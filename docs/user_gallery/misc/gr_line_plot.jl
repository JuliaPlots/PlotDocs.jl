# ---
# title: Line plot
# author: Johnny Chen
# cover: assets/gr_line_plot.png
# date: 2022-03-21
# ---

using Plots

# This example shows how to use Plots to draw a line
plot(1:10)

mkpath("assets") #src
png("assets/gr_line_plot.png") #src
