
### [Animations](@id animations)

Animations are created in 3 steps:

- Initialize an `Animation` object.
- Save each frame of the animation with `frame(anim)`.
- Convert the frames to an animated gif with `gif(anim, filename, fps=15)`

!!! tip
	The convenience macros `@gif` and `@animate` simplify this code immensely.  See the [home page](@ref simple-is-beautiful) for examples of the short version, or the [pyplot example](@ref pyplot-ref2) for the long version.

---

### Convenience macros

There are two macros for varying levels of convenience in creating animations: `@animate` and `@gif`.  The main difference is that `@animate` will return an `Animation` object for later processing, and `@gif` will create an animated gif file (and display it when returned to an IJulia cell).

Use `@gif` for simple, one-off animations that you want to view immediately.  Use `@animate` for anything more complex.  Constructing `Animation` objects can be done when you need full control of the life-cycle of the animation (usually unnecessary though).

Examples:

```julia
anim = @animate for i=1:100
    plot(...)
end
gif(anim, "/tmp/anim_fps15.gif", fps = 15)
gif(anim, "/tmp/anim_fps30.gif", fps = 30)
```

The `every` flag will only save a frame "every N iterations":

```julia
@gif for i=1:100
	plot(...)
end every 10
```

The `when` flag will only save a frame "when the expression is true"

```julia
@gif for i=1:100
	plot(...)
end when i > 50 && mod1(i, 10) == 5
```
