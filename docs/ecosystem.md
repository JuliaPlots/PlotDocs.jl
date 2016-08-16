Plots is great on its own, but the real power comes from the ecosystem surrounding it.  The design of Plots (and more specifically [RecipesBase](https://github.com/JuliaPlots/RecipesBase.jl)) is to bind together disparate functionality into a cohesive and consistent user experience.  Some packages may choose to implement recipes to visualize their custom types.  Others may extend the functionality of Plots for Base types.  On this page I'll attempt to collect and display some of the many things you can do using the ecosystem which has developed around the Plots core.

---

# JuliaPlots

The [JuliaPlots](https://github.com/JuliaPlots) organization builds and maintains much of the most commonly used functionality external to core Plots, as well as RecipesBase, PlotUtils, the documentation, and more.

## [StatPlots](https://github.com/JuliaPlots/StatPlots.jl)

Much of this functionality once existed in core Plots, but has been moved out to facilitate a clean separation between those features that are truly "core" and those which are specific to certain types of workflows and disciplines.  

- Types:
    - DataFrames
    - Distributions
- Recipes:
    - histogram/histogram2d
    - boxplot
    - violin
    - marginalhist
    - corrplot/cornerplot


![](https://cloud.githubusercontent.com/assets/933338/16709018/81c4da34-45d2-11e6-9e08-bb557541e144.png)



![](https://cloud.githubusercontent.com/assets/933338/16030833/3c84e6bc-31c3-11e6-9a04-4cee531440a4.png)


![](https://cloud.githubusercontent.com/assets/4098145/16762241/f924c8ac-4823-11e6-8720-83025606b5e1.png)


![](https://juliaplots.github.io/examples/img/pyplot/pyplot_example_30.png)


![](https://cloud.githubusercontent.com/assets/933338/16718702/561510f6-46f0-11e6-834a-3cf17a5b77d6.png)



![](https://cloud.githubusercontent.com/assets/933338/16718720/729b6fea-46f0-11e6-9bff-fdf2541ce305.png)




## [PlotRecipes](https://github.com/JuliaPlots/PlotRecipes.jl)

A catch-all for functionality and recipes which don't have a home elsewhere.  Graphs (networks of nodes and edges), maps/shapes, finance, and more.


![graph3d](https://cloud.githubusercontent.com/assets/933338/16094180/0dd2edf0-330d-11e6-8596-d12b0b8d5393.png)


![graph_layout](https://cloud.githubusercontent.com/assets/933338/16698919/ee1f9e76-451e-11e6-8936-881551f120dd.gif)


![arcs](https://cloud.githubusercontent.com/assets/2822757/16072526/aba39c2e-32b7-11e6-947c-6faab1d13cc7.png)


![map](https://cloud.githubusercontent.com/assets/933338/16770876/83dea362-481c-11e6-9943-bb77148be5b8.png)


![portcomp](https://cloud.githubusercontent.com/assets/933338/17529235/96a48040-5e40-11e6-8698-7d371f36fd22.png)


---

# Community packages

## AtariAlgos

AtariAlgos wraps the ArcadeLearningEnvironment as an implementation of an AbstractEnvironment from the Reinforce interface. This allows it to be used as a plug-and-play module with general reinforcement learning agents.

Games can also be "plotted" using Plots.jl, allowing it to be a component of more complex visualizations for tracking learning progress and more, as well as making it easy to create animations.

![](https://cloud.githubusercontent.com/assets/933338/17670982/8923a2f6-62e2-11e6-943f-bd0a2a7b5c1f.gif)

## [DifferentialEquations](https://github.com/ChrisRackauckas/DifferentialEquations.jl)

DifferentialEquations.jl is a package for solving numerically solving differential equations in Julia by Chris Rackauckas. The purpose of this package is to supply efficient Julia implementations of solvers for various differential equations. Equations within the realm of this package include ordinary differential equations (ODEs), stochastic ordinary differential equations (SODEs or SDEs), stochastic partial differential equations (SPDEs), partial differential equations (with both finite difference and finite element methods), differential algebraic equations, and differential delay equations. It includes well-optimized implementations classic algorithms and ones from recent research, including algorithms optimized for high-precision and HPC applications.

All of the solvers return solution objects which are set up with plot recipes to give informative default plots.

![diffeq](https://cloud.githubusercontent.com/assets/1814174/17526562/9daa2d1e-5e1c-11e6-9f21-fda6f49f6833.png)

## [PhyloTrees](https://github.com/jangevaare/PhyloTrees.jl)

The PhyloTrees.jl package provides a type representation of phylogenetic trees. Simulation, inference, and visualization functionality is also provided for phylogenetic trees. A plot recipe allows the structure of phylogenetic trees to be drawn by whichever plotting backend is preferred by the user.

![](https://cloud.githubusercontent.com/assets/5422422/17630286/a25374fc-608c-11e6-9160-32466b094f0b.png)



TODO:

## MLPlots

## ValueHistories

## Losses

## IterativeSolvers

## SymPy

## ImplicitEquations

## OnlineStats

## AverageShiftedHistograms

## Robotlib

## EEG

## ControlSystems

## ApproxFun

## JWAS

## QuantEcon

## Reinforce

## Optim


