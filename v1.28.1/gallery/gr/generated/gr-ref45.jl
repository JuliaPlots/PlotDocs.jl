using Plots
gr()
Plots.reset_defaults()  #hide

begin
    struct Measurement <: Number
        val::Float64
        err::Float64
    end
    value(m::Measurement) = begin
            m.val
        end
    uncertainty(m::Measurement) = begin
            m.err
        end
    @recipe function f(::Type{T}, m::T) where T <: AbstractArray{<:Measurement}
            if !(get(plotattributes, :seriestype, :path) in [:contour, :contourf, :contour3d, :heatmap, :surface, :wireframe, :image])
                error_sym = Symbol(plotattributes[:letter], :error)
                plotattributes[error_sym] = uncertainty.(m)
            end
            value.(m)
        end
    x = Measurement.(10 * sort(rand(10)), rand(10))
    y = Measurement.(10 * sort(rand(10)), rand(10))
    z = Measurement.(10 * sort(rand(10)), rand(10))
    surf = Measurement.((1:10) .* (1:10)', rand(10, 10))
    plot(scatter(x, [x y]), scatter(x, y, z), heatmap(x, y, surf), wireframe(x, y, surf), legend = :topleft)
end

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

