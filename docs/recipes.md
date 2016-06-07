
# Advanced Recipes

Like other tools in Plots, recipes are relatively simple, but extremely powerful.  A recipe is created by invoking the `@recipe` macro, which is defined in the lightweight package [RecipesBase](https://github.com/JuliaPlots/RecipesBase.jl).  There are many examples of recipes both within Plots and in many external packages, including [PlotRecipes](https://github.com/JuliaPlots/PlotRecipes.jl).

There are three main types of recipes in Plots:

- User Recipes
- Type Recipes
- Series Recipes

I'll discuss all three in detail later.  First, lets decompose what's happening inside the recipe macro.  Lets start with a simple recipe:

```julia
type MyType end

@recipe function f(::MyType, n::Integer = 10; add_marker = false)
	linecolor   --> :blue
	seriestype  :=  :path
	markershape --> (add_marker ? :ellipse : :none)
	delete!(d, :add_marker)
	rand(n)
end
```

We create a new type `MyType`, which is empty, and used purely for dispatch.  Our goal here is to create a random path of `n` points.

There are a few important things to know, after which recipes boil down to updating an attribute dictionary and returning input data:

- A recipe signature `f(args...; kw...)` is converted into a definition of `apply_recipe(d::KW, args...)` where:
	- `d` is an attribute dictionary of type `typealias KW Dict{Symbol,Any}`
	- Your `args` must be distinct enough that dispatch will call your definition (without masking an existing definition).  New types will ensure this.
	- The function `f` is unused/meaningless... call it whatever you want.
	- Keyword arguments `kw` have special treatment.  They are added to the attribute dictionary `d` **and** assigned to a local variable of the same name.
		- Note that you will need to `pop!(d, k)` or `delete!(d, k)` to clean up the attributes when you're done.  (this requirement will probably be removed eventually)
- The special operator `-->` turns `linecolor --> :blue` into `get!(d, :linecolor, :blue)`, setting the attribute only when it doesn't already exist.  (Tip: Wrap the right hand side in parentheses for complex expressions.)
- The special operator `:=` turns `seriestype := :path` into `d[:seriestype] = :path`, forcing that attribute value.  (Tip: Wrap the right hand side in parentheses for complex expressions.)
- The return value of the recipe is the `args` of a `RecipeData` object, which also has a reference to the attribute dictionary.
- A recipe returns a Vector{RecipeData}.  We'll see how to add to this list later with the `@series` macro.

In the example above, we use `MyType` for dispatch, with optional positional argument `n::Integer`.  With a call to `plot(MyType())` or similar, this recipe will be invoked.  If `linecolor` has not been set, it is set to `:blue`.  The `seriestype` is forced to be `:path`.  The `markershape` is a little more complex; it checks the `add_marker` custom keyword, but only if `markershape` was not already set.  (Note: the `add_marker` key is redundant, as the user can just set the marker shape... I add it only to show functionality.) We remove the `add_marker` key from our attribute dictionary, then return the data to be plotted.

```julia
mt = MyType()
plot(
	plot(mt),
	plot(mt, 100, linecolor = :red),
	plot(mt, marker = (:star,20), add_marker = false),
	plot(mt, add_marker = true)
)
```

![](/examples/img/recipes1.png)


