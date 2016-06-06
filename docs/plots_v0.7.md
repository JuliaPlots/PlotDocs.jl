
## Plots - New and improved

Just as Gregor Clegane went from [powerful man](http://vignette1.wikia.nocookie.net/gameofthrones/images/b/be/Gregor_Clegane_4x07.jpg/revision/latest?cb=20140707234843) to [unstoppable monster](http://i.imgur.com/qp10sp6.png), Plots is making a transition to a more modular, more powerful, and more customizable visualization platform.

There are two major shifts (recipes and layouts) and many more smaller changes.  Internally, things look very different, but I've made serious effort to keep things backward-compatible, when appropriate.  Note: You'll probably need a recent version of Plots to follow along.  Do:

```julia
Pkg.add("Plots")
Pkg.checkout("Plots", "dev")
```

---

# Recipes

Sparked by a brief comment by @Evizero (Christof Stocker) during a discussion on a Plots issue, the importance of recipes for the future of plotting in Julia became immediately apparent.  I went to work right away to build [RecipesBase](https://github.com/JuliaPlots/RecipesBase.jl), a super lightweight but powerful package which allows users to create intricate plotting logic external to Plots.  The `@recipe` macro in RecipesBase will add a method definition for `RecipesBase.apply_recipe`.  Plots adds to and calls this same function, and so your package and Plots can communicate without ever knowing about the other.  Magic!

Visualizing custom user types has always been a confusing problem.  Should a package developer add a dependency on a plotting package (forcing the significant baggage that comes with that dependency)? Should they attempt conditional dependencies?  Should they submit a PR to graphics packages to define their custom visualizations?  It seems that every option had many cons for each pro, and the decision was tough.  With recipes, these issues go away.  One tiny package (RecipesBase) gives simple hooks into the visualization pipeline, allowing users and package developers to focus solely on the specifics of their visualization.  Pick the shapes/lines/colors that will represent your data well, decide on custom defaults, and convert the inputs (if you need to).  Everything else is handled by Plots.

### Visualizing User Types

Examples are always best.  Lets explore the implementation of [creating visualization recipes for Distributions](https://github.com/tbreloff/ExamplePlots.jl/tree/master/notebooks/usertype_recipes.ipynb).

### Recipes of Recipes

Lets quickly discuss a mainstay of data visualization: the histogram.  Hadley Wickham has explored the nature of histograms as part of his [Layered Grammar of Graphics](http://vita.had.co.nz/papers/layered-grammar.pdf).  In it, he discusses how a histogram is really nothing more than a bar graph which has its data pre-binned.  This is true, and it can be taken further.  A bar-graph is really an extension of a step-graph, in which zeros are interwoven among the x-values.  A step-graph is really nothing more than a path (line) which can travel only horizontally or vertically.  Of course, a similar decomposition could be had by treating the bars as filled polygons.

The point to be had is that a graphics package need only be able to draw lines and polygons, and they can support drawing a histogram.  The path from data to histogram is normally very complicated, but we can avoid the complexity and define a recipe to convert it to an existing recipe.  In a few lines of readable code, we've implemented a key statistical visualization.  See the [tutorial on series recipes](https://github.com/tbreloff/ExamplePlots.jl/tree/master/notebooks/series_recipes.ipynb) for a better understanding of how you might use them.

---

# Layouts

TODO
