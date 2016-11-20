#
# Cache routines for Business Days precalculated days
#

"""
Holds caches for Holiday Calendars.

* Key = `HolidayCalendar` instance
* Value = instance of `HolidayCalendarCache`
"""
const _CACHE_DICT = Dict{HolidayCalendar, HolidayCalendarCache}()

const DEFAULT_CACHE_D0 = Date(1980, 01, 01)
const DEFAULT_CACHE_D1 = Date(2150, 12, 20)

function _getcachestate(hc::HolidayCalendar)
    return haskey(_CACHE_DICT, hc)
end

function _getholidaycalendarcache(hc::HolidayCalendar)
    return _CACHE_DICT[hc]
end

checkbounds(hcc::HolidayCalendarCache, dt::Date) = @assert (hcc.dtmin <= dt) && (dt <= hcc.dtmax) "Date out of cache bounds. Use initcache function with a wider time spread. Provided date: $(dt)."

_linenumber(hcc::HolidayCalendarCache, dt::Date) = Dates.days(dt) - Dates.days(hcc.dtmin) + 1

function isbday(hcc::HolidayCalendarCache, dt::Date)
    checkbounds(hcc, dt)
    return hcc.isbday_array[ _linenumber(hcc, dt) ]
end

function bdays(hcc::HolidayCalendarCache, dt0::Date, dt1::Date)
    # Computation is always based on next Business Days if given dates are not Business Days, inspired by Banking Account convention.
    const dt0_tobday = tobday(hcc.hc, dt0) # cache bounds are checked inside tobday -> isbday
    const dt1_tobday = tobday(hcc.hc, dt1) # cache bounds are checked inside tobday -> isbday
    
    return Day(convert(Int, hcc.bdayscounter_array[_linenumber(hcc, dt1_tobday)]) - convert(Int, hcc.bdayscounter_array[_linenumber(hcc, dt0_tobday)]))
end

# Be sure to use this function on a syncronized code (not multithreaded).
"""
    initcache(calendar, [d0], [d1])

Creates cache for a given Holiday Calendar. After calling this function, any call to `isbday`
function, or any function that uses `isbday`, will be optimized to use this cache.

You can pass `calendar` as an instance of `HolidayCalendar`, `Symbol` or `AbstractString`.
You can also pass `calendar` as an `AbstractArray` of those types.
"""
function initcache(hc::HolidayCalendar, d0::Date=DEFAULT_CACHE_D0, d1::Date=DEFAULT_CACHE_D1)
    isbday_array , bdayscounter_array = _createbdayscache(hc, d0, d1)
    _CACHE_DICT[hc] = HolidayCalendarCache(hc, isbday_array, bdayscounter_array, min(d0, d1), max(d0, d1))
end

function initcache(hc_vec::Vector{HolidayCalendar}, d0::Date=DEFAULT_CACHE_D0, d1::Date=DEFAULT_CACHE_D1)
    for hc in hc_vec
        initcache(hc, d0, d1)
    end
end

initcache{A<:AbstractArray}(calendars::A, d0::Date=DEFAULT_CACHE_D0, d1::Date=DEFAULT_CACHE_D1) = initcache(convert(Vector{HolidayCalendar}, calendars), d0, d1)
initcache(calendar, d0::Date=DEFAULT_CACHE_D0, d1::Date=DEFAULT_CACHE_D1) = initcache(convert(HolidayCalendar, calendar), d0, d1)

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
    if len > typemax(UInt32)
        error("Maximum size allowed for bdays cache array is $(typemax(UInt32)). The required lenght was $(len).")
    end

    isbday_array = Array(Bool, len)
    bdayscounter_array = Array(UInt32, len)

    @inbounds isbday_array[1] = isbday(hc, d0_)
    @inbounds bdayscounter_array[1] = 0

    for i in 2:len
        @inbounds isbday_array[i] = isbday(hc, d0_ + Dates.Day(i-1))
        @inbounds bdayscounter_array[i] = bdayscounter_array[i-1] + isbday_array[i]
    end

    return isbday_array, bdayscounter_array
end
