
"""
Public holidays for the German states.
Although some holidays are common to all states, such as Easter and Christmas,
each state also has its own additional holidays. The only national holiday is the
Day of German Unity.
The set of relevant holidays depends about which state you are concerned.

The German states are:
- Baden-Württemberg (BW)
- Bavaria (BY)
- Berlin (BE)
- Brandenburg (BB)
- Bremen (HB)
- Hamburg (HH)
- Hessen (HE)
- Mecklenburg-Vorpommern (MV)
- Lowwer Saxony (NI)
- North Rhine-Westphalia (NW)
- Rhineland-Palatinate (RP)
- Saarland (SL)
- Saxony (SN)
- Saxony-Anhalt (ST)
- Schleswig-Holstein (SH)
- Thuringia (TH)

For example: `cal = Germany(:BW)` or `cal = DE(:BW)`
"""
struct Germany <: HolidayCalendar
    state::Symbol

    function Germany(state::Symbol)
        states = Set([:BW, :BY, :BYP, :BE, :BB, :HB, :HH, :HE, :MV, :NI, :NW, :RP, :SL, :SN, :ST, :SH, :TH])
        @assert state ∈ states "$(state) is not a valid German state. Choose from: :BW, :BY, :BYP, :BE, :BB, :HB, :HH, :HE, :MV, :NI, :NW, :RP, :SL, :SN, :ST, :SH, :TH."
        new(state)
    end
end
const DE = Germany


"""
    isholiday(cal::DE, dt::Dates.Date)::Bool

Return true if `dt` is a is a holiday in the German calender (`cal`), otherwise false.
"""
function isholiday(cal::DE, dt::Dates.Date)::Bool
    dt ≤ Dates.Date(1990, 10, 3) && return false # Only count holidays after German Reunification
    yy = Dates.year(dt)
    mm = Dates.month(dt)
    dd = Dates.day(dt)
    easter_sunday = BusinessDays.easter_date(Dates.Year(yy))
    is_common_german_holiday(dt, yy, mm, dd, easter_sunday) && return true
    is_german_state_holiday(Val{cal.state}, dt, yy, mm, dd, easter_sunday)
end


################################################################################


"""
    is_common_german_holiday(dt::Dates.Date, yy::Int, mm::Int, dd::Int, easter_sunday::Dates.Date)::Bool

Return true if `dt` (with its parts `yy` - year, `mm` - month, `dd` -day) is a is a holiday
in the calender of all of Germany (`cal`), otherwise false.
"""
function is_common_german_holiday(dt::Dates.Date, yy::Int, mm::Int, dd::Int, easter_sunday::Dates.Date)::Bool

    mm ==  1 && dd ==  1 && return true                # New year's day
    mm ==  5 && dd ==  1 && return true                # International Workers' Day
    dt == easter_sunday - Dates.Day(2) && return true  # Good Friday
    dt == easter_sunday + Dates.Day(1) && return true  # Easter Monday
    dt == easter_sunday + Dates.Day(39) && return true # Ascension Day
    dt == easter_sunday + Dates.Day(50) && return true # Pentecost Monday
    mm == 10 && dd ==  3 && return true                # German Unity Day
    mm == 10 && dd == 31 && yy == 2017 && return true  # 500 years Reformation
    mm == 12 && dd == 25 && return true                # Christmas Day
    mm == 12 && dd == 26 && return true                # Boxing Day
    mm == 11 && dd == day_of_repentance_and_prayer(yy) &&
        yy ≤ 1994 && return true                       # Day of Repentance and Prayer

    return false
end


"""
    function is_german_state_holiday(
        ::Union{Type{Val{:HB}},Type{Val{:HH}},Type{Val{:NI}},Type{Val{:SH}}},
        dt::Dates.Date, yy::Int, mm::Int, dd::Int, easter_sunday::Dates.Date
    )::Bool

Return true if `dt` (with its parts `yy` - year, `mm` - month, `dd` -day)
is a is a holiday in the calender (`cal`) of the German states
Bremen, Hamburg, Lower Saxony or Schleswig-Holstein, otherwise false.
"""
function is_german_state_holiday(
    ::Union{Type{Val{:HB}},Type{Val{:HH}},Type{Val{:NI}},Type{Val{:SH}}},
    dt::Dates.Date, yy::Int, mm::Int, dd::Int, easter_sunday::Dates.Date
)::Bool
    mm == 31 && dd == 10 && yy ≥ 2017 && return true   # Reformation Day
    return false
