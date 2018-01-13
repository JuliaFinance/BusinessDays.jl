#
# Cache routines for Business Days precalculated days
#

"""
Data structure for calendar cache.
"""
mutable struct HolidayCalendarCache
    hc::HolidayCalendar
    isbday_array::Vector{Bool}
    bdayscounter_array::Vector{UInt32}
    dtmin::Date
    dtmax::Date
    is_initialized::Bool # indicated wether isbday_array and bdayscounter_array is empty for this cache
end

"""
Holds caches for Holiday Calendars.

* Key = `HolidayCalendar` instance
* Value = instance of `HolidayCalendarCache`
"""
const CACHE_DICT = Dict{HolidayCalendar, HolidayCalendarCache}()
const DEFAULT_CACHE_D0 = Date(1980, 01, 01)
const DEFAULT_CACHE_D1 = Date(2150, 12, 20)

@inline _getcachestate(hc::HolidayCalendar) = haskey(CACHE_DICT, hc)
@inline _getholidaycalendarcache(hc::HolidayCalendar) = CACHE_DICT[hc]
@inline checkbounds(hcc::HolidayCalendarCache, dt::Date) = @assert (hcc.dtmin <= dt) && (dt <= hcc.dtmax) "Date out of cache bounds. Use initcache function with a wider time spread. Provided date: $(dt)."
@inline _linenumber(hcc::HolidayCalendarCache, dt::Date) = Dates.days(dt) - Dates.days(hcc.dtmin) + 1

@inline function isbday(hcc::HolidayCalendarCache, dt::Date)
    checkbounds(hcc, dt)
    return hcc.isbday_array[ _linenumber(hcc, dt) ]
end

function bdays(hcc::HolidayCalendarCache, dt0::Date, dt1::Date)
    # Computation is always based on next Business Days if given dates are not Business Days, inspired by Banking Account convention.
    dt0_tobday = tobday(hcc.hc, dt0) # cache bounds are checked inside tobday -> isbday
    dt1_tobday = tobday(hcc.hc, dt1) # cache bounds are checked inside tobday -> isbday
    
    return Day(convert(Int, hcc.bdayscounter_array[_linenumber(hcc, dt1_tobday)]) - convert(Int, hcc.bdayscounter_array[_linenumber(hcc, dt0_tobday)]))
end

# Returns tuple
# tuple[1] = Array of Bool (isBday) , tuple[2] = Array of UInt32 (bdaycounter)
function _createbdayscache(hc::HolidayCalendar, d0::Date, d1::Date)

    d0_ = min(d0, d1)
    d1_ = max(d0, d1)

    d0_rata = Dates.days(d0_)
    d1_rata = Dates.days(d1_)

    # length of the cache arrays
    len::Int = d1_rata - d0_rata + 1

    # This function uses UInt32 to store bdayscounter array
    # We need to check if we'll exceed typemax(UInt32)
    @assert len <= typemax(UInt32) "Maximum size allowed for bdays cache array is $(typemax(UInt32)). The required lenght was $(len)."
    
    isbday_array = Array{Bool}(len)
    bdayscounter_array = Array{UInt32}(len)

    @inbounds isbday_array[1] = isbday(hc, d0_)
    @inbounds bdayscounter_array[1] = 0

    for i in 2:len
        @inbounds isbday_array[i] = isbday(hc, d0_ + Dates.Day(i-1))
        @inbounds bdayscounter_array[i] = bdayscounter_array[i-1] + isbday_array[i]
    end

    return isbday_array, bdayscounter_array
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
    @assert d0 <= d1 "d1 < d0 not allowed."
    if haskey(CACHE_DICT, hc) && CACHE_DICT[hc].is_initialized && CACHE_DICT[hc].dtmin == d0 && CACHE_DICT[hc].dtmax == d1
        # will not repeat initcache for this already initialized cache
        return
    else
        isbday_array , bdayscounter_array = _createbdayscache(hc, d0, d1)
        CACHE_DICT[hc] = HolidayCalendarCache(hc, isbday_array, bdayscounter_array, d0, d1, true)
    end
    nothing
end

function initcache(hc_vec::Vector{HolidayCalendar}, d0::Date=DEFAULT_CACHE_D0, d1::Date=DEFAULT_CACHE_D1)
    for hc in hc_vec
        initcache(hc, d0, d1)
    end
end

initcache(calendars::A, d0::Date=DEFAULT_CACHE_D0, d1::Date=DEFAULT_CACHE_D1) where {A<:AbstractArray} = initcache(convert(Vector{HolidayCalendar}, calendars), d0, d1)
initcache(calendar, d0::Date=DEFAULT_CACHE_D0, d1::Date=DEFAULT_CACHE_D1) = initcache(convert(HolidayCalendar, calendar), d0, d1)

# remove all elements from cache
function cleancache()
    for k in keys(CACHE_DICT)
        delete!(CACHE_DICT, k)
    end
end

"""
    cleancache([calendar])

Cleans cache for a given instance or list of `HolidayCalendar`, `Symbol` or `AbstractString`.
"""
function cleancache(hc::HolidayCalendar)
    if haskey(CACHE_DICT, hc)
        delete!(CACHE_DICT, hc)
    end
end

function cleancache(hc_vec::Vector{HolidayCalendar})
    for k in hc_vec
        if k in keys(CACHE_DICT)
            delete!(CACHE_DICT, k)
        end
    end
end

cleancache(calendar) = cleancache(convert(HolidayCalendar, calendar))
cleancache(calendars::A) where {A<:AbstractArray} = cleancache(convert(Vector{HolidayCalendar}, calendars))
