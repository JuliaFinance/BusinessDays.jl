using Base.Dates
using BusinessDays
using Base.Test

d0 = Date(2015, 06, 29) ; d1 = Date(2100, 12, 20)

cal = BrazilBanking()
@time BusinessDays.initcache(cal)
bdays(cal, d0, d1) # force JIT compilation
@time bdays(cal, d0, d1)
@time for i in 1:1000000 bdays(cal, d0, d1) end

# Results using Julia build e2b76ad
# 169.562 milliseconds (321 k allocations: 16803 KB, 2.11% gc time)
#   2.755 microseconds (9 allocations: 224 bytes)
# 444.661 milliseconds (5000 k allocations: 78125 KB, 1.16% gc time)