end


"""
    function is_german_state_holiday(
        ::Union{Type{Val{:NW}},Type{Val{:RP}},Type{Val{:SL}}},
        dt::Dates.Date, yy::Int, mm::Int, dd::Int, easter_sunday::Dates.Date
    )::Bool

Return true if `dt` (with its parts `yy` - year, `mm` - month, `dd` -day)
is a is a holiday in the calender (`cal`) of the German states
North Rhine-Westphalia, Rhineland-Palatinate or Saarland, otherwise false.
"""
function is_german_state_holiday(
    cal::T,
    dt::Dates.Date, yy::Int, mm::Int, dd::Int, easter_sunday::Dates.Date
)::Bool where T <: Union{Type{Val{:NW}},Type{Val{:RP}},Type{Val{:SL}}}
    mm == 11 && dd ==  1  && return true                        # All Saints' Day
    dt == easter_sunday + Dates.Day(60) && return true          # Corpus Christi
    mm == 8 && dd == 15 && cal <: Val{:SL} && return true   # Assumption of Mary
    return false
end


"""
    function is_german_state_holiday(
        ::Union{Type{Val{:NW}},Type{Val{:RP}},Type{Val{:SL}}},
        dt::Dates.Date, yy::Int, mm::Int, dd::Int, easter_sunday::Dates.Date
    )::Bool

Return true if `dt` (with its parts `yy` - year, `mm` - month, `dd` -day)
is a is a holiday in the calender (`cal`) of the German states
Baden-Württemberg or Bavaria (with or without Assumption of Mary), otherwise false.
"""
function is_german_state_holiday(
    cal::T,
    dt::Dates.Date, yy::Int, mm::Int, dd::Int, easter_sunday::Dates.Date
)::Bool where T <: Union{Type{Val{:BW}},Type{Val{:BY}},Type{Val{:BYP}}}
    mm ==  1 && dd ==  6  && return true                        # Epiphany
    mm == 11 && dd ==  1  && return true                        # All Saints' Day
    dt == easter_sunday + Dates.Day(60) && return true          # Corpus Christi
    mm == 8 && dd == 15 && cal <: Val{:BY} && return true       # Assumption of Mary
                                                                # (only catholic communities in Bavaria)
    return false
end


"""
    function is_german_state_holiday(
        ::Type{Val{:BE}},
        dt::Dates.Date, yy::Int, mm::Int, dd::Int, easter_sunday::Dates.Date
    )::Bool

Return true if `dt` (with its parts `yy` - year, `mm` - month, `dd` -day)
is a is a holiday in the calender (`cal`) of the German state Berlin, otherwise false.
"""
function is_german_state_holiday(
    ::Type{Val{:BE}},
    dt::Dates.Date, yy::Int, mm::Int, dd::Int, easter_sunday::Dates.Date
)::Bool
    mm ==  3 && dd == 8 && yy ≥  2019   && return true  # Womens' Day
    # 75. Jahrestag zur Befreiung des Nationalsozialismus:
    mm ==  5 && dd == 8 && yy == 2020   && return true

    return false
end


"""
    function is_german_state_holiday(
        ::Type{Val{:BB}},
        dt::Dates.Date, yy::Int, mm::Int, dd::Int, easter_sunday::Dates.Date
    )::Bool

Return true if `dt` (with its parts `yy` - year, `mm` - month, `dd` -day)
is a is a holiday in the calender (`cal`) of the German state Brandenburg,
otherwise false.
"""
function is_german_state_holiday(
    ::Type{Val{:BB}},
    dt::Dates.Date, yy::Int, mm::Int, dd::Int, easter_sunday::Dates.Date
)::Bool
    mm == 10 && dd == 31 && yy ≥ 2019   && return true          # Reformation Day
    dt == easter_sunday                 && return true          # Easter Sunday
    dt == easter_sunday + Dates.Day(49) && return true          # Pentecost Sunday
    return false
end


