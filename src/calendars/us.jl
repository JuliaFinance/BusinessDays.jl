
# United States calendars

"""
United States federal holidays.
"""
struct USSettlement <: HolidayCalendar end
const UnitedStates = USSettlement

"""
United States NYSE holidays.
"""
struct USNYSE <: HolidayCalendar end

"""
United States Government Bond calendar.
"""
struct USGovernmentBond <: HolidayCalendar end

function isholiday(::USSettlement , dt::Dates.Date)

    yy = Dates.year(dt)
    mm = Dates.month(dt)
    dd = Dates.day(dt)

    if (
            # New Year's Day
            adjustweekendholidayUS(Dates.Date(yy, 1, 1)) == dt
            ||
            # New Year's Day on the previous year when 1st Jan is Saturday
            (mm == 12 &&  dd == 31 && Dates.dayofweek(dt) == Dates.Friday)
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
            adjustweekendholidayUS(Dates.Date(yy, 7, 4)) == dt
            ||
            # Labor Day
            adjustweekendholidayUS(findweekday(Dates.Monday, yy, 9, 1, true)) == dt
            ||
            # Columbus Day
            adjustweekendholidayUS(findweekday(Dates.Monday, yy, 10, 2, true)) == dt
            ||
            # Veterans Day
            adjustweekendholidayUS(Dates.Date(yy, 11, 11)) == dt
            ||
            # Thanksgiving Day
            adjustweekendholidayUS(findweekday(Dates.Thursday, yy, 11, 4, true)) == dt
            ||
            # Christmas
            adjustweekendholidayUS(Dates.Date(yy, 12, 25)) == dt
        )
        return true
    end

    return false
end

function isholiday(::USNYSE , dt::Dates.Date)

    yy = Dates.year(dt)
    mm = Dates.month(dt)
    dd = Dates.day(dt)

    dt_rata::Int = Dates.days(dt)
    e_rata::Int = easter_rata(Dates.Year(yy))

    if (
            # New Year's Day
            adjustweekendholidayUS(Dates.Date(yy, 1, 1)) == dt
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
            adjustweekendholidayUS(Dates.Date(yy, 7, 4)) == dt
            ||
            # Labor Day
            adjustweekendholidayUS(findweekday(Dates.Monday, yy, 9, 1, true)) == dt
            ||
            # Thanksgiving Day
            adjustweekendholidayUS(findweekday(Dates.Thursday, yy, 11, 4, true)) == dt
            ||
            # Christmas
            adjustweekendholidayUS(Dates.Date(yy, 12, 25)) == dt
        )
        return true
    end

    # Presidential election days
    if (yy <= 1968 || (yy <= 1980 && yy % 4 == 0)) && mm == 11 && dd <= 7 && Dates.istuesday(dt)
        return true
    end

    # Special Closings
    if (
        # President George H.W. Bush's funeral
        dt == Dates.Date(2018,12,5)
        ||
        # Hurricane Sandy
        yy == 2012 && mm == 10 && (dd == 29 || dd == 30)
        ||
        # Predient Ford's funeral
        dt == Dates.Date(2007,1,2)
        ||
        # President Reagan's funeral
        dt == Dates.Date(2004,6,11)
        ||
        # Sep 11th
        yy == 2001 && mm == 9 && ( 11 <= dd && dd <= 14)
        ||
        # President Nixon's funeral
        dt == Dates.Date(1994,4,27)
        ||
        # Hurricane Gloria
        dt == Dates.Date(1985,9,27)
        ||
        # 1977 Blackout
        dt == Dates.Date(1977,7,14)
        ||
        # Funeral of former President Lyndon B. Johnson
        dt == Dates.Date(1973,1,25)
        ||
        # Funeral of former President Harry S. Truman
        dt == Dates.Date(1972,12,28)
        ||
        # National Day of Participation for the lunar exploration
        dt == Dates.Date(1969,7,21)
        ||
        # Eisenhower's funeral
        dt == Dates.Date(1969,3,31)
        ||
        # Heavy snow
        dt == Dates.Date(1969,2,10)
        ||
        # Day after Independence Day
        dt == Dates.Date(1968,7,5)
        ||
        # Paperwork Crisis
        yy == 1968 && Dates.dayofyear(dt) >= 163 && Dates.iswednesday(dt)
        ||
        # Mourning for Martin Luther King Jr
        dt == Dates.Date(1968,4,9)
        ||
        # President Kennedy's funeral
        dt == Dates.Date(1963,11,25)
        ||
        # Day before Decoration Day
        dt == Dates.Date(1961,5,29)
        ||
        # Day after Christmas
        dt == Dates.Date(1958,12,26)
        ||
        # Christmas Eve
        dt in [Dates.Date(1954,12,24), Dates.Date(1956,12,24), Dates.Date(1965,12,24)]
        )
        return true
    end

    return false
end

function isholiday(::USGovernmentBond , dt::Dates.Date)

    yy = Dates.year(dt)
    mm = Dates.month(dt)
    dd = Dates.day(dt)

    dt_rata::Int = Dates.days(dt)
    e_rata::Int = easter_rata(Dates.Year(yy))

    if (
            # New Year's Day
            adjustweekendholidayUS(Dates.Date(yy, 1, 1)) == dt
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
            adjustweekendholidayUS(Dates.Date(yy, 7, 4)) == dt
            ||
            # Labor Day
            adjustweekendholidayUS(findweekday(Dates.Monday, yy, 9, 1, true)) == dt
            ||
            # Columbus Day
            adjustweekendholidayUS(findweekday(Dates.Monday, yy, 10, 2, true)) == dt
            ||
            # Veterans Day
            adjustweekendholidayUS(Dates.Date(yy, 11, 11)) == dt
            ||
            # Thanksgiving Day
            adjustweekendholidayUS(findweekday(Dates.Thursday, yy, 11, 4, true)) == dt
            ||
            # Christmas
            adjustweekendholidayUS(Dates.Date(yy, 12, 25)) == dt
        )
        return true
    end

    return false
end
