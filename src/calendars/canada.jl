
"""
Holidays for Canada
"""
type CanadaSettlement <: HolidayCalendar end
typealias Canada CanadaSettlement

"""
Holidays for Toronto Stock Exchange
"""
type CanadaTSX <: HolidayCalendar end

function isholiday(::CanadaSettlement, dt::Date)

    const yy = Dates.year(dt)
    const mm = Dates.month(dt)
    const dd = Dates.day(dt)
    const ww = Dates.dayofweek(dt)

    # Bisection
    if mm >= 8
        # Fixed holidays
        if (
                # first Monday of August (Provincial Holiday)
                findweekday(Dates.Monday, yy, 8, 1, true)  == dt
                # first Monday of September (Labor Day)
                || findweekday(Dates.Monday, yy, 9, 1, true)  == dt
                # second Monday of October (Thanksgiving Day)
                || findweekday(Dates.Monday, yy, 10, 2, true) == dt
                # November 11th (possibly moved to Monday)
                || adjustweekendholidayPost(Date(yy, 11, 11)) == dt
                # Christmas
                || adjustweekendholidayPost( Date(yy, 12, 25) ) == dt
                # Boxing
                || adjustweekendholidayPost(adjustweekendholidayPost( Date(yy, 12, 25) ) + Dates.Day(1)) == dt
            )
            return true
        end
    else
        # mm < 8
        # Fixed holidays
        if (
                # New Year's Day
                adjustweekendholidayPost(Date(yy, 01, 01); adjust_saturdays=false) == dt
                # Family Day (third Monday in February, since 2008)
                || ( yy >= 2008 && findweekday(Dates.Monday, yy, 2, 3, true) == dt )
                # The Monday on or preceding 24 May (Victoria Day)
                || (dd > 17 && dd <= 24 && ww == Dates.Monday && mm == Dates.May)
                # July 1st, possibly moved to Monday (Canada Day)
                || adjustweekendholidayPost(Date(yy, 07, 01)) == dt
          )
            return true
        end

        # Easter occurs up to April, which is before August (mm < 8). See test/easter-min-max.jl .
        # Holidays based on easter date
        const dt_rata::Int = Dates.days(dt)
        const e_rata::Int = easter_rata(Dates.Year(yy))

        if (
                # Good Friday
                ( dt_rata == ( e_rata - 2 ) )
            )
            return true
        end
    end
    return false
end

function isholiday(::CanadaTSX, dt::Date)

    const yy = Dates.year(dt)
    const mm = Dates.month(dt)
    const dd = Dates.day(dt)
    const ww = Dates.dayofweek(dt)

    # Bisection
    if mm >= 8
        # Fixed holidays
        if (
                # first Monday of August (Provincial Holiday)
                findweekday(Dates.Monday, yy, 8, 1, true)  == dt
                # first Monday of September (Labor Day)
                || findweekday(Dates.Monday, yy, 9, 1, true)  == dt
                # second Monday of October (Thanksgiving Day)
                || findweekday(Dates.Monday, yy, 10, 2, true) == dt
                # Christmas
                || adjustweekendholidayPost( Date(yy, 12, 25) ) == dt
                # Boxing
                || adjustweekendholidayPost(adjustweekendholidayPost( Date(yy, 12, 25) ) + Dates.Day(1)) == dt
            )
            return true
        end
    else
        # mm < 8
        # Fixed holidays
        if (
                # New Year's Day
                adjustweekendholidayPost(Date(yy, 01, 01); adjust_saturdays=false) == dt
                # Family Day (third Monday in February, since 2008)
                || ( yy >= 2008 && findweekday(Dates.Monday, yy, 2, 3, true) == dt )
                # The Monday on or preceding 24 May (Victoria Day)
                || (dd > 17 && dd <= 24 && ww == Dates.Monday && mm == Dates.May)
                # July 1st, possibly moved to Monday (Canada Day)
                || adjustweekendholidayPost(Date(yy, 07, 01)) == dt

          )
            return true
        end

        # Easter occurs up to April, which is before August (mm < 8). See test/easter-min-max.jl .
        # Holidays based on easter date
        const dt_rata::Int = Dates.days(dt)
        const e_rata::Int = easter_rata(Dates.Year(yy))

        if (
                # Good Friday
                ( dt_rata == ( e_rata - 2 ) )
            )
            return true
        end
    end
    return false
end
