doc"""
Allows for combination of several Holiday Calendars.
"""
type CompositeHolidayCalendar <: HolidayCalendar
	calendars::Vector{HolidayCalendar}
end

function isholiday(hc::CompositeHolidayCalendar, dt::Date)
	for c in hc.calendars
		if isholiday(c, dt)
			return true
		end
	end
	return false
end