
"""
Public holidays for the Australian Stock Exchange (ASX).
"""
struct AustraliaASX <: HolidayCalendar end


"""
Public holidays for the Australian states and territories.
Although some holidays are common to all states and territories, such as Christmas Day, each state and territory also has its own additional holidays.
Therefore the set of relevant holidays depends on which state/territory you are concerned with.

The Australian states and territories are:
- Australian Capital Territory (ACT)
- New South Wales (NSW)
- Northern Territory (NT)
- Queensland (QLD)
- South Australia (SA)
- Tasmania (TAS)
- Western Australia (WA)
- Victoria (VIC)

For example: cal = Australia(:QLD)
"""
struct Australia <: HolidayCalendar
    state::Symbol
    function Australia(state::Symbol)
        states = Set([:ACT, :NSW, :NT, :QLD, :SA, :TAS, :WA, :VIC])
        @assert state ∈ states "$(state) is not a valid Australian state or territory. Must be one of :ACT, :NSW, :NT, :QLD, :SA, :TAS, :WA, :VIC."
        new(state)
    end
end


function isholiday(::AustraliaASX, dt::Date)
    yy = year(dt)
    mm = month(dt)
    dd = day(dt)
    easter_sunday = BusinessDays.easter_date(Year(yy))
    is_australian_national_holiday(dt, yy, mm, dd, easter_sunday) && return true
    mm == 6 && dayofweek(dt) == Mon && dayofweekofmonth(dt) == 2 && return true # Queen's Birthday holiday (2nd Monday of June)
    false
end


function isholiday(cal::Australia, dt::Date)
    yy = year(dt)
    mm = month(dt)
    dd = day(dt)
    easter_sunday = BusinessDays.easter_date(Year(yy))
    is_australian_national_holiday(dt, yy, mm, dd, easter_sunday) && return true
    is_australian_state_holiday(Val{cal.state}, dt, yy, mm, dd, easter_sunday)
end


################################################################################
function is_australian_national_holiday(dt::Date, yy::Int, mm::Int, dd::Int, easter_sunday::Date)
    mm == 1  && dd == 1  && return true  # New year's day
    mm == 1  && dd == 26 && return true  # Australia Day
    mm == 4  && dd == 25 && return true  # ANZAC Day
    mm == 12 && dd == 25 && return true  # Christmas Day
    mm == 12 && dd == 26 && return true  # Boxing Day
    dt == easter_sunday - Day(2) && return true  # Good Friday
    dt == easter_sunday + Day(1) && return true  # Easter Monday
    false
end


function is_australian_state_holiday(::Type{Val{:ACT}}, dt::Date, yy::Int, mm::Int, dd::Int, easter_sunday::Date)
    dt == easter_sunday - Day(1) && return true  # Easter Saturday
    dt == easter_sunday          && return true  # Easter Sunday
    mm == 3  && dayofweek(dt) == Mon && dayofweekofmonth(dt) == 2 && return true # Canberra Day (2nd Monday of March)
    mm == 6  && dayofweek(dt) == Mon && dayofweekofmonth(dt) == 2 && return true # Queen's Birthday holiday (2nd Monday of June)
    mm == 10 && dayofweek(dt) == Mon && dayofweekofmonth(dt) == 1 && return true # Labour Day (1st Monday of October)
    if yy >= 2018 && mm == 5  # Reconciliation Day (Last Monday of May)
        first_june   = Date(yy, 6, 1)
        last_mon_may = toprev(first_june, Mon)
        dt == last_mon_may && return true
    end
    false
end


function is_australian_state_holiday(::Type{Val{:NSW}}, dt::Date, yy::Int, mm::Int, dd::Int, easter_sunday::Date)
    dt == easter_sunday - Day(1) && return true  # Easter Saturday
    dt == easter_sunday          && return true  # Easter Sunday
    mm == 6  && dayofweek(dt) == Mon && dayofweekofmonth(dt) == 2 && return true # Queen's Birthday holiday (2nd Monday of June)
    mm == 8  && dayofweek(dt) == Mon && dayofweekofmonth(dt) == 1 && return true # Bank holiday (1st Monday of August)
    mm == 10 && dayofweek(dt) == Mon && dayofweekofmonth(dt) == 1 && return true # Labour Day (1st Monday of October)
    false
end


function is_australian_state_holiday(::Type{Val{:NT}}, dt::Date, yy::Int, mm::Int, dd::Int, easter_sunday::Date)
    dt == easter_sunday - Day(1) && return true  # Easter Saturday (Easter Sunday is not a public holiday in the Northern Territory)
    mm == 5  && dayofweek(dt) == Mon && dayofweekofmonth(dt) == 1 && return true # May Day (1st Monday of May)
    mm == 6  && dayofweek(dt) == Mon && dayofweekofmonth(dt) == 2 && return true # Queen's Birthday holiday (2nd Monday of June)
    mm == 8  && dayofweek(dt) == Mon && dayofweekofmonth(dt) == 1 && return true # Picnic Day (1st Monday of August)
    false
end


