doc"""
*Abstract* type for Holiday Calendars.
"""

abstract HolidayCalendar

doc"""
Data structure for calendar cache. See 
"""
type HolidayCalendarCache
	hc::HolidayCalendar
	isbday_array::Vector{Bool}
	bdayscounter_array::Vector{UInt32}
	dtmin::Date
	dtmax::Date
end

Base.string(hc::HolidayCalendar) = string(typeof(hc))

module HolidayCalendars

import ..HolidayCalendar

type BrazilBanking <: HolidayCalendar end
type UnitedStates <: HolidayCalendar end
type UKEnglandBanking <: HolidayCalendar end

end # module HolidayCalendars
