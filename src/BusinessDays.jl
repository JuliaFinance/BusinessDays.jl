
VERSION >= v"0.4.0-dev+6521" && __precompile__()

module BusinessDays

using Base.Dates

# types.jl
export
	HolidayCalendar,
	CompositeHolidayCalendar

# isholiday.jl
export
	isholiday

# bdays.jl : main functions for BusinessDays module
export
	isweekend,
	isbday,
	tobday,
	advancebdays,
	bdays,
	listholidays

include("dateutils.jl")
include("types.jl")
include("isholiday.jl")
include("bdayscache.jl")
include("bdays.jl")
include("bdaysvecfun.jl")
include("composite.jl")

end # module BusinessDays
