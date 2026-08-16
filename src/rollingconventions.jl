
#
# Date Rolling / Business Day Conventions
#
# https://en.wikipedia.org/wiki/Date_rolling
#
# Naming follows QuantLib's `BusinessDayConvention` enum.
#

"""
*Abstract* type for Date Rolling Conventions.

A convention answers the question "given a date that may not be a business day,
which business day should be used instead?". Pass one as the third argument to
[`tobday`](@ref).

The available conventions are [`Unadjusted`](@ref), [`Following`](@ref),
[`ModifiedFollowing`](@ref), [`Preceding`](@ref), [`ModifiedPreceding`](@ref),
[`HalfMonthModifiedFollowing`](@ref) and [`Nearest`](@ref).
"""
abstract type DateRollingConvention end

"""
    Unadjusted() <: DateRollingConvention

Does not adjust `dt`. Note this is the only convention that may return a date
that is not a Business Day.
"""
struct Unadjusted <: DateRollingConvention end

"""
    Following() <: DateRollingConvention

Adjusts `dt` to the next Business Day. This is the default behavior of
[`tobday`](@ref).
"""
struct Following <: DateRollingConvention end

"""
    ModifiedFollowing() <: DateRollingConvention

Adjusts `dt` to the next Business Day, unless that would land in a different
calendar month, in which case adjusts to the previous Business Day.

This is the most widely used convention for interest rate products.
"""
struct ModifiedFollowing <: DateRollingConvention end

"""
    Preceding() <: DateRollingConvention

Adjusts `dt` to the previous Business Day. Equivalent to
`tobday(calendar, dt; forward=false)`.
"""
struct Preceding <: DateRollingConvention end

"""
    ModifiedPreceding() <: DateRollingConvention

Adjusts `dt` to the previous Business Day, unless that would land in a different
calendar month, in which case adjusts to the next Business Day.
"""
struct ModifiedPreceding <: DateRollingConvention end

"""
    HalfMonthModifiedFollowing() <: DateRollingConvention

Adjusts `dt` to the next Business Day, unless that would land in a different
calendar month *or* cross the mid-month (15th) boundary, in which case adjusts
to the previous Business Day.
"""
struct HalfMonthModifiedFollowing <: DateRollingConvention end

"""
    Nearest() <: DateRollingConvention

Adjusts `dt` to the nearest Business Day, searching forwards and backwards at
the same time. Ties are resolved in favor of the next Business Day.
"""
struct Nearest <: DateRollingConvention end

Base.broadcastable(conv::DateRollingConvention) = Ref(conv)

@inline tobday(::HolidayCalendar, dt::Dates.Date, ::Unadjusted) :: Dates.Date = dt
@inline tobday(hc::HolidayCalendar, dt::Dates.Date, ::Following) :: Dates.Date = _tobday(hc, dt, 1)
@inline tobday(hc::HolidayCalendar, dt::Dates.Date, ::Preceding) :: Dates.Date = _tobday(hc, dt, -1)

function tobday(hc::HolidayCalendar, dt::Dates.Date, ::ModifiedFollowing) :: Dates.Date
    if isbday(hc, dt)
        return dt
    end

    # `result` is the first Business Day after `dt`, so it stays in `dt`'s month
    # exactly when it does not pass the last day of that month. Comparing dates
    # is cheaper than decomposing both into year and month.
    result = _nextbday(hc, dt, 1)
    return result <= Dates.lastdayofmonth(dt) ? result : _nextbday(hc, dt, -1)
end

function tobday(hc::HolidayCalendar, dt::Dates.Date, ::ModifiedPreceding) :: Dates.Date
    if isbday(hc, dt)
        return dt
    end

    # mirror image: `result` is the last Business Day before `dt`, so it stays in
    # `dt`'s month exactly when it does not fall before the first day of it
    result = _nextbday(hc, dt, -1)
    return result >= Dates.firstdayofmonth(dt) ? result : _nextbday(hc, dt, 1)
end

function tobday(hc::HolidayCalendar, dt::Dates.Date, ::HalfMonthModifiedFollowing) :: Dates.Date
    if isbday(hc, dt)
        return dt
    end

    result = _nextbday(hc, dt, 1)

    # decompose each date once: the month test and the mid-month test share it
    y0, m0, d0 = Dates.yearmonthday(dt)
    y1, m1, d1 = Dates.yearmonthday(result)

    if y0 != y1 || m0 != m1 || (d0 <= 15 && d1 > 15)
        return _nextbday(hc, dt, -1)
    end

    return result
end

function tobday(hc::HolidayCalendar, dt::Dates.Date, ::Nearest) :: Dates.Date
    if isbday(hc, dt)
        return dt
    end

    next_date = dt
    previous_date = dt

    while true
        # ties are resolved in favor of the next Business Day, so it is always
        # tested first; the backwards step is only taken if that misses
        next_date += Dates.Day(1)

        if isbday(hc, next_date)
            return next_date
        end

        previous_date -= Dates.Day(1)

        if isbday(hc, previous_date)
            return previous_date
        end
    end
end

tobday(calendar, dt::Dates.Date, conv::DateRollingConvention) = tobday(convert(HolidayCalendar, calendar), dt, conv)
