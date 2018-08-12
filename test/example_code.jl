
using BusinessDays, Dates

d0 = Date(2015, 06, 29) ; d1 = Date(2100, 12, 20)

cal = BusinessDays.Brazil()
@time BusinessDays.initcache(cal)
bdays(cal, d0, d1) # force JIT compilation
@time bdays(cal, d0, d1)
@time for i in 1:1000000 bdays(cal, d0, d1) end
