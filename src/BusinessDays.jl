
VERSION >= v"0.4.0-dev+6521" && __precompile__()

module BusinessDays

using Base.Dates

# types.jl
export
	# Module for HolidayCalendars.
	# Provided calendars: HolidayCalendars.BrazilBanking, HolidayCalendars.UnitedStates, HolidayCalendars.UKEnglandBanking
	HolidayCalendar,
	CompositeHolidayCalendar

# isholiday.jl
export
	# Implements holiday functions for various HolidayCalendar subtypes
	isholiday

# bdays.jl : main functions for BusinessDays module
export
	isweekend,
	isbday,
	tobday,
	advancebdays,
	bdays,
	listholidays
	
include("types.jl")
include("easter.jl")
include("isholiday.jl")
include("bdayscache.jl")
include("bdays.jl")
include("bdaysvecfun.jl")
include("composite.jl")

end # module BusinessDays
