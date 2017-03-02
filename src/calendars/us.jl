
# United States calendars

"""
United States federal holidays.
"""
type USSettlement <: HolidayCalendar end

const UnitedStates = USSettlement

"""
United States NYSE holidays.
"""
type USNYSE <: HolidayCalendar end

"""
United States Government Bond calendar.
"""
type USGovernmentBond <: HolidayCalendar end

function isholiday(::USSettlement , dt::Date)

    const yy = Dates.year(dt)
    const mm = Dates.month(dt)
    const dd = Dates.day(dt)

    if (
            # New Year's Day
            adjustweekendholidayUS(Date(yy, 1, 1)) == dt
            ||
            # New Year's Day on the previous year when 1st Jan is Saturday
            (mm == 12 &&  dd == 31 && dayofweek(dt) == Friday)
            ||
            # Birthday of Martin Luther King, Jr.
            (yy >= 1983 && adjustweekendholidayUS(findweekday(Dates.Monday, yy, 1, 3, true)) == dt)
            ||
            # Washington's Birthday
            adjustweekendholidayUS(findweekday(Dates.Monday, yy, 2, 3, true)) == dt
            ||
            # Memorial Day
            adjustweekendholidayUS(findweekday(Dates.Monday, yy, 5, 1, false)) == dt
            ||
            # Independence Day
            adjustweekendholidayUS(Date(yy, 7, 4)) == dt
            ||
            # Labor Day
            adjustweekendholidayUS(findweekday(Dates.Monday, yy, 9, 1, true)) == dt
            ||
            # Columbus Day
            adjustweekendholidayUS(findweekday(Dates.Monday, yy, 10, 2, true)) == dt
            ||
            # Veterans Day
            adjustweekendholidayUS(Date(yy, 11, 11)) == dt
            ||
            # Thanksgiving Day
            adjustweekendholidayUS(findweekday(Dates.Thursday, yy, 11, 4, true)) == dt
            ||
            # Christmas
            adjustweekendholidayUS(Date(yy, 12, 25)) == dt
        )
        return true
    end

    return false
end

function isholiday(::USNYSE , dt::Date)

    const yy = Dates.year(dt)
    const mm = Dates.month(dt)
    const dd = Dates.day(dt)

    const dt_rata::Int = Dates.days(dt)
    const e_rata::Int = easter_rata(Dates.Year(yy))

    if (
            # New Year's Day
            adjustweekendholidayUS(Date(yy, 1, 1)) == dt
            ||
            # Birthday of Martin Luther King, Jr.
            (yy >= 1998 && adjustweekendholidayUS(findweekday(Dates.Monday, yy, 1, 3, true)) == dt)
            ||
            # Washington's Birthday
            adjustweekendholidayUS(findweekday(Dates.Monday, yy, 2, 3, true)) == dt
            ||
            # Good Friday
            dt_rata == ( e_rata - 2 )
            ||
            # Memorial Day
            adjustweekendholidayUS(findweekday(Dates.Monday, yy, 5, 1, false)) == dt
            ||
            # Independence Day
            adjustweekendholidayUS(Date(yy, 7, 4)) == dt
            ||
            # Labor Day
            adjustweekendholidayUS(findweekday(Dates.Monday, yy, 9, 1, true)) == dt
            ||
            # Thanksgiving Day
            adjustweekendholidayUS(findweekday(Dates.Thursday, yy, 11, 4, true)) == dt
            ||
            # Christmas
            adjustweekendholidayUS(Date(yy, 12, 25)) == dt
        )
        return true
    end

    # Presidential election days
    if (yy <= 1968 || (yy <= 1980 && yy % 4 == 0)) && mm == 11 && dd <= 7 && Dates.istuesday(dt)
        return true
    end

    # Special Closings
    if (
        # Hurricane Sandy
        yy == 2012 && mm == 10 && (dd == 29 || dd == 30)
        ||
        # Predient Ford's funeral
        dt == Date(2007,1,2)
        ||
        # President Reagan's funeral
        dt == Date(2004,6,11)
        ||
        # Sep 11th
        yy == 2001 && mm == 9 && ( 11 <= dd && dd <= 14)
        ||
        # President Nixon's funeral
        dt == Date(1994,4,27)
        ||
        # Hurricane Gloria
        dt == Date(1985,9,27)
        ||
        # 1977 Blackout
        dt == Date(1977,7,14)
        ||
        # Funeral of former President Lyndon B. Johnson
        dt == Date(1973,1,25)
        ||
        # Funeral of former President Harry S. Truman
        dt == Date(1972,12,28)
        ||
        # National Day of Participation for the lunar exploration
        dt == Date(1969,7,21)
        ||
        # Eisenhower's funeral
        dt == Date(1969,3,31)
        ||
        # Heavy snow
        dt == Date(1969,2,10)
        ||
        # Day after Independence Day
        dt == Date(1968,7,5)
        ||
        # Paperwork Crisis
        yy == 1968 && dayofyear(dt) >= 163 && Dates.iswednesday(dt)
        ||
        # Mourning for Martin Luther King Jr
        dt == Date(1968,4,9)
        ||
        # President Kennedy's funeral
        dt == Date(1963,11,25)
        ||
        # Day before Decoration Day
        dt == Date(1961,5,29)
        ||
        # Day after Christmas
        dt == Date(1958,12,26)
        ||
        # Christmas Eve
        dt in [Date(1954,12,24), Date(1956,12,24), Date(1965,12,24)]
        )
        return true
    end

    return false
end

function isholiday(::USGovernmentBond , dt::Date)

    const yy = Dates.year(dt)
    const mm = Dates.month(dt)
    const dd = Dates.day(dt)

    const dt_rata::Int = Dates.days(dt)
    const e_rata::Int = easter_rata(Dates.Year(yy))

    if (
            # New Year's Day
            adjustweekendholidayUS(Date(yy, 1, 1)) == dt
            ||
            # Birthday of Martin Luther King, Jr.
            yy >= 1983 && adjustweekendholidayUS(findweekday(Dates.Monday, yy, 1, 3, true)) == dt
            ||
            # Washington's Birthday
            adjustweekendholidayUS(findweekday(Dates.Monday, yy, 2, 3, true)) == dt
            ||
            # Good Friday
            dt_rata == ( e_rata - 2 )
            ||
            # Memorial Day
            adjustweekendholidayUS(findweekday(Dates.Monday, yy, 5, 1, false)) == dt
            ||
            # Independence Day
            adjustweekendholidayUS(Date(yy, 7, 4)) == dt
            ||
            # Labor Day
            adjustweekendholidayUS(findweekday(Dates.Monday, yy, 9, 1, true)) == dt
            ||
            # Columbus Day
            adjustweekendholidayUS(findweekday(Dates.Monday, yy, 10, 2, true)) == dt
            ||
            # Veterans Day
            adjustweekendholidayUS(Date(yy, 11, 11)) == dt
            ||
            # Thanksgiving Day
            adjustweekendholidayUS(findweekday(Dates.Thursday, yy, 11, 4, true)) == dt
            ||
            # Christmas
            adjustweekendholidayUS(Date(yy, 12, 25)) == dt
        )
        return true
    end

    return false
end
