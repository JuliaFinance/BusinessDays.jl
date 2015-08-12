
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