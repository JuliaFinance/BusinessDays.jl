
"""
    isweekend(dt) :: Bool

Returns `true` for Saturdays or Sundays.
Returns `false` otherwise.
"""
@inline isweekend(dt::Dates.Date) :: Bool = signbit(5 - Dates.dayofweek(dt))

"""
    isweekday(dt) :: Bool

Returns `true` for Monday to Friday.
Returns `false` otherwise.
"""
@inline isweekday(dt::Dates.Date) :: Bool = signbit(Dates.dayofweek(dt)  - 6)

"""
    isbday(calendar, dt) :: Bool

Returns `false` for weekends or holidays.
Returns `true` otherwise.
"""
function isbday(hc::HolidayCalendar, dt::Dates.Date) :: Bool
    if _getcachestate(hc)
        return isbday(_getholidaycalendarcache(hc), dt)
    else
        return !(isweekend(dt) || isholiday(hc, dt))
    end
end

@inline isbday(calendar, dt::Dates.Date) :: Bool = isbday(convert(HolidayCalendar, calendar), dt)

# Walks day by day in the direction given by `increment` (+1 or -1) until it
# lands on a Business Day, *starting from the day after `dt`*.
#
# Callers must have already established that `dt` is not a Business Day. This
# lets a `DateRollingConvention` that has to walk in both directions test `dt`
# once instead of once per walk.
function _nextbday(hc::HolidayCalendar, dt::Dates.Date, increment::Int) :: Dates.Date
    next_date = dt + Dates.Day(increment)

    while !isbday(hc, next_date)
        next_date += Dates.Day(increment)
    end

    return next_date
end

# Adjusts `dt` in the direction given by `increment` (+1 or -1).
# Returns `dt` unchanged if it already is a Business Day.
#
# This is the keyword-free core shared by `tobday` and by every
# `DateRollingConvention` in rollingconventions.jl.
@inline function _tobday(hc::HolidayCalendar, dt::Dates.Date, increment::Int) :: Dates.Date
    return isbday(hc, dt) ? dt : _nextbday(hc, dt, increment)
end

"""
    tobday(calendar, dt; [forward=true]) :: Dates.Date
    tobday(calendar, dt, convention) :: Dates.Date

Adjusts `dt` to next Business Day if it's not a Business Day.
If `isbday(dt)`, returns `dt`.

Passing `forward=false` adjusts to the previous Business Day instead.

The three-argument form applies a [`DateRollingConvention`](@ref), which
generalizes `forward` to the full set of standard business day conventions.
`tobday(calendar, dt)` is equivalent to
`tobday(calendar, dt, BusinessDays.Following())`, and
`tobday(calendar, dt; forward=false)` to
`tobday(calendar, dt, BusinessDays.Preceding())`.

# Examples

```jldoctest
julia> using BusinessDays, Dates

julia> tobday(:USSettlement, Date(2015, 1, 31)) # saturday
2015-02-02

julia> tobday(:USSettlement, Date(2015, 1, 31); forward=false)
2015-01-30

julia> tobday(:USSettlement, Date(2015, 1, 31), BusinessDays.ModifiedFollowing()) # stays in january
2015-01-30
```
"""
function tobday(hc::HolidayCalendar, dt::Dates.Date; forward::Bool = true) :: Dates.Date
    return _tobday(hc, dt, forward ? 1 : -1)
end

tobday(calendar, dt::Dates.Date; forward::Bool = true) = tobday(convert(HolidayCalendar, calendar), dt; forward=forward)

"""
    advancebdays(calendar, dt, bdays_count) :: Dates.Date

Increments given date `dt` by `bdays_count`.
Decrements it if `bdays_count` is negative.
`bdays_count` can be a `Int`, `Dates.Day`, `Vector{Int}`, `Vector{Dates.Day}` or a `UnitRange`.

Computation starts by next Business Day if `dt` is not a Business Day.
"""
function advancebdays(hc::HolidayCalendar, dt::Dates.Date, bdays_count::Int) :: Dates.Date
    result = tobday(hc, dt)

    # does nothing
    if bdays_count == 0
        return result
    end

    # if bdays_count is positive, goes forward. Otherwise, goes backwards.
    increment = bdays_count > 0 ? +1 : -1

    num_iterations = abs(bdays_count)

    while num_iterations > 0
        result += Dates.Day(increment)

        # Looks for previous / next Business Day
        while !isbday(hc, result)
            result += Dates.Day(increment)
        end

        num_iterations += -1
    end

    return result
