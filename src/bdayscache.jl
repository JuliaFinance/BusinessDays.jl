
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
    dtmin::Dates.Date
    dtmax::Dates.Date
    is_initialized::Bool # indicated wether isbday_array and bdayscounter_array is empty for this cache
end

"""
    HolidayCalendarCache()

creates an empty instance of HolidayCalendarCache
"""
HolidayCalendarCache() = HolidayCalendarCache(NullHolidayCalendar(), Vector{Bool}(), Vector{UInt32}(), Dates.Date(1900,1,1), Dates.Date(1900,1,1), false)

"""
Holds caches for Holiday Calendars.

* Key = `HolidayCalendar` instance
* Value = instance of `HolidayCalendarCache`
"""
const CACHE_DICT = Dict{HolidayCalendar, HolidayCalendarCache}()
const DEFAULT_CACHE_D0 = Dates.Date(1980, 01, 01)
const DEFAULT_CACHE_D1 = Dates.Date(2150, 12, 20)

@inline _getcachestate(hcc::HolidayCalendarCache) = hcc.is_initialized
@inline _getcachestate(hc::HolidayCalendar) = haskey(CACHE_DICT, hc) && _getcachestate(CACHE_DICT[hc])
@inline _getholidaycalendarcache(hc::HolidayCalendar) = CACHE_DICT[hc]
@inline checkbounds(hcc::HolidayCalendarCache, dt::Dates.Date) = @assert (hcc.dtmin <= dt) && (dt <= hcc.dtmax) "Date out of cache bounds. Use initcache function with a wider time spread. Provided date: $(dt)."
@inline _linenumber(hcc::HolidayCalendarCache, dt::Dates.Date) = Dates.days(dt) - Dates.days(hcc.dtmin) + 1

@inline function isbday(hcc::HolidayCalendarCache, dt::Dates.Date) :: Bool
    checkbounds(hcc, dt)
    return hcc.isbday_array[ _linenumber(hcc, dt) ]
end

function bdayscount(hcc::HolidayCalendarCache, dt0::Dates.Date, dt1::Dates.Date) :: Int
    # Computation is always based on next Business Days if given dates are not Business Days, inspired by Banking Account convention.
    dt0_tobday = tobday(hcc.hc, dt0) # cache bounds are checked inside tobday -> isbday
    dt1_tobday = tobday(hcc.hc, dt1) # cache bounds are checked inside tobday -> isbday

    return Int(hcc.bdayscounter_array[_linenumber(hcc, dt1_tobday)]) - Int(hcc.bdayscounter_array[_linenumber(hcc, dt0_tobday)])
end

@inline bdays(hcc::HolidayCalendarCache, dt0::Dates.Date, dt1::Dates.Date) :: Dates.Day = Dates.Day(bdayscount(hcc, dt0, dt1))

# Returns tuple
# tuple[1] = Array of Bool (isBday) , tuple[2] = Array of UInt32 (bdaycounter)
function _create_bdays_cache_arrays(hc::HolidayCalendar, d0::Dates.Date, d1::Dates.Date)

    d0_rata = Dates.days(d0)
    d1_rata = Dates.days(d1)

    # length of the cache arrays
    len::Int = d1_rata - d0_rata + 1

    # This function uses UInt32 to store bdayscounter array
    # We need to check if we'll exceed typemax(UInt32)
    @assert len <= typemax(UInt32) "Maximum size allowed for bdays cache array is $(typemax(UInt32)). The required lenght was $(len)."

    isbday_array = Vector{Bool}(undef, len)
    bdayscounter_array = Vector{UInt32}(undef, len)

    @inbounds isbday_array[1] = isbday(hc, d0)
    @inbounds bdayscounter_array[1] = 0

    for i in 2:len
        @inbounds isbday_array[i] = isbday(hc, d0 + Dates.Day(i-1))
        @inbounds bdayscounter_array[i] = bdayscounter_array[i-1] + isbday_array[i]
    end

    return isbday_array, bdayscounter_array
end

