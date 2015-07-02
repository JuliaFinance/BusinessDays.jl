using Base.Dates
using BusinessDays
using Base.Test

d0 = Date(1900, 01, 01) ; d1 = Date(2100, 12, 20)

cal = BrazilBanking()
bdays(cal, d0, d1) # force JIT compilation
BusinessDays.initcache()
@time bdays(cal, d0, d1)
@time for i in 1:1000000 bdays(cal, d0, d1) end