"""
    function is_german_state_holiday(
        ::Type{Val{:HE}},
        dt::Dates.Date, yy::Int, mm::Int, dd::Int, easter_sunday::Dates.Date
    )::Bool

Return true if `dt` (with its parts `yy` - year, `mm` - month, `dd` -day)
is a is a holiday in the calender (`cal`) of the German state Hessen,
otherwise false.
"""
function is_german_state_holiday(
    ::Type{Val{:HE}},
    dt::Dates.Date, yy::Int, mm::Int, dd::Int, easter_sunday::Dates.Date
)::Bool
    dt == easter_sunday + Dates.Day(60) && return true          # Corpus Christi
    return false
end


"""
    function is_german_state_holiday(
        ::Type{Val{:MV}},
        dt::Dates.Date, yy::Int, mm::Int, dd::Int, easter_sunday::Dates.Date
    )::Bool

Return true if `dt` (with its parts `yy` - year, `mm` - month, `dd` -day)
is a is a holiday in the calender (`cal`) of the German state Mecklenburg-Vorpommern,
otherwise false.
"""
function is_german_state_holiday(
    ::Type{Val{:MV}},
    dt::Dates.Date, yy::Int, mm::Int, dd::Int, easter_sunday::Dates.Date
)::Bool
    mm == 10 && dd == 31 && return true                 # Reformation Day
    mm ==  3 && dd == 08 && yy ≥ 2023   && return true  # Womens' Day

    return false
end


"""
    function is_german_state_holiday(
        ::Type{Val{:SN}},
        dt::Dates.Date, yy::Int, mm::Int, dd::Int, easter_sunday::Dates.Date
    )::Bool

Return true if `dt` (with its parts `yy` - year, `mm` - month, `dd` -day)
is a is a holiday in the calender (`cal`) of the German state Saxony,
otherwise false.
"""
function is_german_state_holiday(
    ::Type{Val{:SN}},
    dt::Dates.Date, yy::Int, mm::Int, dd::Int, easter_sunday::Dates.Date
)::Bool
    mm == 10 && dd == 31 && return true  # Reformation Day
    # Day of Repentance and Prayer:
    mm == 11 && dd == day_of_repentance_and_prayer(yy) && return true

    return false
end


"""
    function is_german_state_holiday(
        ::Type{Val{:ST}},
        dt::Dates.Date, yy::Int, mm::Int, dd::Int, easter_sunday::Dates.Date
    )::Bool

Return true if `dt` (with its parts `yy` - year, `mm` - month, `dd` -day)
is a is a holiday in the calender (`cal`) of the German state Saxony-Anhalt,
otherwise false.
"""
function is_german_state_holiday(
    ::Type{Val{:ST}},
    dt::Dates.Date, yy::Int, mm::Int, dd::Int, easter_sunday::Dates.Date
)::Bool
    mm ==  1 && dd ==  6 && return true  # Epiphany
    mm == 10 && dd == 31 && return true  # Reformation Day

    return false
end


"""
    function is_german_state_holiday(
        ::Type{Val{:TH}},
        dt::Dates.Date, yy::Int, mm::Int, dd::Int, easter_sunday::Dates.Date
    )::Bool

Return true if `dt` (with its parts `yy` - year, `mm` - month, `dd` -day)
is a is a holiday in the calender (`cal`) of the German state Thuringia,
otherwise false.
"""
function is_german_state_holiday(
    ::Type{Val{:TH}},
    dt::Dates.Date, yy::Int, mm::Int, dd::Int, easter_sunday::Dates.Date
)::Bool
    mm ==  9 && dd == 20 && yy ≥ 2019 && return true  # Children's Day
    mm == 10 && dd == 31 && return true               # Reformation Day

    return false
end


const DE_BW = DE(:BW)
const DE_BY = DE(:BY)
const DE_BYP = DE(:BYP)
const DE_BE = DE(:BE)
const DE_BB = DE(:BB)
const DE_HB = DE(:HB)
const DE_HH = DE(:HH)
const DE_HE = DE(:HE)
const DE_MV = DE(:MV)
const DE_NI = DE(:NI)
const DE_NW = DE(:NW)
const DE_RP = DE(:RP)
const DE_SL = DE(:SL)
const DE_SN = DE(:SN)
const DE_ST = DE(:ST)
const DE_SH = DE(:SH)
const DE_TH = DE(:TH)

function day_of_repentance_and_prayer(yy::Int)::Int
    drange = Dates.Date(yy,11,16):Dates.Day(1):Dates.Date(yy,11,22)
    return Dates.day(drange[findfirst(isequal.(Dates.dayofweek.(drange),3))])
end
