
using Base.Dates
using BusinessDays
using DataFrames

bd = BusinessDays

hc_vec = [:BRSettlement, :USSettlement, :USNYSE, , :USGovernmentBond, :UKSettlement, :CanadaSettlement, :CanadaTSX ]

d0 = Date(1960,01,04)
d1 = Date(2100,01,04)
bd.initcache(hc_vec, d0, d1)

d1vec = collect(d0:d1)
d0vec = fill(d0, length(d1vec))

for hc in hc_vec0
	b = convert(Array{Int, 1}, isbday(hc, d1vec))
	writetable(string("csv/julia-isbday-", string(hc), ".csv"), DataFrame(D = d1vec, ISBDAY = b), quotemark = ' ')
end
