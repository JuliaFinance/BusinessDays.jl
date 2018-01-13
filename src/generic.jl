
mutable struct GenericHolidayCalendar <: HolidayCalendar
	holidays::Set{Date}
	cache::HolidayCalendarCache
end

Base.hash(g::GenericHolidayCalendar) = Base.hash(g.holidays)

function GenericHolidayCalendar(holidays::Set{Date}, _initcache_::Bool=true)
	generic_calendar = GenericHolidayCalendar(holidays, HolidayCalendarCache())
	generic_calendar.cache.hc = generic_calendar
	
	if _initcache_
		d0 = min(holidays...)
		d1 = max(holidays...)
		initcache!(generic_calendar.cache, generic_calendar, d0, d1)
	end
	return generic_calendar
end

GenericHolidayCalendar(holidays::Vector{Date}, _initcache_::Bool=true) = GenericHolidayCalendar(Set(holidays), _initcache_)

@inline isholiday(cal::GenericHolidayCalendar, dt::Date) = in(dt, cal.holidays)
@inline _getcachestate(hc::GenericHolidayCalendar) = _getcachestate(hc.cache)
@inline _getholidaycalendarcache(hc::GenericHolidayCalendar) = hc.cache
@inline cleancache(cal::GenericHolidayCalendar) = cleancache!(cal.cache)
@inline needs_cache_update(hc::GenericHolidayCalendar, d0::Date, d1::Date) = _getcachestate(hc) && hc.cache.dtmin == d0 && hc.cache.dtmax == d1
@inline initcache(hc::GenericHolidayCalendar, d0::Date=DEFAULT_CACHE_D0, d1::Date=DEFAULT_CACHE_D1) = initcache!(hc.cache, hc, d0, d1)
