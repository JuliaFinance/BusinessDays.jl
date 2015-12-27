doc"""
You can add your custom Holiday Calendar by doing the following:

1. Define a subtype of `HolidayCalendar`.
2. Implement a new method for `isholiday` for your calendar.

**Example Code**

```
using BusinessDays
import BusinessDays.isholiday

type CustomCalendar <: HolidayCalendar end
isholiday(::CustomCalendar, dt::Date) = dt == Date(2015,8,27)

cc = CustomCalendar()
println("$(isholiday(cc, Date(2015,8,26)))")
println("$(isholiday(cc, Date(2015,8,27)))")
```
"""
type CompositeHolidayCalendar <: HolidayCalendar
	calendars::Vector{HolidayCalendar}
end

hash(hc::CompositeHolidayCalendar) = sum(hash(hc.calendars))

function isholiday(hc::CompositeHolidayCalendar, dt::Date)
	for c in hc.calendars
		if isholiday(c, dt)
			return true
		end
	end
	return false
end