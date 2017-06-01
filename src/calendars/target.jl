
"""
Holidays for TARGET Eurozone (Trans-European Automated Real-time Gross Settlement Express Transfer System)
"""
type TARGET <: HolidayCalendar end

function isholiday(::TARGET, dt::Date)
    const yy = Dates.year(dt)
    const mm = Dates.month(dt)
    const dd = Dates.day(dt)

    # Bisection
    if mm < 8
        # Fixed Holidays
        if (
            # New Year's Day
            ((mm == 1) && (dd == 1))
            ||
            # Labour Day
            ((mm == 5) && (dd == 1) && (yy >= 2000))
            )
            return true
        end

        if yy >= 2000

            const dt_rata::Int = Dates.days(dt)
            const e_rata::Int = easter_rata(Dates.Year(yy))
            
            if (
                # Good Friday
                ( dt_rata == ( e_rata -  2 ))
                ||
                # Easter Monday
                ( dt_rata == ( e_rata + 1))
                )
                return true
            end
        end
    else
        # mm >= 8
        if (
            # Christmas
            ((mm == 12) && (dd == 25))
            ||
            # Day of Goodwill
            ((mm == 12) && (dd == 26) && (yy >= 2000))
            ||
            # End of year
            ((mm == 12) && (dd == 31) && (yy == 1998 || yy == 1999 || yy == 2001))
            )
            return true
        end
    end

    return false
end
