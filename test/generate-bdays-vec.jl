using Base.Dates
using BusinessDays

hc = BrazilBanking()

initcache(hc)

d0 = Date(2000,01,04)
d1 = Date(2020,01,04)

d1vec = convert(Array{Date,1}, d0:d1)
d0vec = fill(d0, length(d1vec))

r = bdays(hc, d0vec, d1vec)