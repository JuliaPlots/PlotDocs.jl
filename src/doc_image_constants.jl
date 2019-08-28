const DOC_IMAGES = OrderedDict(

    "lorenz_attractor" => [quote
        using Plots
        gr()

        # define the Lorenz attractor
        mutable struct Lorenz
            dt; σ; ρ; β; x; y; z
        end

        function step!(l::Lorenz)
            dx = l.σ * (l.y - l.x)       ; l.x += l.dt * dx
            dy = l.x * (l.ρ - l.z) - l.y ; l.y += l.dt * dy
            dz = l.x * l.y - l.β * l.z   ; l.z += l.dt * dz
        end

        attractor = Lorenz((dt = 0.02, σ = 10., ρ = 28., β = 8//3, x = 1., y = 1., z = 1.)...)

        # initialize a 3D plot with 1 empty series
        plt = plot3d(1, xlim = (-25, 25), ylim = (-25, 25), zlim=(0, 50), title = "Lorenz Attractor", marker = 2)

        # build an animated gif by pushing new points to the plot, saving every 10th frame
        anim = @gif for i in 1:1500
            step!(attractor)
            push!(plt, attractor.x, attractor.y, attractor.z)
        end every 10
    end],


    "waves" => [quote
        using Plots, ProgressMeter
        no_initialize_backend(:pyplot)
        default(leg = false, ticks = nothing) #change to the pyplot backend and define some defaults
        x = y = range(-5, stop = 5, length = 40)
        zs = zeros(0,40)
        n = 100

        # create a progress bar for tracking the animation generation
        prog = Progress(n,1)

        anim = @gif for i in range(0, stop = 2π, length = n)
            f(x,y) = sin(x + 10 * sin(i)) + cos(y)

            # create a plot with 3 subplots and a custom layout
            l = @layout [a{0.7w} b; c{0.2h}]
            p = plot(x, y, f, st = [:surface, :contourf], layout=l)

            # induce a slight oscillating camera angle sweep, in degrees (azimuth, altitude)
            plot!(p[1], camera=(15 * cos(i), 40))

            # add a tracking line
            fixed_x = zeros(40)
            z = map(f, fixed_x, y)
            plot!(p[1], fixed_x, y, z, line = (:black, 5, 0.2))
            vline!(p[2], [0], line = (:black, 5))

            # add to and show the tracked values over time
            global zs = vcat(zs, z')
            plot!(p[3], zs, alpha = 0.2, palette = cgrad(:blues).colors)

            # increment the progress bar
            next!(prog)
        end
    end],


    "decision" => [quote
        gr()
        Random.seed!(7) # for a consistent result

        P = 40;  R = 50;  N = P*R;  r = 0:0.004:1
        points = rand(ComplexF64, P, R)

        anim = @animate(for t = 0:0.03:13
            # create a simple classifier to return the region for any point (x, y)
            midpoints = vec(sum(points; dims=1)) / P
            classify(x, y) = argmin(abs.(x + y*im .- midpoints))

            # draw decision boundary and points
            contour(r, r, classify, c=:cyclic2, fill=true, nlev=R, leg=:none)
            scatter!(reim(points)..., c=cvec(:cyclic2, R)', lims=(0,1))

            # update position of points
            target(d) = 0.65*cis(4*sin(t/2+d)+d) + 0.5 + 0.5im
            points[:] .+= 0.01*(target.(0:2π/(N-1):2π) .- points[:])
        end)
    end],

    "decision-poster" => [quote
        gr()
        Random.seed!(7) # for a consistent result

        P = 40;  R = 50;  N = P*R;  r = 0:0.004:1
        points = rand(ComplexF64, P, R)

        for t = 0:0.03:13
            # create a simple classifier to return the region for any point (x, y)
            midpoints = vec(sum(points; dims=1)) / P
            classify(x, y) = argmin(abs.(x + y*im .- midpoints))

            # draw decision boundary and points
            contour(r, r, classify, c=:cyclic2, fill=true, nlev=R, leg=:none)
            scatter!(reim(points)..., c=cvec(:cyclic2, R)', lims=(0,1))

            # poster image, shown before video starts
            if t ≈ 7.5
                contour(r, r, classify, c=:cyclic2, fill=true, nlev=R, leg=:none)
                return scatter!(reim(points)..., c=cvec(:cyclic2, R)', lims=(0,1))
            end

            # update position of points
            target(d) = 0.65*cis(4*sin(t/2+d)+d) + 0.5 + 0.5im
            points[:] .+= 0.01*(target.(0:2π/(N-1):2π) .- points[:])
        end
        png(local_path("PlotDocs", "index", "decision-poster.png"))
    end],


    "iris" => [quote
        using StatsPlots, RDatasets
        gr()

        # load a dataset
        iris = dataset("datasets", "iris")

        # Scatter plot with some custom settings
        @df iris scatter(:SepalLength, :SepalWidth,
            group = :Species,
            title = "My awesome plot",
            xlabel = "Length",
            ylabel = "Width",
            m = (0.5, [:cross :hex :star7], 12),
            bg = RGB(0.2, 0.2, 0.2))
    end],


    "lines_1" => [quote
        gr()
        x = 1:10; y = rand(10) # These are the plotting data
        plot(x, y)
    end],


    "lines_2" => [quote
        gr()
    end,
    quote
        x = 1:10; y = rand(10, 2) # 2 columns means two lines
        plot(x, y)
    end],


    "lines_3" => [quote
        gr()
        x = 1:10; y = rand(10, 2)
    end,
    quote
        z = rand(10)
        plot!(x, z)
    end],


    "lines_4" => [quote
        gr()
    end,
    quote
        x = 1:10; y = rand(10,2) # 2 columns means two lines
        p = plot(x, y)
        z = rand(10)
        plot!(p, x, z)
    end],


    "attr_1" => [quote
        gr()
    end,
    quote
        x = 1:10; y = rand(10,2) # 2 columns means two lines
        plot(x, y, title = "Two Lines", label = ["Line 1" "Line 2"], lw = 3)
    end],


    "attr_2" => [quote
        gr()
    end,
    quote
        xlabel!("My x label")
    end],


    "backends_1" => [quote
        using Plots
        no_initialize_backend(:plotlyjs)
        x = 1:10; y = rand(10,2) # 2 columns means two lines
        plot(x, y, title = "This is Plotted using Plotly")
    end],


    "backends_2" => [quote
        gr() # Set the backend to GR
        plot(x, y, title = "This is Plotted using GR") # This plots using GR
    end],


    "scatter_1" => [quote
        gr() # We will continue onward using the GR backend
        plot(x, y, seriestype = :scatter, title = "My Scatter Plot")
    end],


    "scatter_2" => [quote
        gr()
    end,
    quote
        scatter(x, y, title = "My Scatter Plot")
    end],


    "subplots_1" => [quote
        gr()
    end,
    quote
        y = rand(10, 4)
        plot(x, y, layout = (4, 1))
    end],


    "subplots_2" => [quote
        gr()
    end,
    quote
        p1 = plot(x, y) # Make a line plot
        p2 = scatter(x, y) # Make a scatter plot
        p3 = plot(x, y, xlabel = "This one is labelled", lw = 3, title = "Subtitle")
        p4 = histogram(x, y) # Four histograms each with 10 points? Why not!
        plot(p1, p2, p3, p4, layout = (2, 2), legend = false)
    end],


    "user_recipes_1" => [quote
        gr()
    end,
    quote
        # Pkg.add("StatsPlots")
        using StatsPlots # Required for the DataFrame user recipe
        # Now let's create the DataFrame
        using DataFrames
        df = DataFrame(a = 1:10, b = 10 * rand(10), c = 10 * rand(10))
        # Plot the DataFrame by declaring the points by the column names
        @df df plot(:a, [:b :c]) # x = :a, y = [:b :c]. Notice this is two columns!
    end],


    "user_recipes_2" => [quote
        gr()
        df = DataFrame(a = 1:10, b = 10 * rand(10), c = 10 * rand(10))
    end,
    quote
        @df df scatter(:a, :b, title = "My DataFrame Scatter Plot!") # x = :a, y = :b
    end],


    "type_recipes" => [quote
        gr()
    end,
    quote
        using Distributions
        plot(Normal(3, 5), lw = 3)
    end],


    "plot_recipes" => [quote
        gr()
    end,
    quote
        #Pkg.add("RDatasets")
        using RDatasets
        iris = dataset("datasets", "iris")
    end],


    "series_recipes_1" => [quote
        using StatsPlots
        gr()
    end,
    quote
        y = rand(100, 4) # Four series of 100 points each
        StatsPlots.violin(["Series 1" "Series 2" "Series 3" "Series 4"], y, leg = false)
    end],


    "series_recipes_2" => [quote
        using StatsPlots
        gr()
    end,
    quote
        StatsPlots.boxplot!(["Series 1" "Series 2" "Series 3" "Series 4"], y, leg = false)
    end],


    "columns_are_series" => [quote
        gr()
    end,
    quote
        # 10 data points in 4 series
        xs = 0:(2π / 10):2π
        data = [sin.(xs) cos.(xs) 2sin.(xs) 2cos.(xs)]

        # We put labels in a row vector: applies to each series
        labels = ["Apples" "Oranges" "Hats" "Shoes"]

        # Marker shapes in a column vector: applies to data points
        markershapes = [:circle, :star5]

        # Marker colors in a matrix: applies to series and data points
        markercolors = [:green :orange :black :purple :red :yellow :brown :white]

        plot(xs, data, label = labels, shape = markershapes, color = markercolors, markersize = 10)
    end],

    "groups" => [quote
        no_initialize_backend(:plotlyjs)
    end,
    quote
        function rectangle_from_coords(xb,yb,xt,yt)
            [
                xb yb
                xt yb
                xt yt
                xb yt
                xb yb
                NaN NaN
            ]
        end

        some_rects=[
            rectangle_from_coords(1, 1, 5, 5)
            rectangle_from_coords(10, 10, 15, 15)
        ]
        other_rects=[
            rectangle_from_coords(1, 10, 5, 15)
            rectangle_from_coords(10, 1, 15, 5)
        ]

        plot(some_rects[:,1], some_rects[:,2], label = "some group")
        plot!(other_rects[:,1], other_rects[:,2], label = "other group")
    end],


    "dataframes" => [quote
        gr() # maybe remove again
    end,
    quote
        using StatsPlots, RDatasets
        iris = dataset("datasets", "iris")
        @df iris scatter(:SepalLength, :SepalWidth, group = :Species,
            m = (0.5, [:+ :h :star7], 12), bg = RGB(0.2, 0.2, 0.2))
    end],


    "batman" => [quote
        pyplot(leg = false, framestyle = :none, size=(500,500))
    end,
    quote
        P2 = Plots.P2
        function make_batman()
            p = P2[(0,0), (0.5, 0.2), (1, 0), (1,2),  (0.3,1.2), (0.2,2), (0,1.7)]
            m = P2[(p[i]+p[i+1])/2 for i=1:length(p)-1]
            m += P2[(0.2, 1), (0.4, 1), (2, 0), (0.5, -0.6), (0,0), (0,-0.15)]

            pts = P2[]
            for (i,mi) in enumerate(m)
                append!(pts, coords(BezierCurve(P2[p[i], m[i], p[i+1]])))
            end
            x, y = Plots.unzip(pts)
            Shape(vcat(x, -reverse(x)), vcat(y, reverse(y)))
        end
    end,
    quote
        # background and limits
        plt = plot(bg = :black, xlim = (0.1,0.9), ylim = (0.2,1.5))

        # create an ellipse in the sky
        pts = Plots.partialcircle(0,2π,100,0.1)
        x, y = Plots.unzip(pts)
        x = 1.5x .+ 0.7
        y .+= 1.3
        pts = collect(zip(x, y))

        # beam
        beam = Shape([(0.3, 0.0), pts[95], pts[50], (0.3, 0.0)])
        plot!(beam, fillcolor = plot_color(:yellow, 0.3))

        # spotlight
        plot!(Shape(x,y), c=:yellow)
    end,
    quote
        # buildings
        rect(w, h, x, y) = Shape(x .+ [0,w,w,0,0], y .+ [0,0,h,h,0])
        gray(pct) = RGB(pct,pct,pct)
        function windowrange(dim, denom)
            range(0, 1, length = max(3, round(Int, dim/denom)))[2:end-1]
        end

        for k=1:50
            w, h, x, y = 0.1rand()+0.05, 0.8rand()+0.3, rand(), 0.0
            shape = rect(w, h, x, y)
            graypct = 0.3rand()+0.3
            plot!(shape, c = gray(graypct))

            # windows
            I = windowrange(w,0.015)
            J = windowrange(h,0.04)
            pts = vec([(Float64(x+w*i), Float64(y+h*j)) for i=I,j=J])
            windowcolors = Symbol[rand()<0.2 ? :yellow : :black for i=1:length(pts)]
            scatter!(pts, marker = (stroke(0), :rect, windowcolors))
        end
        plt
    end,
    quote
        # Holy plotting, Batman!
        batman = Plots.scale(make_batman(), 0.07, 0.07, (0,0))
        batman = translate(batman, 0.7, 1.23)
        plot!(batman, fillcolor = :black,  size=(500,500))
    end],


    "my_count_1" => [quote
        using Plots, StatsBase
        gr()
        default(size = (300, 300), leg = false)

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
        mycount(rand(500))
    end],


    "my_count_2" => [quote
        gr()
        default(size = (300, 300), leg = false)
    end,
    quote
        mycount(rand(["A", "B", "C"], 100))
    end],


    "my_count_3" => [quote
        gr()
        default(size = (300, 300), leg = false)
    end,
    quote
        mycount(rand(1:500, 500))
    end],


    "pipeline_1" => [quote
        n = 100
        x, y = range(0, stop=1, length=n), randn(n, 3)
        using Plots
        no_initialize_backend(:pyplot)
        plot(x, y, line = (0.5, [4 1 0], [:path :scatter :density]),
            marker = (10, 0.5, [:none :+ :none]), fill = 0.5,
            orientation = :h, title = "My title")
    end],


    "pipeline_2" => [quote
        gr()
        mutable struct MyVecWrapper
            v::Vector{Float64}
        end
        myvec = MyVecWrapper(rand(100))

        @recipe function f(myvec::MyVecWrapper)
            markershape --> :circle
            markersize  --> 30
            myvec.v
        end

        plot(
            plot(myvec.v),
            plot(myvec)
        )
    end],


    "pipeline_3" => [quote
        gr()
    end,
    quote
        scatter(rand(100), group = rand(1:3, 100), marker = (10, 0.3, [:s :o :x]))
    end],


    "layout_1" => [quote
        gr()
    end,
    quote
        # create a 2x2 grid, and map each of the 4 series to one of the subplots
        plot(rand(100, 4), layout = 4)
    end],


    "layout_2" => [quote
        gr()
    end,
    quote
        # create a 4x1 grid, and map each of the 4 series to one of the subplots
        plot(rand(100,4), layout = (4, 1))
    end],


    "layout_3" => [quote
        gr()
    end,
    quote
        plot(rand(100, 4), layout = grid(4, 1, heights = [0.1, 0.4, 0.4, 0.1]))
    end],


    "layout_4" => [quote
        gr()
    end,
    quote
        l = @layout [a{0.3w} [grid(3, 3)
                                b{0.2h}]]
        plot(
            rand(10, 11),
            layout = l, legend = false, seriestype = [:bar :scatter :path],
            title = ["($i)" for j = 1:1, i = 1:11], titleloc = :right, titlefont = font(8)
        )
    end],


    "layout_5" => [quote
        # boxplot is defined in StatsPlots
        using StatsPlots
        gr()
        default(leg = false, bg = :lightgrey)

        # Create a filled contour and boxplot side by side.
        plot(contourf(randn(10, 20)), boxplot(rand(1:4, 1000), randn(1000)))

        # Add a histogram inset on the heatmap.
        # We set the (optional) position relative to bottom-right of the 1st subplot.
        # The call is `bbox(x, y, width, height, origin...)`, where numbers are treated as "percent of parent"
        histogram!(randn(1000), inset = (1, bbox(0.05, 0.05, 0.5, 0.25, :bottom, :right)), ticks = nothing, subplot = 3, bg_inside = nothing)

        # Add sticks floating in the window (inset relative to the window, as opposed to being relative to a subplot)
        sticks!(randn(100), inset = bbox(0,-0.2, 200Plots.px, 100Plots.px, :center), ticks = nothing, subplot = 4)
    end],
)

const DOC_ANIMATION_IMAGES = ["lorenz_attractor", "waves", "rand_anim"]
const DOC_MP4_IMAGES = ["decision"]

const DOC_IMAGE_FILES = Dict(
    "lorenz_attractor" => "index",
    "waves" => "index",
    "decision" => "index",
    "decision-poster" => "index",
    "iris" => "index",
    "lines_1" => "tutorial",
    "lines_2" => "tutorial",
    "lines_3" => "tutorial",
    "lines_4" => "tutorial",
    "attr_1" => "tutorial",
    "attr_2" => "tutorial",
    "backends_1" => "tutorial",
    "backends_2" => "tutorial",
    "scatter_1" => "tutorial",
    "scatter_2" => "tutorial",
    "subplots_1" => "tutorial",
    "subplots_2" => "tutorial",
    "user_recipes_1" => "tutorial",
    "user_recipes_2" => "tutorial",
    "type_recipes" => "tutorial",
    "plot_recipes" => "tutorial",
    "series_recipes_1" => "tutorial",
    "series_recipes_2" => "tutorial",
    "columns_are_series" => "input",
    "groups" => "input",
    "dataframes" => "input",
    "batman" => "input",
    "rand_anim" => "animations",
    "my_count_1" => "contributing",
    "my_count_2" => "contributing",
    "my_count_3" => "contributing",
    "pipeline_1" => "pipeline",
    "pipeline_2" => "pipeline",
    "pipeline_3" => "pipeline",
    "layout_1" => "layout",
    "layout_2" => "layout",
    "layout_3" => "layout",
    "layout_4" => "layout",
    "layout_5" => "layout",
)
