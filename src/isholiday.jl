
"""
	isholiday(calendar, dt)

Checks if `dt` is a holiday based on a given `calendar` of holidays.

`calendar` can be an instance of `HolidayCalendar`,  a `Symbol` or an `AbstractString`.

Returns boolean values.
"""
function isholiday(hc::HolidayCalendar, dt::Date)
    error("isholiday for $(hc) not implemented.")
end

isholiday(::NullHolidayCalendar, dt::Date) = false
isholiday(calendar, dt::Date) = isholiday(convert(HolidayCalendar, calendar), dt)

include("calendars/brazil.jl")
include("calendars/uk.jl")
include("calendars/us.jl")
