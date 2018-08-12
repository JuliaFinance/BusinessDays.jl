
"""
    easter_rata(y::Dates.Year) → Int

Returns Easter date as a *[Rata Die](https://en.wikipedia.org/wiki/Rata_Die)* number.

Based on *[Algo R](http://www.linuxtopia.org/online_books/programming_books/python_programming/python_ch38.html)*.
"""
function easter_rata(y::Dates.Year)

    # Algo R only works after 1582
    if y.value < 1582
        # Are you using this? Send me a postcard!
        error("Year cannot be less than 1582. Provided: $(y.value).")
    end

    # Century
    c = div(y.value , 100) + 1

    # Shifted Epact
    local se::Int = mod(14 + 11*(mod(y.value, 19)) - div(3*c, 4) + div(5+8*c, 25), 30)

    # Adjust Epact
    if (se == 0) || ((se == 1) && ( 10 < mod(y.value, 19) ))
       se += 1
    end

    # Paschal Moon
    p = Dates.Date(y.value, 4, 19).instant.periods.value - se

    # Easter: locate the Sunday after the Paschal Moon
    return p + 7 - mod(p, 7)
end

"""
    easter_date(y::Dates.Year) → Dates.Date

Returns result of `easter_rata` as a `Dates.Date` instance.
"""
@inline easter_date(y::Dates.Year) = Dates.Date(Dates.rata2datetime(easter_rata(y)))

"""
    findweekday(weekday_target::Integer, yy::Integer, mm::Integer, occurrence::Integer, ascending::Bool) → Date

Given a year `yy` and month `mm`, finds a date where a choosen weekday occurs.

`weekday_target` values are declared in module `Base.Dates`:
`Monday,Tuesday,Wednesday,Thursday,Friday,Saturday,Sunday = 1,2,3,4,5,6,7`.

If `ascending` is true, searches from the beginning of the month. If false, searches from the end of the month.

If `occurrence` is `2` and `weekday_target` is `Monday`, searches the 2nd Monday of the given month, and so on.
"""
function findweekday(weekday_target::Integer, yy::Integer, mm::Integer, occurrence::Integer, ascending::Bool) :: Dates.Date

    dt = Dates.Date(yy, mm, 1)
    local dt_dayofweek::Integer
    local offset::Integer

    @assert occurrence > 0 "occurrence must be > 0. Provided $(occurrence)."

    if ascending
        dt_dayofweek = Dates.dayofweek(dt)
        offset = mod(weekday_target + 7 - dt_dayofweek, 7)
    else
        dt = Dates.lastdayofmonth(dt)
        dt_dayofweek = Dates.dayofweek(dt)
        offset = mod(dt_dayofweek + 7 - weekday_target, 7)
    end

    if occurrence > 1
        offset += 7 * (occurrence - 1)
    end

    if ascending
        return dt + Dates.Day(offset)
    else
        return dt - Dates.Day(offset)
    end
end

"""

   adjustweekendholidayPost(dt, [adjust_saturdays]) → Date

In the UK and Canada, if a holiday falls on Saturday or Sunday, it's observed on the next business day.
This function will adjust to the next Monday.

`adjust_saturdays` kwarg defaults to `true`.
"""
function adjustweekendholidayPost(dt::Dates.Date; adjust_saturdays::Bool = true) :: Dates.Date

    if adjust_saturdays && (Dates.dayofweek(dt) == Dates.Saturday)
        return dt + Dates.Day(2)
    end

    if Dates.dayofweek(dt) == Dates.Sunday
        return dt + Dates.Day(1)
    end

    return dt
end

"""
    adjustweekendholidayUS(dt) → Date

In the United States, if a holiday falls on Saturday, it's observed on the preceding Friday.
If it falls on Sunday, it's observed on the next Monday.
"""
function adjustweekendholidayUS(dt::Dates.Date) :: Dates.Date

    if Dates.dayofweek(dt) == Dates.Saturday
        return dt - Dates.Day(1)
    end

    if Dates.dayofweek(dt) == Dates.Sunday
        return dt + Dates.Day(1)
    end

    return dt
end
