
# In the UK, if a holiday falls on Saturday or Sunday, it's observed on the next business day.
# This function will adjust to the next Monday.
function adjustweekendholidayUK(dt::Date)
    
    if dayofweek(dt) == Dates.Saturday
        return dt + Dates.Day(2)
    end

    if dayofweek(dt) == Dates.Sunday
        return dt + Dates.Day(1)
    end

    return dt
end

# England and Wales Banking Holidays
function isholiday(::UKSettlement, dt::Date)

    const yy = Dates.year(dt)
    const mm = Dates.month(dt)
    const dd = Dates.day(dt)

    # Bisection
    if mm >= 8
        # Fixed holidays
        if (
                # Late Summer Bank Holiday, August Bank Holiday
                adjustweekendholidayUK(  findweekday(Dates.Monday, yy, 8, 1, false) ) == dt
                ||
                # Christmas
                adjustweekendholidayUK( Date(yy, 12, 25) ) == dt
                ||
                # Boxing
                adjustweekendholidayUK(adjustweekendholidayUK( Date(yy, 12, 25) ) + Dates.Day(1)) == dt 
            )
            return true
        end

        # Fixed date holidays with mm >= 8
        if dt == Date(1999, 12, 31)
            return true
        end

    else
        # mm < 8
        # Fixed holidays
        if (
                # New Year's Day
                adjustweekendholidayUK(  Date(yy, 01, 01) ) == dt
                ||
                # May Day, Early May Bank Holiday
                adjustweekendholidayUK(findweekday(Dates.Monday, yy, 5, 1, true)) == dt
                ||
                # Spring Bank Holiday
                (adjustweekendholidayUK(findweekday(Dates.Monday, yy, 5, 1, false)) == dt && yy != 2012 && yy != 2002)
            )
            return true
        end

        # Easter occurs up to April, which is before August (mm < 8). See test/easter-min-max.jl .
        # Holidays based on easter date
        const dt_rata::Int64 = Dates.days(dt)
        const e_rata::Int64 = easter_rata(Dates.Year(yy))

        if (
                # Good Friday
                ( dt_rata == ( e_rata - 2 ) )
                ||
                # Easter Monday
                ( dt_rata == ( e_rata + 1)  )
            )
            return true
        end

        # Fixed date holidays with mm < 8
        if ( 
            # Substitute date for Spring Bank Holiday
            (dt == Date(2012, 06, 04))
            ||
            # Diamond Jubilee of Queen Elizabeth II.
            (dt == Date(2012, 06, 05))
            ||
            # Golden Jubilee of Queen Elizabeth II.
            (dt == Date(2002, 06, 03))
            ||
            # Substitute date for Spring Bank Holiday
            (dt == Date(2002, 06, 04))
            ||
            # Wedding of Prince William and Catherine Middleton
            (dt == Date(2011, 04, 29))
            )
            return true
        end
    end

    return false
end
