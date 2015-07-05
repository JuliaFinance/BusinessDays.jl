using Base.Dates
using BusinessDays
using Base.Test

d0 = Date(1950, 01, 01) ; d1 = Date(2100, 12, 20)

cal = BrazilBanking()
@time BusinessDays.initcache(cal)
bdays(cal, d0, d1) # force JIT compilation
@time bdays(cal, d0, d1)
@time for i in 1:1000000 bdays(cal, d0, d1) end

# Results using Julia build cd8be58
# 213.920 milliseconds (558 k allocations: 21699 KB, 9.37% gc time)
#   4.881 microseconds (10 allocations: 240 bytes)
# 610.743 milliseconds (6000 k allocations: 93750 KB, 0.84% gc time)