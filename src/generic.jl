
mutable struct GenericCalendar <: HolidayCalendar
	holidays::Set{Date}
	cache::HolidayCalendarCache
end

Base.hash(g::GenericCalendar) = Base.hash(g.holidays)

function GenericCalendar(holidays::Set{Date}, _initcache_::Bool=true)
	generic_calendar = GenericCalendar(holidays, HolidayCalendarCache())
	generic_calendar.cache.hc = generic_calendar
	
	if _initcache_
		d0 = min(holidays...)
		d1 = max(holidays...)
		initcache!(generic_calendar.cache, d0, d1)
	end
end

@inline isholiday(cal::GenericCalendar, dt::Date) = in(dt, cal.holidays)
@inline _getcachestate(hc::GenericCalendar) = _getcachestate(hc.cache)
@inline _getholidaycalendarcache(hc::GenericCalendar) = hc.cache