@inline needs_cache_update(cache::HolidayCalendarCache, d0::Dates.Date, d1::Dates.Date) :: Bool = _getcachestate(cache) && cache.dtmin == d0 && cache.dtmax == d1
@inline needs_cache_update(hc::HolidayCalendar, d0::Dates.Date, d1::Dates.Date) :: Bool = _getcachestate(hc) && CACHE_DICT[hc].dtmin == d0 && CACHE_DICT[hc].dtmax == d1

# Be sure to use this function on a syncronized code (not multithreaded).
"""
    initcache(calendar, [d0], [d1])

Creates cache for a given Holiday Calendar. After calling this function, any call to `isbday`
function, or any function that uses `isbday`, will be optimized to use this cache.

You can pass `calendar` as an instance of `HolidayCalendar`, `Symbol` or `AbstractString`.
You can also pass `calendar` as an `AbstractArray` of those types.
"""
function initcache(hc::HolidayCalendar, d0::Dates.Date=DEFAULT_CACHE_D0, d1::Dates.Date=DEFAULT_CACHE_D1)
    @assert d0 <= d1 "d1 < d0 not allowed."
    if needs_cache_update(hc, d0, d1)
        # will not repeat initcache for this already initialized cache
        return
    else
        isbday_array , bdayscounter_array = _create_bdays_cache_arrays(hc, d0, d1)
        CACHE_DICT[hc] = HolidayCalendarCache(hc, isbday_array, bdayscounter_array, d0, d1, true)
    end
    nothing
end

function initcache(hc_vec::Vector{HolidayCalendar}, d0::Dates.Date=DEFAULT_CACHE_D0, d1::Dates.Date=DEFAULT_CACHE_D1)
    for hc in hc_vec
        initcache(hc, d0, d1)
    end
end

initcache(calendars::A, d0::Dates.Date=DEFAULT_CACHE_D0, d1::Dates.Date=DEFAULT_CACHE_D1) where {A<:AbstractArray} = initcache(convert(Vector{HolidayCalendar}, calendars), d0, d1)
initcache(calendar, d0::Dates.Date=DEFAULT_CACHE_D0, d1::Dates.Date=DEFAULT_CACHE_D1) = initcache(convert(HolidayCalendar, calendar), d0, d1)

function initcache!(cache::HolidayCalendarCache, hc::HolidayCalendar, d0::Dates.Date=DEFAULT_CACHE_D0, d1::Dates.Date=DEFAULT_CACHE_D1)
    if needs_cache_update(cache, d0, d1)
        # will not repeat initcache for this already initialized cache
        return
    else
        cache.dtmin = d0
        cache.dtmax = d1
        isbday_array , bdayscounter_array = _create_bdays_cache_arrays(hc, d0, d1)
        cache.isbday_array = isbday_array
        cache.bdayscounter_array = bdayscounter_array
        cache.is_initialized = true
    end
    nothing
end

function cleancache!(cache::HolidayCalendarCache)
    if cache.is_initialized
        empty!(cache.isbday_array)
        empty!(cache.bdayscounter_array)
        cache.is_initialized = false
    end
    nothing
end

# remove all elements from cache
function cleancache()
    for k in keys(CACHE_DICT)
        delete!(CACHE_DICT, k)
    end
    nothing
end

"""
    cleancache([calendar])

Cleans cache for a given instance or list of `HolidayCalendar`, `Symbol` or `AbstractString`.
"""
function cleancache(hc::HolidayCalendar)
    if haskey(CACHE_DICT, hc)
        delete!(CACHE_DICT, hc)
    end
    nothing
end

function cleancache(hc_vec::Vector{HolidayCalendar})
    for k in hc_vec
        if k in keys(CACHE_DICT)
            delete!(CACHE_DICT, k)
        end
    end
    nothing
end

cleancache(calendar) = cleancache(convert(HolidayCalendar, calendar))
cleancache(calendars::A) where {A<:AbstractArray} = cleancache(convert(Vector{HolidayCalendar}, calendars))
