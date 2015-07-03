abstract HolidayCalendar

immutable BrazilBanking <: HolidayCalendar end
immutable UnitedStates <: HolidayCalendar end

type HolidayCalendarCache
	hc :: HolidayCalendar
	isbday_array :: Array{Bool,1}
	bdayscounter_array :: Array{UInt32,1}
	dtmin :: Date
	dtmax :: Date
end

# Accessor function for immutable list
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