

"""
A calendar with no holidays. But account for weekends.

`isholiday` always returns false for this calendar.
Remember that `isbday` considers that Saturdays and Sundars are not business days.
"""
struct WeekendsOnly <: HolidayCalendar end
isholiday(::WeekendsOnly, dt::Date) = false

"""
A calendar with no holidays and no weekends.
`bdays` returns the actual days between dates (`dt1 - d10`).
"""
struct NullHolidayCalendar <: HolidayCalendar end

isholiday(::NullHolidayCalendar, dt::Date) = false
isbday(::NullHolidayCalendar, dt::Date) = true
bdays(::NullHolidayCalendar, dt0::Date, dt1::Date) = dt1 - dt0

include("brazil.jl")
include("canada.jl")
include("target.jl")
include("uk.jl")
include("us.jl")
