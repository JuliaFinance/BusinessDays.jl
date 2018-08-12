
"""
Banking holidays for England and Wales.
"""
struct UKSettlement <: HolidayCalendar end
const UnitedKingdom = UKSettlement

# England and Wales Banking Holidays
function isholiday(::UKSettlement, dt::Dates.Date)

    yy = Dates.year(dt)
    mm = Dates.month(dt)
    dd = Dates.day(dt)

    # Bisection
    if mm >= 8
        # Fixed holidays
        if (
                # Late Summer Bank Holiday, August Bank Holiday
                adjustweekendholidayPost( findweekday(Dates.Monday, yy, 8, 1, false) ) == dt
                ||
                # Christmas
                adjustweekendholidayPost( Dates.Date(yy, 12, 25) ) == dt
                ||
                # Boxing
                adjustweekendholidayPost(adjustweekendholidayPost( Dates.Date(yy, 12, 25) ) + Dates.Day(1)) == dt
            )
            return true
        end

        # Fixed date holidays with mm >= 8
        if dt == Dates.Date(1999, 12, 31)
            return true
        end
    else
        # mm < 8
        # Fixed holidays
        if (
                # New Year's Day
                adjustweekendholidayPost( Dates.Date(yy, 01, 01) ) == dt
                ||
                # May Day, Early May Bank Holiday
                adjustweekendholidayPost(findweekday(Dates.Monday, yy, 5, 1, true)) == dt
                ||
                # Spring Bank Holiday
                (adjustweekendholidayPost(findweekday(Dates.Monday, yy, 5, 1, false)) == dt && yy != 2012 && yy != 2002)
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
                ||
                # Easter Monday
                ( dt_rata == ( e_rata + 1 ) )
            )
            return true
        end

        # Fixed date holidays with mm < 8
        if (
            # Substitute date for Spring Bank Holiday
            (dt == Dates.Date(2012, 06, 04))
            ||
            # Diamond Jubilee of Queen Elizabeth II.
            (dt == Dates.Date(2012, 06, 05))
            ||
            # Golden Jubilee of Queen Elizabeth II.
            (dt == Dates.Date(2002, 06, 03))
            ||
            # Substitute date for Spring Bank Holiday
            (dt == Dates.Date(2002, 06, 04))
            ||
            # Wedding of Prince William and Catherine Middleton
            (dt == Dates.Date(2011, 04, 29))
            )
            return true
        end
    end

    return false
end
