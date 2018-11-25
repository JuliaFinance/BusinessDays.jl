
"""
    isweekend(dt)

Returns `true` for Saturdays or Sundays.
Returns `false` otherwise.
"""
@inline isweekend(dt::Dates.Date) :: Bool = signbit(5 - Dates.dayofweek(dt))

"""
    isweekday(dt)

Returns `true` for Monday to Friday.
Returns `false` otherwise.
"""
@inline isweekday(dt::Dates.Date) :: Bool = signbit(Dates.dayofweek(dt)  - 6)

"""
    isbday(calendar, dt)

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

@inline isbday(calendar, dt) :: Bool = isbday(convert(HolidayCalendar, calendar), dt)

"""
    tobday(calendar, dt; [forward=true])

Adjusts `dt` to next Business Day if it's not a Business Day.
If `isbday(dt)`, returns `dt`.
"""
function tobday(hc::HolidayCalendar, dt::Dates.Date; forward::Bool = true) :: Dates.Date
    if isbday(hc, dt)
        return dt
    else
        increment = forward ? 1 : -1
        next_date = dt + Dates.Day(increment)

        while !isbday(hc, next_date)
            next_date += Dates.Day(increment)
        end
    end

    return next_date
end

tobday(calendar, dt; forward::Bool = true) = tobday(convert(HolidayCalendar, calendar), dt; forward=forward)

"""
    advancebdays(calendar, dt, bdays_count)

Increments given date `dt` by `bdays_count`.
Decrements it if `bdays_count` is negative.
`bdays_count` can be a `Int`, `Vector{Int}` or a `UnitRange`.

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

advancebdays(calendar, dt, bdays_count) = advancebdays(convert(HolidayCalendar, calendar), convert(Dates.Date, dt), bdays_count)

"""
    bdayscount(calendar, dt0, dt1) :: Int

Counts the number of Business Days between `dt0` and `dt1`.
Returns `Int`.

Computation is always based on next Business Day if given dates are not Business Days.
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
bdays(hc::HolidayCalendar, dt0::Dates.Date, dt1::Dates.Date) :: Dates.Day = Dates.Day(bdayscount(hc, dt0, dt1))
bdays(calendar, dt0::Dates.Date, dt1::T) where {T<:Union{Dates.Date, Vector{Dates.Date}}} = bdays(convert(HolidayCalendar, calendar), dt0, dt1)
bdays(calendar, dt0::Vector{Dates.Date}, dt1::Vector{Dates.Date}) = bdays(convert(HolidayCalendar, calendar), dt0, dt1)

"""
    firstbdayofmonth(calendar, dt)
    firstbdayofmonth(calendar, yy, mm)

Returns the first business day of month.
"""
firstbdayofmonth(calendar, dt::Dates.Date) = tobday(calendar, Dates.firstdayofmonth(dt))

"""
    lastbdayofmonth(calendar, dt)
    lastbdayofmonth(calendar, yy, mm)

Returns the last business day of month.
"""
lastbdayofmonth(calendar, dt::Dates.Date) = tobday(calendar, Dates.lastdayofmonth(dt), forward=false)
firstbdayofmonth(calendar, yy::T, mm::T) where {T<:Integer} = firstbdayofmonth(calendar, Dates.Date(yy, mm, 1))
firstbdayofmonth(calendar, yy::Dates.Year, mm::Dates.Month) = firstbdayofmonth(calendar, Dates.Date(yy, mm, Dates.Day(1)))
lastbdayofmonth(calendar, yy::T, mm::T) where {T<:Integer} = lastbdayofmonth(calendar, Dates.Date(yy, mm, 1))
lastbdayofmonth(calendar, yy::Dates.Year, mm::Dates.Month) = lastbdayofmonth(calendar, Dates.Date(yy, mm, Dates.Day(1)))
