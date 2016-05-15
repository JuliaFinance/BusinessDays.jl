
using Base.Dates
using BusinessDays
using Base.Test

bd = BusinessDays

println("Perftests")

d0 = Date(2015, 06, 29) ; d1 = Date(2100, 12, 20)

cal_type = bd.Brazil()
cal_sym = :Brazil
cal_str = "Brazil"

@time bd.initcache(cal_type)
bdays(cal_type, d0, d1) # force JIT compilation
@time bdays(cal_type, d0, d1)
@time for i in 1:1000000 bdays(cal_type, d0, d1) end

bdays(cal_sym, d0, d1) # force JIT compilation
bdays(cal_str, d0, d1) # force JIT compilation
@time for i in 1:1000000 bdays(cal_sym, d0, d1) end
@time for i in 1:1000000 bdays(cal_str, d0, d1) end

#=
Perftests
  0.010197 seconds (54.70 k allocations: 1.100 MB)
  0.000003 seconds (9 allocations: 240 bytes)
  0.464481 seconds (5.00 M allocations: 76.294 MB, 0.79% gc time)
=#

N = 1000
d0vec = fill(d0, N)
d1vec = fill(d1, N)
cal_type_vec = fill(cal_type, N)
cal_sym_vec = fill(cal_sym, N)
cal_str_vec = fill(cal_str, N)

# Warmup
bd.initcache(bd.Brazil())
bd.initcache("USSettlement")
bd.initcache(:UKSettlement)
bd.bdays(cal_type, d0, d1)
bd.bdays(cal_sym, d0, d1)
bd.bdays(cal_str, d0, d1)
bd.bdays(cal_type, d0vec, d1vec)
bd.bdays(cal_sym, d0vec, d1vec)
bd.bdays(cal_str, d0vec, d1vec)
bd.bdays(cal_type_vec, d0vec, d1vec)
bd.bdays(cal_sym_vec, d0vec, d1vec)
bd.bdays(cal_str_vec, d0vec, d1vec)

println("type")
@time for i in 1:1000 bd.bdays(cal_type, d0, d1) end
@time bd.bdays(cal_type, d0vec, d1vec)
@time bd.bdays(cal_type_vec, d0vec, d1vec)
println("sym")
@time for i in 1:1000 bd.bdays(cal_sym, d0, d1) end
@time bd.bdays(cal_sym, d0vec, d1vec)
@time bd.bdays(cal_sym_vec, d0vec, d1vec)
println("str")
@time for i in 1:1000 bd.bdays(cal_str, d0, d1) end
@time bd.bdays(cal_str, d0vec, d1vec)
@time bd.bdays(cal_str_vec, d0vec, d1vec)

bd.cleancache()

println("initcache type")
@time bd.initcache(cal_type)
bd.cleancache()

println("initcache sym")
@time bd.initcache(cal_sym)
bd.cleancache()

println("initcache str")
@time bd.initcache(cal_str)
bd.cleancache()
