
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
cleancache(cal::GenericCalendar) = cleancache!(cal.cache)
@inline needs_cache_update(hc::GenericCalendar, d0::Date, d1::Date) = _getcachestate(hc) && hc.cache.dtmin == d0 && hc.cache.dtmax == d1
@inline initcache(hc::GenericCalendar, d0::Date=DEFAULT_CACHE_D0, d1::Date=DEFAULT_CACHE_D1) = initcache!(hc.cache, d0, d1)