function is_australian_state_holiday(::Type{Val{:QLD}}, dt::Date, yy::Int, mm::Int, dd::Int, easter_sunday::Date)
    dt == easter_sunday - Day(1) && return true  # Easter Saturday
    dt == easter_sunday          && return true  # Easter Sunday
    mm == 5  && dayofweek(dt) == Mon && dayofweekofmonth(dt) == 1 && return true # Labour Day (1st Monday of May)

    # Royal Brisbane Show (Brisbane area only).
    if mm == 8 && dayofweek(dt) == Wed
        end_aug      = Date(yy, 8, 31)
        last_wed_aug = dayofweek(end_aug) == Wed ? end_aug : toprev(end_aug, Wed)
        n_wed_in_aug = day(last_wed_aug) >= 29 ? 5 : 4
        n_wed_in_aug == 4 && dayofweekofmonth(dt) == 2 && return true  # 2nd Wednesday of August if there are 4 Wednesdays in August
        n_wed_in_aug == 5 && dayofweekofmonth(dt) == 3 && return true  # 3rd Wednesday of August if there are 5 Wednesdays in August
    end

    # Queen's Birthday holiday
    if yy == 2012 || yy >= 2016
        mm == 10 && dayofweek(dt) == Mon && dayofweekofmonth(dt) == 1 && return true # 1st Monday of October
    else
        mm == 6  && dayofweek(dt) == Mon && dayofweekofmonth(dt) == 2 && return true # 2nd Monday of June
    end
    false
end


function is_australian_state_holiday(::Type{Val{:SA}}, dt::Date, yy::Int, mm::Int, dd::Int, easter_sunday::Date)
    dt == easter_sunday - Day(1) && return true  # Easter Saturday (Easter Sunday is not a public holiday in South Australia)
    mm == 3  && dayofweek(dt) == Mon && dayofweekofmonth(dt) == 2 && return true # March public holiday (2nd Monday of March)
    mm == 6  && dayofweek(dt) == Mon && dayofweekofmonth(dt) == 2 && return true # Queen's Birthday holiday (2nd Monday of June)
    mm == 10 && dayofweek(dt) == Mon && dayofweekofmonth(dt) == 1 && return true # Labour Day (1st Monday of October)
    false
end


function is_australian_state_holiday(::Type{Val{:TAS}}, dt::Date, yy::Int, mm::Int, dd::Int, easter_sunday::Date)
    # Neither Easter Saturday nor Easter Sunday are public holidays in Tasmania
    mm == 2  && dayofweek(dt) == Mon && dayofweekofmonth(dt) == 2 && return true # Royal Hobart Regatta (2nd Monday of February)
    mm == 3  && dayofweek(dt) == Mon && dayofweekofmonth(dt) == 2 && return true # Labour Day (2nd Monday of March)
    mm == 6  && dayofweek(dt) == Mon && dayofweekofmonth(dt) == 2 && return true # Queen's Birthday holiday (2nd Monday of June)
    mm == 11 && dayofweek(dt) == Mon && dayofweekofmonth(dt) == 1 && return true # Recreation Day (1st Monday of November)
    false
end


function is_australian_state_holiday(::Type{Val{:WA}}, dt::Date, yy::Int, mm::Int, dd::Int, easter_sunday::Date)
    # Neither Easter Saturday nor Easter Sunday are public holidays in Western Australia
    mm == 3  && dayofweek(dt) == Mon && dayofweekofmonth(dt) == 1 && return true # Labour Day (1st Monday of March)
    mm == 6  && dayofweek(dt) == Mon && dayofweekofmonth(dt) == 1 && return true # Western Australia Day (1st Monday of June)

    # Queen's Birthday holiday (proclaimed each year by the Governor, usually the last Monday of September)
    if yy == 2011
        mm == 10 && dd == 28 && return true
    elseif yy == 2012
        mm == 10 && dd == 1 && return true
    else
        end_sep      = Date(yy, 9, 30)
        last_mon_sep = dayofweek(end_sep) == Mon ? end_sep : toprev(end_sep, Mon)
        dt == last_mon_sep && return true
    end
    false
end


function is_australian_state_holiday(::Type{Val{:VIC}}, dt::Date, yy::Int, mm::Int, dd::Int, easter_sunday::Date)
    dt == easter_sunday - Day(1) && return true  # Easter Saturday
    dt == easter_sunday          && return true  # Easter Sunday
    mm == 3  && dayofweek(dt) == Mon && dayofweekofmonth(dt) == 2 && return true # Labour Day (2nd Monday of March)
    mm == 6  && dayofweek(dt) == Mon && dayofweekofmonth(dt) == 2 && return true # Queen's Birthday holiday (2nd Monday of June)
    mm == 11 && dayofweek(dt) == Tue && dayofweekofmonth(dt) == 1 && return true # Melbourne Cup (1st Tuesday of November)
    if yy >= 2015 && dayofweek(dt) == Fri && (mm == 9 || mm == 10)               # Friday before AFL Grand Final (Friday closest to 30th September)
        first_oct     = Date(yy, 10, 1)  # 1st October
        first_sat_oct = dayofweek(first_oct) == Sat ? first_oct     : tonext(first_oct, Sat)  # 1st Saturday in October
        afl_final     = day(first_sat_oct)   <= 4   ? first_sat_oct : first_sat_oct - Day(7)
        dt == afl_final - Day(1) && return true
    end
    false
end
