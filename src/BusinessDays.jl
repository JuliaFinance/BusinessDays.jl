VERSION >= v"0.4.0-dev+6521" && __precompile__()

module BusinessDays

using Base.Dates

# types.jl
export
	# Module for HolidayCalendars.
	# Provided calendars: HolidayCalendars.BrazilBanking, HolidayCalendars.UnitedStates, HolidayCalendars.UKEnglandBanking
	HolidayCalendars,
	HolidayCalendar,
	CompositeHolidayCalendar

# easter.jl
export
	# Returns easter Date as a Rata Die number (Int64), Algo R http://www.linuxtopia.org/online_books/programming_books/python_programming/python_ch38.html
	# function easter_rata(y::Year)
	easter_rata,

	# Returns easter_rata as Dates.Date
	# function easter_date(y::Year)
	easter_date

# isholiday.jl
export
	# Implements holiday functions for various HolidayCalendar subtypes
	isholiday, findweekday

# bdayscache.jl : Cache routines for Business Days precalculated days
export
	initcache

# bdays.jl : main functions for BusinessDays module
export
	isweekend, isbday, tobday, advancebdays, bdays
	
include("types.jl")
include("easter.jl")
include("isholiday.jl")
include("bdayscache.jl")
include("bdays.jl")
include("bdaysvecfun.jl")
include("composite.jl")

end # module BusinessDays