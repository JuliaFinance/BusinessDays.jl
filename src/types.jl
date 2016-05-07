
doc"""
*Abstract* type for Holiday Calendars.
"""
abstract HolidayCalendar

doc"""
Data structure for calendar cache.
"""
type HolidayCalendarCache
	hc::HolidayCalendar
	isbday_array::Vector{Bool}
	bdayscounter_array::Vector{UInt32}
	dtmin::Date
	dtmax::Date
end

Base.string(hc::HolidayCalendar) = string(typeof(hc))

#####################################
## CONCRETE CALENDAR IMPLEMENTATIONS
#####################################
type Brazil <: HolidayCalendar end
type USSettlement <: HolidayCalendar end
type UKSettlement <: HolidayCalendar end
