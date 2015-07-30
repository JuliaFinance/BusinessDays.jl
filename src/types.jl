abstract HolidayCalendar

immutable BrazilBanking <: HolidayCalendar end
immutable UnitedStates <: HolidayCalendar end
immutable UKEnglandBanking <: HolidayCalendar end

type HolidayCalendarCache
	hc::HolidayCalendar
	isbday_array::Vector{Bool}
	bdayscounter_array::Vector{UInt32}
	dtmin::Date
	dtmax::Date
end

# Accessor function for HolidayCalendar subtypes
function holidaycalendarlist()
	
	subs = subtypes(HolidayCalendar)
	len = length(subs)

	# Convert subtypes result array to specific type array
	calendars = Array(HolidayCalendar, len)
	
	for i in 1:len
		# creates one instance for each HolidayCalendar subtype
		calendars[i] = subs[i]()
	end
	
	return calendars
end

Base.string(hc::HolidayCalendar) = string(typeof(hc))