end

advancebdays(hc::HolidayCalendar, dt::Dates.Date, bdays_count::Dates.Day) = advancebdays(hc, dt, Dates.value(bdays_count))

const BDaysCountType = Union{Int, Dates.Day}

function advancebdays(calendar, dt, bdays_count::Union{T, Vector{T}, AbstractRange}) where {T<:BDaysCountType}
    advancebdays(convert(HolidayCalendar, calendar), convert(Dates.Date, dt), bdays_count)
end

"""
    bdayscount(calendar, dt0, dt1) :: Int

Counts the number of Business Days between `dt0` and `dt1`.
Returns `Int`.

Computation is always based on next Business Day if given dates are not Business Days.

!!! note "Counting Convention"
    The first Business Day is excluded from the count, e.g. if `dt0` and `dt1` 
    are the same date, `bdayscount` will always return 0. This convention is 
    different from [`listbdays`](@ref) which *is* inclusive. In our 
    `dt0 == dt1` example, if the date is a Business Day then `listbdays` will 
    return a 1-element Vector with that date.
"""
function bdayscount(hc::HolidayCalendar, dt0::Dates.Date, dt1::Dates.Date) :: Int
    if _getcachestate(hc)
        return bdayscount(_getholidaycalendarcache(hc), dt0, dt1)
    else
        dt0 = tobday(hc, dt0)
        dt1 = tobday(hc, dt1)
        inc = dt0 <= dt1 ? +1 : -1

        result = 0
        while dt0 != dt1
            dt0 = advancebdays(hc, dt0, inc)
            result += inc
        end

        return result
    end
end

bdayscount(calendar, dt0::Dates.Date, dt1::T) where {T<:Union{Dates.Date, Vector{Dates.Date}}} = bdayscount(convert(HolidayCalendar, calendar), dt0, dt1)
bdayscount(calendar, dt0::Vector{Dates.Date}, dt1::Vector{Dates.Date}) = bdayscount(convert(HolidayCalendar, calendar), dt0, dt1)

"""
    bdays(calendar, dt0, dt1) :: Dates.Day

Counts the number of Business Days between `dt0` and `dt1`.
Returns instances of `Dates.Day`.

Computation is always based on next Business Day if given dates are not Business Days.
"""
bdays(hc::HolidayCalendar, dt0::Dates.Date, dt1::Dates.Date) = Dates.Day(bdayscount(hc, dt0, dt1))
bdays(calendar, dt0::Dates.Date, dt1::T) where {T<:Union{Dates.Date, Vector{Dates.Date}}} = bdays(convert(HolidayCalendar, calendar), dt0, dt1)
bdays(calendar, dt0::Vector{Dates.Date}, dt1::Vector{Dates.Date}) = bdays(convert(HolidayCalendar, calendar), dt0, dt1)

"""
    firstbdayofmonth(calendar, dt) :: Dates.Date
    firstbdayofmonth(calendar, yy, mm) :: Dates.Date

Returns the first business day of month.
"""
firstbdayofmonth(calendar, dt::Dates.Date) = tobday(calendar, Dates.firstdayofmonth(dt))

"""
    lastbdayofmonth(calendar, dt) :: Dates.Date
    lastbdayofmonth(calendar, yy, mm) :: Dates.Date

Returns the last business day of month.
"""
lastbdayofmonth(calendar, dt::Dates.Date) = tobday(calendar, Dates.lastdayofmonth(dt), forward=false)
firstbdayofmonth(calendar, yy::T, mm::T) where {T<:Integer} = firstbdayofmonth(calendar, Dates.Date(yy, mm, 1))
firstbdayofmonth(calendar, yy::Dates.Year, mm::Dates.Month) = firstbdayofmonth(calendar, Dates.Date(yy, mm, Dates.Day(1)))
lastbdayofmonth(calendar, yy::T, mm::T) where {T<:Integer} = lastbdayofmonth(calendar, Dates.Date(yy, mm, 1))
lastbdayofmonth(calendar, yy::Dates.Year, mm::Dates.Month) = lastbdayofmonth(calendar, Dates.Date(yy, mm, Dates.Day(1)))
