
# Fallback implementation for isholiday()
function isholiday( hc :: HolidayCalendar, dt :: TimeType)
	error("isholiday for $(hc) not yet implemented.")
end

# BrazilBanking <: HolidayCalendar
# Brazilian Banking Holidays
function isholiday( :: BrazilBanking , dt :: TimeType)

	const yy = Dates.year(dt)
	const mm = Dates.month(dt)
	const dd = Dates.day(dt)

	const dt_rata = Dates.days(dt)

	# Regular holidays
	if (
			# Confraternizacao Universal
			((mm == 1) && (dd == 1))
			||
			# Tiradentes
			((mm == 4) && (dd == 21))
			||
			# Dia do Trabalho	
			((mm == 5) && (dd == 1))
			||
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

	# Holidays based on easter date
	const e_rata :: Int64 = easter_rata( Dates.Year(yy))

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

	return false
end

#= TODO
function isholiday( :: UnitedStates , dt :: TimeType)

	const yy = Dates.year(dt)
	const mm = Dates.month(dt)
	const dd = Dates.day(dt)

	const dt_rata = Dates.days(dt)

	# Regular holidays
	if (
			# New Year's Day
			((mm == 1) && (dd == 1))
			||
			# Tiradentes
			((mm == 4) && (dd == 21))
			||
			# Dia do Trabalho	
			((mm == 5) && (dd == 1))
			||
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

	reutrn false

end
=#
