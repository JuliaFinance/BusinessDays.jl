using Base.Dates
using BusinessDays
using Base.Test

println("Perftests")

d0 = Date(2015, 06, 29) ; d1 = Date(2100, 12, 20)

cal = BrazilBanking()
@time BusinessDays.initcache(cal)
bdays(cal, d0, d1) # force JIT compilation
@time bdays(cal, d0, d1)
@time for i in 1:1000000 bdays(cal, d0, d1) end

#=
Perftests
  0.010197 seconds (54.70 k allocations: 1.100 MB)
  0.000003 seconds (9 allocations: 240 bytes)
  0.464481 seconds (5.00 M allocations: 76.294 MB, 0.79% gc time)
=#