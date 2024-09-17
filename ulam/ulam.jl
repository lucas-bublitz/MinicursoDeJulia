
using Images
using Primes

function turtle(n::Int, rule::Function)
    A_type = Base.return_types(rule, (Int,))[1]
    A = Matrix{A_type}(undef,2n+1, 2n+1)
    directions = [(-1,0) (0,-1) (1,0) (0,1)]
    counter = 1
    position = (n+1,n+1)
    A[position[1],position[2]] = rule(counter)
    step = 2
    for i in 1:n
        position = position .+ (1,1)
        for direction in directions
            for k in 1:step
                counter += 1
                position = position .+ direction
                A[position[1],position[2]] = rule(counter)
            end
        end
        step += 2
    end
    A
end

function boolcolor(x::Bool)::Color
    x ? RGB(0,0,0) : RGB(1,1,1)
end

function rule(i::Int, j::Int)::Function
    x -> isprime(j*x+i) ? RGB(0,0,0) : RGB(1,1,1)
end

function square(i::Int)
   h -> h |> x->x/i |> isinteger |> boolcolor
end

function eulerlucky(i::Int)
    x -> isprime(x^2+x+2i+1) |> boolcolor
end

triangle = x -> (sqrt(1+sqrt(x))) |> isinteger |> boolcolor


A = turtle(200, rule(0,1))
b = primes(40)
for i in b, j in 1:i-1
    A = cat(A, turtle(200, rule(j,i)), dims=3)
    println(i)
end
save((@__DIR__) * "\\rule.gif", A)

primes(50)
