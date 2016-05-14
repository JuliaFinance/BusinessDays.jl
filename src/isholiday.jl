
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

include("calendars/brazil.jl")
include("calendars/uk.jl")
include("calendars/us.jl")
