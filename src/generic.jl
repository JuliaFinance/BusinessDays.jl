
mutable struct HolidayCalendarSet <: HolidayCalendar
	holidays::Set{Date}
	cache::HolidayCalendarCache
end
