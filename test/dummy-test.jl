# sum all elements of 2 vectors, quick code
function sum2V(x, y)
	sum(x) + sum(y)
end

# sum all elements of 2 vectors, especialized code
function sum2V_2(x::Array{Float64, 1}, y::Array{Float64, 1})

  const lx = length(x)
  const ly = length(y)
  
  if lx != ly
    error("x y must have equal sizes")
  end
  
  r::Float64 = 0
  for i = 1:lx
    r += x[i] + y[i]
  end
  
  return r
end

#=
x = rand(convert(Int, 1e7))
y = rand(convert(Int, 1e7))

r1 = sum2V(x, y)
r2 = sum2V_2(x, y)

@time sum2V(x, y)
@time sum2V_2(x, y)
=#