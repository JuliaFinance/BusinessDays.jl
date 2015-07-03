using Base.Dates
using BusinessDays
using Base.Test

d0 = Date(1900, 01, 01) ; d1 = Date(2100, 12, 20)

cal = BrazilBanking()
@time BusinessDays.initcache()
bdays(cal, d0, d1) # force JIT compilation
@time bdays(cal, d0, d1)
@time for i in 1:1000000 bdays(cal, d0, d1) end

# Results using Julia build cd8be58
# 346.774 milliseconds (779 k allocations: 31706 KB, 0.86% gc time)
#   4.694 microseconds (10 allocations: 240 bytes)
# 646.490 milliseconds (6000 k allocations: 93750 KB, 1.16% gc time)