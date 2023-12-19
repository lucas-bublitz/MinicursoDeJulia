

# Tópicos abordados:
#   números complexos;
#   matrizes;
#   operadores especiais (dot e splat);
#   ranges e arrays;
#   funções anônimas;
#   imagens com Images.jl.

using Images

function Z(z::Complex, c::Complex)::Complex
    z^2 + c
end

function max_iterations(c::Complex, limit::Integer)::Integer
    z = 0 + 0im
    for i in 1:limit
        if abs(z) > 2
            return i
        end
        z = Z(z,c)
    end
    limit
end

function complex_plane(center::Complex, radius::Real, resolution::Real)::Matrix{<:Complex}
    scale           = 2 * radius / resolution
    range           = [-radius:scale:radius...]
    range_real      = range .+ center.re
    range_imaginary = range .+ center.im
    [i + j * im for j in range_real, i in range_imaginary]
end

mandelbrot_constructor(color_in::Color, color_out::Color, limit::Integer) = (c::Complex) -> binary_colorize(c::Complex, color_in::Color, color_out::Color, limit::Integer);

function binary_colorize(c::Complex, color_in::Color, color_out::Color, limit::Integer)::Color
    iteration = max_iterations(c, limit)
    if iteration == limit
        return color_in
    else
        return color_out
    end
end

function main()
    A = complex_plane(0im, 2, 1000)
    mandelbrot = mandelbrot_constructor(RGB(0,0,0), RGB(1,1,1), 500)
    img_mandelbrot = mandelbrot.(A)
    img_mandelbrot
    save((@__DIR__) * "\\binary.bmp", img_mandelbrot)
end

main()

@__DIR__