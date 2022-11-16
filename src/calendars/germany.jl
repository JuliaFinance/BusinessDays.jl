"""
Common holidays in all of Germany.
"""
abstract type GER <: HolidayCalendar end
struct DE <: GER end
const Germany = DE


# Holiday structs for German regions

"""
State-wide holidays for Baden-Württemberg and Bavaria.
"""
abstract type DE_SOUTH <: GER end


"""
State-wide holidays for Baden-Württemberg.
"""
struct DE_BYP <: DE_SOUTH end


"""
State-wide holidays for Bavaria.
"""
struct DE_BW <: DE_SOUTH end


"""
Holidays for Catholic communities in Bavaria (including Assumption of Mary).
"""
struct DE_BY <: DE_SOUTH end


"""
Holidays for Berlin.
"""
struct DE_BE <: GER end


"""
Holidays for Brandenburg.
"""
struct DE_BB <: GER end


"""
Holidays for Bremen, Hamburg, Lower Saxony, and Schleswig-Holstein.
"""
abstract type DE_NORTH <: GER end


"""
Holidays for Bremen.
"""
struct DE_HB <: DE_NORTH end


"""
Holidays for Hamburg.
"""
struct DE_HH <: DE_NORTH end


"""
Holidays for Lower Saxony.
"""
struct DE_NI <: DE_NORTH end


"""
Holidays for Schleswig-Holstein.
"""
struct DE_SH <: DE_NORTH end


"""
Holidays for Hessen.
"""
struct DE_HE <: GER end


"""
Holidays for Mecklenburg-Vorpommern.
"""
struct DE_MV <: GER end


"""
Common holidays for North Rhine-Westphalia Rhineland-Palatinate, and Saarland.
"""
abstract type DE_WEST <: GER end


"""
Holidays for North Rhine-Westphalia.
"""
struct DE_NW <: DE_WEST end


"""
Holidays for Rhineland-Palatinate.
"""
struct DE_RP <: DE_WEST end


"""
Holidays for Saarland.
"""
struct DE_SL <: DE_WEST end


"""
State-wide holidays for Saxony.
"""
struct DE_SN <: GER end


"""
Holidays for Saxony-Anhalt.
"""
struct DE_ST <: GER end


"""
Holidays for Thuringia.
"""
struct DE_TH <: GER end


function isholiday(cal::T, dt::Dates.Date) where T<:GER
    yy = Dates.year(dt)
    mm = Dates.month(dt)
    dd = Dates.day(dt)

    # Bisection
    if mm < 8 && dt ≥ Dates.Date(1990, 10, 3)
        # Fixed Holidays
        if (
            # New Year's Day
            (mm == 1 && dd == 1)
            ||
            # Epiphany (BW, BY, ST)
            (mm == 1 && dd == 6 && T <: Union{DE_SOUTH, DE_ST})
            ||
            # International Women's Day (BE)
            (yy >= 2019 && mm == 3 && dd == 8 && T <: DE_BE)
            ||
            # International Women's Day (MC)
            (yy >= 2023 && mm == 3 && dd == 8 && T <: DE_MV)
            ||
            # International Workers' Day
            (mm == 5 && dd == 1)
            ||
            # 75. Jahrestag zur Befreiung des Nationalsozialismus
            (yy == 2020 && mm == 5 && dd == 8 && T <: DE_BE)
            )
            return true
        end

        # Holidays in relation to Easter
        dt_rata::Int = Dates.days(dt)
        e_rata::Int = easter_rata(Dates.Year(yy))

        if (
            # Good Friday
            (dt_rata ==  e_rata -  2)
            ||
            # Easter Sunday (BB)
            (dt_rata == e_rata && T <: DE_BB)
            ||
            # Easter Monday
            (dt_rata == e_rata + 1)
            ||
            # Ascension Day
            (dt_rata == e_rata + 39)
            ||
            # Pentecost Sunday (BB)
            (dt_rata == e_rata + 49 && T <: DE_BB)
            ||
            # Pentecost Monday
            (dt_rata == e_rata + 50)
            ||
            # Corpus Christi (BW, BY, HE, NW, RP, SL; parts of SN, TH not considered)
            (dt_rata == e_rata + 60 && T <: Union{DE_SOUTH, DE_HE, DE_WEST})
            )
            return true
        end
    elseif dt ≥ Dates.Date(1990, 10, 3)
        # mm >= 8
        if (
            # Assumption of Mary (BY, SL)
            (mm == 8 && dd == 15 && T <: Union{DE_BY, DE_SL})
            ||
            # Children's Day (TH)
            (yy >= 2019 && mm == 9 && dd == 20 && T <: DE_TH)
            ||
            # German Unity Day
            (mm == 10 && dd == 3)
            ||
            # Reformation Day (BB, MV, SN, ST, TH)
            (mm == 10 && dd == 31 && T <: Union{DE_BB, DE_MV, DE_SN, DE_ST, DE_TH})
            ||
            # Reformation Day (HB, HH, NI, SH since 2017)
            (yy >= 2017 && mm == 10 && dd == 31 && T <: DE_NORTH)
            ||
            # 500 years Reformation: common holiday in whole Germany
            (yy == 2017)
            ||
            # All Saints' Day (BW, BY, NW, RP, SL)
            (mm == 11 && dd == 1 && T <: Union{DE_SOUTH, DE_WEST})
            ||
            # Day of Repentance and Prayer (SN)
            (mm == 11 && dd == day_of_repentance_and_prayer(yy) && (T <: DE_SN || yy <= 1994))
            ||
            # Christmas
            (mm == 12 && dd == 25)
            ||
            # Day of Goodwill
            (mm == 12 && dd == 26)
            )
            return true
        end
    end

    return false
end


function day_of_repentance_and_prayer(yy::Int)::Int
    drange = Dates.Date(yy,11,16):Dates.Day(1):Dates.Date(yy,11,22)
    return Dates.day(drange[findfirst(isequal.(Dates.dayofweek.(drange),3))])
end
