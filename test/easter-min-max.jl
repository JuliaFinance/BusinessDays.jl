using Base.Dates
using BusinessDays
using Base.Test

# lets find out minimum and maximum month for easter
y = 1582
easter_1582 = easter_date(Year(1582))
month_min = month(easter_1582)
date_min = easter_1582
month_max = month(easter_1582)
date_max = easter_1582

while y <= 2100
	e_date = easter_date(Year(y))
	m_e_date = month(e_date)
	month_min = min(month_min, m_e_date)
	month_max = max(month_max, m_e_date)

	if month_min == m_e_date
		date_min = e_date
	end

	if month_max == m_e_date
		date_max = e_date
	end

	y += 1
end

print("easter minimum month is $(month_min) on date $(date_min) \neaster maximum month is $(month_max) on date $(date_max)\n")

@test month_min >= 3
@test month_max <= 4