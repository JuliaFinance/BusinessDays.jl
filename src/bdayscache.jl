#
# Cache routines for Business Days precalculated days
#

"""
Holds caches for Holiday Calendars.

* Key = `HolidayCalendar` instance
* Value = instance of `HolidayCalendarCache`
"""
global _CACHE_DICT = Dict{HolidayCalendar, HolidayCalendarCache}()

function _getcachestate(hc::HolidayCalendar)
    return haskey(_CACHE_DICT, hc)
end

function _getholidaycalendarcache(hc::HolidayCalendar)
    return _CACHE_DICT[hc]
end

function checkbounds(hcc::HolidayCalendarCache, dt::Date)
    if !((hcc.dtmin <= dt) && (dt <= hcc.dtmax))
        error("Date out of cache bounds. Use initcache function with a wider time spread. Provided date: $(dt).")
    end
end

function _linenumber(hcc::HolidayCalendarCache, dt::Date)
    return Dates.days(dt) - Dates.days(hcc.dtmin) + 1
end

function isbday(hcc::HolidayCalendarCache, dt::Date)
    checkbounds(hcc, dt)
    return hcc.isbday_array[ _linenumber(hcc, dt) ]
end

function bdays(hcc::HolidayCalendarCache, dt0::Date, dt1::Date)
    # Computation is always based on next Business Days if given dates are not Business Days, inspired by Banking Account convention.
    dt0 = tobday(hcc.hc, dt0) # cache bounds are checked inside tobday -> isbday
    dt1 = tobday(hcc.hc, dt1) # cache bounds are checked inside tobday -> isbday
    
    return Day(convert(Int, hcc.bdayscounter_array[_linenumber(hcc, dt1)]) - convert(Int, hcc.bdayscounter_array[_linenumber(hcc, dt0)]))
end

# Be sure to use this function on a syncronized code (not multithreaded).
"""
    initcache(calendar, [d0], [d1])

Creates cache for a given Holiday Calendar. After calling this function, any call to `isbday`
function, or any function that uses `isbday`, will be optimized to use this cache.

You can pass `calendar` as an instance of `HolidayCalendar`, `Symbol` or `AbstractString`.
You can also pass `calendar` as an `AbstractArray` of those types.
"""
function initcache(hc::HolidayCalendar, d0::Date, d1::Date)
    isbday_array , bdayscounter_array = _createbdayscache(hc, d0, d1)
    _CACHE_DICT[hc] = HolidayCalendarCache(hc, isbday_array, bdayscounter_array, min(d0, d1), max(d0, d1))
end

initcache(calendar, d0::Date, d1::Date) = initcache(convert(HolidayCalendar, calendar), d0, d1)

# Defaults to d0 = 1st Jan 1980 , d1 = 20th dec 2150
function initcache(hc::HolidayCalendar)
    initcache(hc, Date(1980, 01, 01), Date(2150, 12, 20))
end

initcache(calendar) = initcache(convert(HolidayCalendar,calendar))
initcache{A<:AbstractArray}(calendars::A) = initcache(convert(Vector{HolidayCalendar}, calendars))

@vectorize_1arg HolidayCalendar initcache

# remove all elements from cache
function cleancache()
    for k in keys(_CACHE_DICT)
        delete!(_CACHE_DICT, k)
    end
end

"""
    cleancache([calendar])

Cleans cache for a given instance or list of `HolidayCalendar`, `Symbol` or `AbstractString`.
"""
function cleancache(hc::HolidayCalendar)
    if haskey(_CACHE_DICT, hc)
        delete!(_CACHE_DICT, hc)
    end
end

function cleancache(hc_vec::Vector{HolidayCalendar})
    for k in hc_vec
        if k in keys(_CACHE_DICT)
            delete!(_CACHE_DICT, k)
        end
    end
end

cleancache(calendar) = cleancache(convert(HolidayCalendar, calendar))
cleancache{A<:AbstractArray}(calendars::A) = cleancache(convert(Vector{HolidayCalendar}, calendars))

# Returns tuple
# tuple[1] = Array of Bool (isBday) , tuple[2] = Array of UInt32 (bdaycounter)
function _createbdayscache(hc::HolidayCalendar, d0::Date, d1::Date)

    const d0_ = min(d0, d1)
    const d1_ = max(d0, d1)

    const d0_rata = Dates.days(d0_)
    const d1_rata = Dates.days(d1_)
    
    # length of the cache arrays
    const len::Int = d1_rata - d0_rata + 1

    # This function uses UInt32 to store bdayscounter array
    # We need to check if we'll exceed typemax(UInt32)
    if len > convert(Int, typemax(UInt32))
        error("Maximum size allowed for bdays array is $(typemax(UInt32)). Required lenght of $(len).")
    end

    isbday_array = zeros(Bool, len)
    bdayscounter_array = zeros(UInt32, len)

    isbday_array[1] = isbday(hc, d0_)
    bdayscounter_array[1] = 0

    for i in 2:len
        isbday_array[i] = isbday(hc, d0_ + Dates.Day(i-1))
        bdayscounter_array[i] = bdayscounter_array[i-1] + isbday_array[i]
    end

    return isbday_array, bdayscounter_array
end
