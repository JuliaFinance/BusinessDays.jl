using Base.Dates
using BusinessDays
using Base.Test

print("Running perftests\n")

d0 = Date(1950, 01, 01) ; d1 = Date(2100, 12, 20)

cal = BrazilBanking()
@time BusinessDays.initcache(cal)
bdays(cal, d0, d1) # force JIT compilation
@time bdays(cal, d0, d1)
@time for i in 1:1000000 bdays(cal, d0, d1) end

# Results using Julia build 0503f2a
# 194.197 milliseconds (335 k allocations: 17000 KB, 7.00% gc time)
#   2.980 microseconds (9 allocations: 224 bytes)
# 568.525 milliseconds (5000 k allocations: 78125 KB, 0.89% gc time)