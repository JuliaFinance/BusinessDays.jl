
using Base.Test

# sum all elements of 2 vectors, quick code
sum2V(x, y) = sum(x) + sum(y)

# sum all elements of 2 vectors, especialized code
function sum2V_2(x::Vector{Float64}, y::Vector{Float64})

  const lx = length(x)
  const ly = length(y)
  
  if lx != ly
    error("x y must have equal sizes")
  end
  
  r = 0.0
  for i = 1:lx
    r += x[i] + y[i]
  end
  
  return r
end

x = rand(convert(Int, 1e7))
y = rand(convert(Int, 1e7))

r1 = sum2V(x, y)
r2 = sum2V_2(x, y)

@test_approx_eq r1 r2

@time r1 = sum2V(x, y)
@time r2 = sum2V_2(x, y)

# Results
#julia> include("dummy-test.jl")
#  12.409 milliseconds (157 allocations: 26956 bytes)
#  12.915 milliseconds (5 allocations: 176 bytes)
