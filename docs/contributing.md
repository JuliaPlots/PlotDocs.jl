
This is a guide to contributing to Plots and the surrounding ecosystem.  Plots is a complex and far-reaching suite of software components, and as such will be most effective when the community contributes their own expertise, knowledge, perspective, and effort.  The document is roughly broken up into the following categories, and after reading this introduction you should feel comfortable skipping to the section(s) that interest you the most:

- [The JuliaPlots Organization](#the-juliaplots-organization): Packages and dependencies
- [Key Design Principles](#key-design-principles): Design goals and considerations
- [Code Organization](#code-organization): Where to look when implementing new features
- [Git-fu (or... the mechanics of contributing)](#git-fu-or-the-mechanics-of-contributing): Git (how to commit/push), Github (how to submit a PR), Testing (VisualRegressionTests, Travis)


## The JuliaPlots Organization

[JuliaPlots](https://github.com/JuliaPlots) is the home for all things Plots.  It was founded by [Tom Breloff](http://www.breloff.com), and extended through many contributions from [members](https://github.com/orgs/JuliaPlots/people) and others.  The first step in contributing will be to understand which package(s) are appropriate destinations for your code.


### Plots

This is the core package for:

- Definitions of `plot`/`plot!`
- The [core processing pipeline](/pipeline)
- Base [recipes](/recipes) for `path`, `scatter`, `bar`, and many others
- Generic [output](/output) methods
- Generic [layout](/layouts) methods
- Generic [animation](/animations) methods
- Generic types: Plot, Subplot, Axis, Series, ...
- Conveniences: `getindex`/`setindex`, `push!`/`append!`, `unzip`, `cycle`, ...

This package depends on RecipesBase, PlotUtils, and PlotThemes.  When contributing new functionality/features, you should make best efforts to find a more appropriate home (StatPlots, PlotUtils, etc) than contributing to core Plots.  In general, the push has been to reduce the size and scope of Plots, when possible, and move features to other packages.

### Backends

In Julia versions v0.5 and earlier, backend code (such as code linking Plots with GR) lived in the `Plots/src/backends` directory.  As such, backend code should be contributed to core Plots.

Starting with v0.6, the backend code will live in separate repos, and loaded on demand.  For example, the GR backend is being developed at [PlotsGR](https://github.com/JuliaPlots/PlotsGR.jl).  Users targeting v0.6 and later should contribute to the respective backend package "Plots[backend].jl".

Note: As of 2/22/17, the `reorg` branch of Plots is needed for compatibility with the new backend repos.  This will be merged into the master branch sometime after the release of v0.6.

This redesign will help with improved support for precompilation, and a cleaner separation of "generic plotting" development and "backend-specific" development.

### PlotDocs

This is the home of this documentation.  The documentation is built using the "material" theme in "mkdocs".  For those contributing documentation (to the `docs` directory of PlotDocs), it must be subsequently built and deployed using the following instructions:

```
# Note: the site is built inside the PlotDocs.jl repo, but then deployed to the JuliaPlots organization page

# To build, run from inside the PlotDocs directory:
#     mkdocs build --clean
# (optional) Make the githubio remote point to JuliaPlots/juliaplots.github.io:
#     git remote add githubio git@github.com:JuliaPlots/juliaplots.github.io.git
# Add files, commit, then push:
#     git push origin master
# Push just the site directory to the master branch of githubio
#     git subtree push --prefix site githubio master
```

### RecipesBase

Seldom updated, but essential.  This is the package that you would depend on to create third-party recipes.  It contains the bare minimum to define new recipes.

### PlotUtils

Components that could be used for other (non-Plots) packages.  Anything that is sufficiently generic and useful could be contributed here.

- Color (conversions, construction, conveniences)
- Color gradients/maps
- Tick computation

### PlotThemes

Visual themes (i.e. attribute defaults) such as "dark", "orange", etc.

### StatPlots

An extension of Plots: Statistical plotting and tabular data.  Complex histograms and densities, correlation plots, and support for DataFrames.  Anything related to stats or special handling for table-like data should live here.

### PlotRecipes

An extension of StatPlots: Graphs, maps, and more.  If it's not a "base recipe", and also not clearly "statistical" in nature, then this package might be a good home.

### MLPlots

An extension of PlotRecipes, geared toward Machine Learning applications: neural nets, spike trains, ROC curves, and more.

### GGPlots

A prototype API/interface for "Grammar of Graphics" style plotting.  This likely wouldn't add actual functionality, but would give users coming from R/ggplot2 a simple way to avoid Gadfly.  I (Tom) wrote the prototype to show how easy it is, but since I dislike GoG-style, I never finished it.  Completing this package would be a great self-contained project for interested parties.



## Key Design Principles

Flexible and generic... these are the core principles underlying Plots development, and also tend to cause confusion when users laser-focus on their specific use case.

I (Tom) have painstakingly designed the core logic to support nearly any use case that exists or may exist.  I don't pretend to know how you want to use Plots, or what type of data you might pass in, or what sort of recipe you may want to apply.  As such, I try to avoid unnecessary restriction of types, or forced conversions, or many other pitfalls of limited visualization frameworks.  The result is a highly modular framework which is limited by your imagination.

When contributing new features to Plots (or the surrounding ecosystem), you should strive for this mentality as well.  New features should be left as generic as possible, while avoiding obvious feature clash.

As an example, you may want a new recipe that, shows a histogram when passed Float64 numbers, but shows counts of every unique value for strings.  So you make a recipe that works perfectly for your purpose:

```julia
using Plots, StatsBase
gr(size=(300,300), leg=false)

@userplot MyCount
@recipe function f(mc::MyCount)
    # get the array from the args field
    arr = mc.args[1]

    T = typeof(arr)
    if T.parameters[1] == Float64
        seriestype := :histogram
        arr
    else
        seriestype := :bar
        cm = countmap(arr)
        x = sort!(collect(keys(cm)))
        y = [cm[xi] for xi=x]
        x, y
    end
end
```

The recipe defined above is a "user recipe", which builds a histogram for arrays of Float64, and otherwise shows a "countmap" of sorted unique values and their observed counts.  You only care about Float64 and String, and so you're results are fine:

```julia
mycount(rand(500))
```

![](https://cloud.githubusercontent.com/assets/933338/23183178/24e38dcc-f849-11e6-9fb5-e6ad722b433f.png)

```julia
mycount(rand(["A","B","C"],100))
```

![](https://cloud.githubusercontent.com/assets/933338/23183192/2ef6fd26-f849-11e6-9114-ea4d24b16bcb.png)

But you didn't consider the person that, in the future, might want to pass integers to this recipe:

```julia
mycount(rand(1:500, 500))
```

![](https://cloud.githubusercontent.com/assets/933338/23183201/3a04e6f6-f849-11e6-8808-5d7f78e6aeb7.png)

This user expected integers to be treated as numbers and output a histogram, but instead they were treated like strings.  A simple solution would have been to replace `if T.parameters[1] == Float64` with `if T.parameters[1] <: Number`.  However, should we even depend on `T` having it's first parameter be the element type? (No)  So even better would be `if eltype(arr) <: Number`, which now allows any container with any numeric type to trigger the "histogram" logic.

This simple example outlines a common theme when developing Plots (or really any other Julia package).  Try to create the most generic implementation you can think of while maintaining correctness.  You don't know what crazy types someone else will use to try to access your functionality.


## Code Organization



## Git-fu (or... the mechanics of contributing)

hfdkfhjdk

hfdkfhjdk

hfdkfhjdk

hfdkfhjdk

hfdkfhjdk

hfdkfhjdk

hfdkfhjdk

hfdkfhjdk

hfdkfhjdk

hfdkfhjdk

hfdkfhjdk

hfdkfhjdk

hfdkfhjdk

hfdkfhjdk

hfdkfhjdk

hfdkfhjdk

hfdkfhjdk

hfdkfhjdk

hfdkfhjdk

hfdkfhjdk

hfdkfhjdk

hfdkfhjdk

hfdkfhjdk

hfdkfhjdk

hfdkfhjdk

hfdkfhjdk
