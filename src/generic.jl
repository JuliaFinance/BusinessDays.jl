
"""
    GenericHolidayCalendar

* `holidays`: a set of holiday dates
* `dtmin`: minimum date allowed to check for holidays in holidays set. Defaults to `min(holidays...)`.
* `dtmax`: maximum date allowed to check for holidays in holidays set. Defaults to `max(holidays...)`.
* `cache`: instance of HolidayCalendarCache.
"""
mutable struct GenericHolidayCalendar <: HolidayCalendar
    holidays::Set{Dates.Date}
    dtmin::Dates.Date
    dtmax::Dates.Date
    cache::HolidayCalendarCache
end

Base.:(==)(g1::GenericHolidayCalendar, g2::GenericHolidayCalendar) = g1.holidays == g2.holidays && g1.dtmin == g2.dtmin && g1.dtmax == g2.dtmax
Base.hash(g::GenericHolidayCalendar) = hash(g.holidays) + hash(g.dtmin) + hash(g.dtmax)

"""
    GenericHolidayCalendar(holidays, [dtmin], [dtmax], [_initcache_])

* `holidays`: a set of holiday dates
* `dtmin`: minimum date allowed to check for holidays in holidays set. Defaults to `min(holidays...)`.
* `dtmax`: maximum date allowed to check for holidays in holidays set. Defaults to `max(holidays...)`.
* `_initcache_`: initializes the cache for this calendar. Defaults to `true`.
"""
function GenericHolidayCalendar(holidays::Set{Dates.Date}, dtmin::Dates.Date=min(holidays...), dtmax::Dates.Date=max(holidays...), _initcache_::Bool=true)
    generic_calendar = GenericHolidayCalendar(holidays, dtmin, dtmax, HolidayCalendarCache())
    generic_calendar.cache.hc = generic_calendar

    if _initcache_
        initcache!(generic_calendar.cache, generic_calendar, dtmin, dtmax)
    end
    return generic_calendar
end

GenericHolidayCalendar(holidays::Vector{Dates.Date}, d0::Dates.Date=min(holidays...), d1::Dates.Date=max(holidays...), _initcache_::Bool=true) = GenericHolidayCalendar(Set(holidays), d0, d1, _initcache_)

@inline checkbounds(cal::GenericHolidayCalendar, dt::Dates.Date) = @assert cal.dtmin <= dt && dt <= cal.dtmax "Date out of calendar bounds: $dt. Allowed dates interval is from $(cal.dtmin) to $(cal.dtmax)."

function isholiday(cal::GenericHolidayCalendar, dt::Dates.Date)
    checkbounds(cal, dt)
    return in(dt, cal.holidays)
end

@inline _getcachestate(hc::GenericHolidayCalendar) = _getcachestate(hc.cache)
@inline _getholidaycalendarcache(hc::GenericHolidayCalendar) = hc.cache
@inline cleancache(cal::GenericHolidayCalendar) = cleancache!(cal.cache)
@inline needs_cache_update(hc::GenericHolidayCalendar, d0::Dates.Date, d1::Dates.Date) = _getcachestate(hc) && hc.cache.dtmin == d0 && hc.cache.dtmax == d1

function initcache(hc::GenericHolidayCalendar, d0::Dates.Date=hc.dtmin, d1::Dates.Date=hc.dtmax)
    checkbounds(hc, d0)
    checkbounds(hc, d1)
    initcache!(hc.cache, hc, d0, d1)
end
