# avoid some images failing on travis
push!(Plots._backend_skips[:plotlyjs], 24)

function no_initialize_backend(be)
    Plots.CURRENT_BACKEND.sym = be
    Plots.CURRENT_BACKEND.pkg = Plots._backend_instance(be)
end

# ------------------------------------------------------------------------------
# reference images

filename(i::Int) = string("ref", i, i in Plots._animation_examples ? ".gif" : ".png")


"""
    generate_reference_images(be::Symbol, overwrite = true)

Generate all Plots.jl reference images for the backend `be` for PlotDocs.jl.
Working backends are `:gr`, `:pyplot`, `:plotlyjs` and `:pgfplots`.
If `overwrite == true` existing files are overwritten.
"""
function generate_reference_images(be::Symbol, overwrite = true)
    for i in eachindex(Plots._examples)
        if i in Plots._backend_skips[be]
            @info "Skipping $be reference image $i."
        else
            @info "Generating $be reference image $i."
            generate_reference_image(be, i, overwrite)
        end
    end
end


"""
    function generate_reference_image(be::Symbol, i::Int, overwrite::Bool = true)

Generate the Plots.jl reference image `i` for the backend `be` for PlotDocs.jl.
Working backends are `:gr`, `:pyplot`, `:plotlyjs` and `:pgfplots`.
If `overwrite == true` the existing file is overwritten.
"""
function generate_reference_image(be::Symbol, i::Int, overwrite = true)
    @eval PlotDocs theme(:default)
    no_initialize_backend(be)
    map(ex -> Base.eval(PlotDocs, ex), Plots._examples[i].exprs)

    dir = joinpath(IMGDIR, string(be))
    isdir(dir) || mkpath(dir)

    fn = joinpath(dir, filename(i))
    overwrite || !isfile(fn) || return

    if i in REFERENCE_ANIMATION_INDS
        anim = @eval PlotDocs anim
        Plots.gif(anim, fn, fps = 15)
    else
        Plots.savefig(fn)
    end

    return
end

const REFERENCE_ANIMATION_INDS = (2, 30)


# ------------------------------------------------------------------------------
# documentation examples

"""
    generate_doc_images(overwrite = true)

Generate all PlotDocs images.
If `overwrite == true` existing files are overwritten.
"""
function generate_doc_images(overwrite = true)
    for (i, id) in enumerate(keys(DOC_IMAGES))
        @info "Generating PlotDocs image $i: $id"
        generate_doc_image(id, overwrite)
    end
end


"""
    function generate_doc_image(id::AbstractString, overwrite::Bool = true)

Generate the PlotDocs image specified by `id`.
Choose from $(keys(DOC_IMAGES)).
If `overwrite == true` the existing file is overwritten.
"""
function generate_doc_image(id::AbstractString, overwrite = true)
    @eval PlotDocs theme(:default)
    Random.seed!(1234)
    map(ex -> Base.eval(PlotDocs, ex), DOC_IMAGES[id])

    dir = joinpath(IMGDIR, DOC_IMAGE_FILES[id])
    isdir(dir) || mkpath(dir)

    filetype = if id in DOC_ANIMATION_IMAGES
        ".gif"
    elseif id in DOC_MP4_IMAGES
        ".mp4"
    else
        ".png"
    end
    fn = joinpath(dir, string(id, filetype))
    overwrite || !isfile(fn) || return

    if id in DOC_ANIMATION_IMAGES
        anim = @eval PlotDocs anim
        if typeof(anim) <: Plots.AnimatedGif
            mv(anim.filename, fn, force = true)
        else
            Plots.gif(anim, fn, fps = 15)
        end
    elseif id in DOC_MP4_IMAGES
        anim = @eval PlotDocs anim
        mp4(anim, fn, fps = 30)
    else
        Plots.savefig(fn)
    end

    return
end
