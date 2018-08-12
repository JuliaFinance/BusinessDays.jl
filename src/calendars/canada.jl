
"""
Holidays for Canada
"""
struct CanadaSettlement <: HolidayCalendar end
const Canada = CanadaSettlement

"""
Holidays for Toronto Stock Exchange
"""
struct CanadaTSX <: HolidayCalendar end

function isholiday(::CanadaSettlement, dt::Dates.Date)

    yy = Dates.year(dt)
    mm = Dates.month(dt)
    dd = Dates.day(dt)
    ww = Dates.dayofweek(dt)

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
                || adjustweekendholidayPost(Dates.Date(yy, 11, 11)) == dt
                # Christmas
                || adjustweekendholidayPost( Dates.Date(yy, 12, 25) ) == dt
                # Boxing
                || adjustweekendholidayPost(adjustweekendholidayPost( Dates.Date(yy, 12, 25) ) + Dates.Day(1)) == dt
            )
            return true
        end
    else
        # mm < 8
        # Fixed holidays
        if (
                # New Year's Day
                adjustweekendholidayPost(Dates.Date(yy, 01, 01); adjust_saturdays=false) == dt
                # Family Day (third Monday in February, since 2008)
                || ( yy >= 2008 && findweekday(Dates.Monday, yy, 2, 3, true) == dt )
                # The Monday on or preceding 24 May (Victoria Day)
                || (dd > 17 && dd <= 24 && ww == Dates.Monday && mm == Dates.May)
                # July 1st, possibly moved to Monday (Canada Day)
                || adjustweekendholidayPost(Dates.Date(yy, 07, 01)) == dt
          )
            return true
        end

        # Easter occurs up to April, which is before August (mm < 8). See test/easter-min-max.jl .
        # Holidays based on easter date
        dt_rata::Int = Dates.days(dt)
        e_rata::Int = easter_rata(Dates.Year(yy))

        if (
                # Good Friday
                ( dt_rata == ( e_rata - 2 ) )
            )
            return true
        end
    end

    return false
end

function isholiday(::CanadaTSX, dt::Dates.Date)

    yy = Dates.year(dt)
    mm = Dates.month(dt)
    dd = Dates.day(dt)
    ww = Dates.dayofweek(dt)

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
                || adjustweekendholidayPost( Dates.Date(yy, 12, 25) ) == dt
                # Boxing
                || adjustweekendholidayPost(adjustweekendholidayPost( Dates.Date(yy, 12, 25) ) + Dates.Day(1)) == dt
            )
            return true
        end
    else
        # mm < 8
        # Fixed holidays
        if (
                # New Year's Day
                adjustweekendholidayPost(Dates.Date(yy, 01, 01); adjust_saturdays=false) == dt
                # Family Day (third Monday in February, since 2008)
                || ( yy >= 2008 && findweekday(Dates.Monday, yy, 2, 3, true) == dt )
                # The Monday on or preceding 24 May (Victoria Day)
                || (dd > 17 && dd <= 24 && ww == Dates.Monday && mm == Dates.May)
                # July 1st, possibly moved to Monday (Canada Day)
                || adjustweekendholidayPost(Dates.Date(yy, 07, 01)) == dt

          )
            return true
        end

        # Easter occurs up to April, which is before August (mm < 8). See test/easter-min-max.jl .
        # Holidays based on easter date
        dt_rata::Int = Dates.days(dt)
        e_rata::Int = easter_rata(Dates.Year(yy))

        if (
                # Good Friday
                ( dt_rata == ( e_rata - 2 ) )
            )
            return true
        end
    end

    return false
end
