
using BusinessDays
using Test
import Dates

println("Perftests")

d0 = Dates.Date(2015, 06, 29) ; d1 = Dates.Date(2100, 12, 20)

cal_type = BusinessDays.Brazil()
cal_sym = :Brazil
cal_str = "Brazil"

@time BusinessDays.initcache(cal_type)
bdays(cal_type, d0, d1) # force JIT compilation
@time bdays(cal_type, d0, d1)
@time for i in 1:1000 bdays(cal_type, d0, d1) end
bdays(cal_sym, d0, d1) # force JIT compilation
bdays(cal_str, d0, d1) # force JIT compilation
@time for i in 1:1000 bdays(cal_sym, d0, d1) end
@time for i in 1:1000 bdays(cal_str, d0, d1) end

N = 1000
d0vec = fill(d0, N)
d1vec = fill(d1, N)
cal_type_vec = fill(cal_type, N)
cal_sym_vec = fill(cal_sym, N)
cal_str_vec = fill(cal_str, N)

# Warmup
BusinessDays.initcache(BusinessDays.Brazil())
BusinessDays.initcache("USSettlement")
BusinessDays.initcache(:UKSettlement)
BusinessDays.bdays(cal_type, d0, d1)
BusinessDays.bdays(cal_sym, d0, d1)
BusinessDays.bdays(cal_str, d0, d1)
BusinessDays.bdays(cal_type, d0vec, d1vec)
BusinessDays.bdays(cal_sym, d0vec, d1vec)
BusinessDays.bdays(cal_str, d0vec, d1vec)
BusinessDays.bdays(cal_type_vec, d0vec, d1vec)
BusinessDays.bdays(cal_sym_vec, d0vec, d1vec)
BusinessDays.bdays(cal_str_vec, d0vec, d1vec)

println("type")
@time for i in 1:1000 BusinessDays.bdays(cal_type, d0, d1) end
@time BusinessDays.bdays(cal_type, d0vec, d1vec)
@time BusinessDays.bdays(cal_type_vec, d0vec, d1vec)
println("sym")
@time for i in 1:1000 BusinessDays.bdays(cal_sym, d0, d1) end
@time BusinessDays.bdays(cal_sym, d0vec, d1vec)
@time BusinessDays.bdays(cal_sym_vec, d0vec, d1vec)
println("str")
@time for i in 1:1000 BusinessDays.bdays(cal_str, d0, d1) end
@time BusinessDays.bdays(cal_str, d0vec, d1vec)
@time BusinessDays.bdays(cal_str_vec, d0vec, d1vec)

BusinessDays.cleancache()

println("initcache type")
@time BusinessDays.initcache(cal_type)
BusinessDays.cleancache()

println("initcache sym")
@time BusinessDays.initcache(cal_sym)
BusinessDays.cleancache()

println("initcache str")
@time BusinessDays.initcache(cal_str)
BusinessDays.cleancache()
