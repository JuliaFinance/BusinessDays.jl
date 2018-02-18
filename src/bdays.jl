
"""
    isweekend(dt)

Returns `true` for Saturdays or Sundays.
Returns `false` otherwise.
"""
@inline isweekend(dt::Date) = signbit(5 - dayofweek(dt))

"""
    isweekday(dt)

Returns `true` for Monday to Friday.
Returns `false` otherwise.
"""
@inline isweekday(dt::Date) = signbit(dayofweek(dt)  - 6)

"""
    isbday(calendar, dt)

Returns `false` for weekends or holidays.
Returns `true` otherwise.
"""
function isbday(hc::HolidayCalendar, dt::Date)
    if _getcachestate(hc)
        hcc :: HolidayCalendarCache = _getholidaycalendarcache(hc)
        return isbday(hcc, dt)
    else
        return !(isweekend(dt) || isholiday(hc, dt))
    end
end

isbday(calendar, dt) = isbday(convert(HolidayCalendar, calendar), dt)

"""
    tobday(calendar, dt; [forward=true])

Adjusts `dt` to next Business Day if it's not a Business Day.
If `isbday(dt)`, returns `dt`.
"""
function tobday(hc::HolidayCalendar, dt::Date; forward::Bool = true)
    if isbday(hc, dt)
        return dt
    else
        local next_date::Date
        local increment::Int = forward ? 1 : -1
        next_date = dt + Dates.Day(increment)

        while !isbday(hc, next_date)
            next_date += Dates.Day(increment)
        end
    end
    
    return next_date
end

tobday(calendar, dt; forward::Bool = true) = tobday(convert(HolidayCalendar,calendar), dt; forward=forward)

"""
    advancebdays(calendar, dt, bdays_count)

Increments given date `dt` by `bdays_count`.
Decrements it if `bdays_count` is negative.
`bdays_count` can be a `Int`, `Vector{Int}` or a `UnitRange`.

Computation starts by next Business Day if `dt` is not a Business Day.
"""
function advancebdays(hc::HolidayCalendar, dt::Date, bdays_count::Int)
    local result::Date = tobday(hc, dt)

    # does nothing
    if bdays_count == 0
        return result
    end

    # if bdays_count is positive, goes forward. Otherwise, goes backwards.
    local increment::Int = bdays_count > 0 ? +1 : -1

    local num_iterations::Int = abs(bdays_count)
    
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

advancebdays(calendar, dt, bdays_count) = advancebdays(convert(HolidayCalendar,calendar), convert(Date,dt), bdays_count)

"""
    bdays(calendar, dt0, dt1)

Counts the number of Business Days between `dt0` and `dt1`.
Returns instances of `Dates.Day`.

Computation is always based on next Business Day if given dates are not Business Days.
"""
function bdays(hc::HolidayCalendar, dt0::Date, dt1::Date)
    if _getcachestate(hc)
        hcc::HolidayCalendarCache = _getholidaycalendarcache(hc)
        return bdays(hcc, dt0, dt1)
    else
        dt0 = tobday(hc, dt0)
        dt1 = tobday(hc, dt1)
        inc::Int = dt0 <= dt1 ? +1 : -1

        local result::Int = 0
        while dt0 != dt1
            dt0 += Dates.Day(inc)

            # Looks for next/last Business Day
            while !isbday(hc, dt0)
                dt0 += Dates.Day(inc)
            end

            result += inc
        end

        return Dates.Day(result)
    end
end

bdays(calendar, dt0::Date, dt1::T) where {T<:Union{Date,Vector{Date}}} = bdays(convert(HolidayCalendar, calendar), dt0, dt1)
bdays(calendar, dt0::Vector{Date}, dt1::Vector{Date}) = bdays(convert(HolidayCalendar, calendar), dt0, dt1)

"""
    firstbdayofmonth(calendar, dt)
    firstbdayofmonth(calendar, yy, mm)

Returns the first business day of month.
"""
firstbdayofmonth(calendar, dt::Date) = tobday(calendar, firstdayofmonth(dt))

"""
    lastbdayofmonth(calendar, dt)
    lastbdayofmonth(calendar, yy, mm)

Returns the last business day of month.
"""
lastbdayofmonth(calendar, dt::Date) = tobday(calendar, lastdayofmonth(dt), forward=false)
firstbdayofmonth(calendar, yy::T, mm::T) where {T<:Integer} = firstbdayofmonth(calendar, Date(yy, mm, 1))
firstbdayofmonth(calendar, yy::Year, mm::Month) = firstbdayofmonth(calendar, Date(yy, mm, Day(1)))
lastbdayofmonth(calendar, yy::T, mm::T) where {T<:Integer} = lastbdayofmonth(calendar, Date(yy, mm, 1))
lastbdayofmonth(calendar, yy::Year, mm::Month) = lastbdayofmonth(calendar, Date(yy, mm, Day(1)))
