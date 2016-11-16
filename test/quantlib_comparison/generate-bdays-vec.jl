
using Base.Dates
using BusinessDays
using DataFrames

bd = BusinessDays

d0 = Date(1960,01,04)
d1 = Date(2100,01,04)

d1vec = collect(d0:d1)
d0vec = fill(d0, length(d1vec))

for hc in [:BRSettlement, :UKSettlement, :USGovernmentBond, :USNYSE, :USSettlement]
	bd.initcache(hc, d0, d1)
	#b = convert(Array{Int,1}, bdays(hc, d0vec, d1vec))
	#writetable(string("csv/julia-bdays-", string(hc), ".csv"), DataFrame(D0 = d0vec, D1 = d1vec, BDAYS = b), quotemark = ' ')

	b = convert(Array{Int, 1}, isbday(hc, d1vec))
	writetable(string("csv/julia-isbday-", string(hc), ".csv"), DataFrame(D = d1vec, ISBDAY = b), quotemark = ' ')
end
