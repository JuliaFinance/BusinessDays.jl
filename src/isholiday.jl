
# Fallback implementation for isholiday()
doc"""
Returns `true` if `dt` is a holiday.
Returns `false` otherwise.
"""
function isholiday(hc::HolidayCalendar, dt::Date)
	error("isholiday for $(hc) not yet implemented.")
end

isholiday(::NullHolidayCalendar, dt::Date) = false
isholiday(calendar, dt::Date) = isholiday(convert(HolidayCalendar, calendar), dt)

# BrazilBanking <: HolidayCalendar
# Brazilian Banking Holidays
function isholiday(::Brazil, dt::Date)

	const yy = Dates.year(dt)
	const mm = Dates.month(dt)
	const dd = Dates.day(dt)

	# Bisection
	if mm >= 8
		# Fixed holidays
		if (
				# Independencia do Brasil
				((mm == 9) && (dd == 7))
				||
				# Nossa Senhora Aparecida
				((mm == 10) && (dd == 12))
				||
				# Finados
				((mm == 11) && (dd == 2))
				||
				# Proclamacao da Republica
				((mm == 11) && (dd == 15))
				||
				# Natal
				((mm == 12) && (dd == 25))
			)
			return true
		end	
	else
		# mm < 8
		# Fixed holidays
		if (
				# Confraternizacao Universal
				((mm == 1) && (dd == 1))
				||
				# Tiradentes
				((mm == 4) && (dd == 21))
				||
				# Dia do Trabalho	
				((mm == 5) && (dd == 1))
			)
			return true
		end

		# Easter occurs up to April, so Corpus Christi will be up to July in the worst case, which is before August (mm < 8). See test/easter-min-max.jl .
		# Holidays based on easter date
		const dt_rata::Int64 = Dates.days(dt)
		const e_rata::Int64 = easter_rata(Dates.Year(yy))

		if (
				# Segunda de Carnaval
				(  dt_rata == (  e_rata - 48  )   )
				||
				# Terca de Carnaval
				( dt_rata == (  e_rata - 47 )     )
				||
				# Sexta-feira Santa
				( dt_rata == ( e_rata - 2 )       )
				||
				# Corpus Christi
				( dt_rata == ( e_rata + 60)       )
			)
			return true
		end
	end

	return false
end

# In the United States, if a holiday falls on Saturday, it's observed on the preceding Friday.
# If it falls on Sunday, it's observed on the next Monday.
function adjustweekendholidayUS(dt::Date)
	
	if dayofweek(dt) == Dates.Saturday
		return dt - Dates.Day(1)
	end

	if dayofweek(dt) == Dates.Sunday
		return dt + Dates.Day(1)
	end

	return dt
end

function isholiday(::USSettlement , dt::Date)

	const dt_Date = convert(Dates.Date, dt)

	const yy = Dates.year(dt)
	const mm = Dates.month(dt)
	const dd = Dates.day(dt)

	const dt_rata = Dates.days(dt)

	if (
			# New Year's Day
			adjustweekendholidayUS(Date(yy, 1, 1)) == dt_Date
			||
			# New Year's Day on the previous year when 1st Jan is Saturday
			(mm == 12 &&  dd == 31 && dayofweek(dt_Date) == Friday)
			||
			# Birthday of Martin Luther King, Jr.
			adjustweekendholidayUS(findweekday(Dates.Monday, yy, 1, 3, true)) == dt_Date
			||
			# Washington's Birthday
			adjustweekendholidayUS(findweekday(Dates.Monday, yy, 2, 3, true)) == dt_Date
			||
			# Memorial Day
			adjustweekendholidayUS(findweekday(Dates.Monday, yy, 5, 1, false)) == dt_Date
			||
			# Independence Day
			adjustweekendholidayUS(Date(yy, 7, 4)) == dt_Date
			||
			# Labor Day
			adjustweekendholidayUS(findweekday(Dates.Monday, yy, 9, 1, true)) == dt_Date
			||
			# Columbus Day
			adjustweekendholidayUS(findweekday(Dates.Monday, yy, 10, 2, true)) == dt_Date
			||
			# Veterans Day
			adjustweekendholidayUS(Date(yy, 11, 11)) == dt_Date
			||
			# Thanksgiving Day
			adjustweekendholidayUS(findweekday(Dates.Thursday, yy, 11, 4, true)) == dt_Date
			||
			# Christmas
			adjustweekendholidayUS(Date(yy, 12, 25)) == dt_Date
		)
		return true
	end
	
	return false
end

# In the UK, if a holiday falls on Saturday or Sunday, it's observed on the next business day.
# This function will adjust to the next Monday.
function adjustweekendholidayUK(dt::Date)
	
	if dayofweek(dt) == Dates.Saturday
		return dt + Dates.Day(2)
	end

	if dayofweek(dt) == Dates.Sunday
		return dt + Dates.Day(1)
	end

	return dt
end

# England and Wales Banking Holidays
function isholiday(::UKSettlement, dt::Date)

	const dt_Date = convert(Dates.Date, dt)

	const yy = Dates.year(dt)
	const mm = Dates.month(dt)
	const dd = Dates.day(dt)

	# Bisection
	if mm >= 8
		# Fixed holidays
		if (
				# Late Summer Bank Holiday, August Bank Holiday
				adjustweekendholidayUK(  findweekday(Dates.Monday, yy, 8, 1, false) ) == dt_Date
				||
				# Christmas
				adjustweekendholidayUK( Date(yy, 12, 25) ) == dt_Date
				||
				# Boxing
				adjustweekendholidayUK(adjustweekendholidayUK( Date(yy, 12, 25) ) + Dates.Day(1)) == dt_Date 
			)
			return true
		end

		# Fixed date holidays with mm >= 8
		if dt_Date == Date(1999, 12, 31)
			return true
		end

	else
		# mm < 8
		# Fixed holidays
		if (
				# New Year's Day
				adjustweekendholidayUK(  Date(yy, 01, 01) ) == dt_Date
				||
				# May Day, Early May Bank Holiday
				adjustweekendholidayUK(findweekday(Dates.Monday, yy, 5, 1, true)) == dt_Date
				||
				# Spring Bank Holiday
				(adjustweekendholidayUK(findweekday(Dates.Monday, yy, 5, 1, false)) == dt_Date && yy != 2012 && yy != 2002)
			)
			return true
		end

		# Easter occurs up to April, which is before August (mm < 8). See test/easter-min-max.jl .
		# Holidays based on easter date
		const dt_rata::Int64 = Dates.days(dt)
		const e_rata::Int64 = easter_rata(Dates.Year(yy))

		if (
				# Good Friday
				( dt_rata == ( e_rata - 2 ) )
				||
				# Easter Monday
				( dt_rata == ( e_rata + 1)  )
			)
			return true
		end

			# Fixed date holidays with mm < 8
		if ( 
			# Substitute date for Spring Bank Holiday
			(dt_Date == Date(2012, 06, 04))
			||
			# Diamond Jubilee of Queen Elizabeth II.
			(dt_Date == Date(2012, 06, 05))
			||
			# Golden Jubilee of Queen Elizabeth II.
			(dt_Date == Date(2002, 06, 03))
			||
			# Substitute date for Spring Bank Holiday
			(dt_Date == Date(2002, 06, 04))
			||
			# Wedding of Prince William and Catherine Middleton
			(dt_Date == Date(2011, 04, 29))
			)
			return true
		end
	end

	return false
end
