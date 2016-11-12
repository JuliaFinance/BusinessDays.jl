
"""
    easter_rata(y::Year) → Int

Returns Easter date as a *[Rata Die](https://en.wikipedia.org/wiki/Rata_Die)* number.

Based on *[Algo R](http://www.linuxtopia.org/online_books/programming_books/python_programming/python_ch38.html)*.
"""
function easter_rata(y::Year)

    # Algo R only works after 1582
    if y.value < 1582
        # Are you using this? Send me a postcard!
        error("Year cannot be less than 1582. Provided: $(y.value).")
    end

    # Century
    const c = div(y.value , 100) + 1

    # Shifted Epact
    local e::Int = mod(14 + 11*(mod(y.value, 19)) - div(3*c, 4) + div(5+8*c, 25), 30)

    # Adjust Epact
    if (e == 0) || ((e == 1) && ( 10 < mod(y.value, 19) ))
       e += 1
    end

    # Paschal Moon
    const p = Date(y.value, 4, 19).instant.periods.value - e

    # Easter: locate the Sunday after the Paschal Moon
    return p + 7 - mod(p, 7)
end

"""
    easter_date(y::Year) → Date

Returns result of `easter_rata` as a `Date` instance.
"""
easter_date(y::Year) = Date(Dates.rata2datetime(easter_rata(y)))

# weekday_target values:
# const Monday,Tuesday,Wednesday,Thursday,Friday,Saturday,Sunday = 1,2,3,4,5,6,7
# See query.jl on Dates module
# See also dayofweek(dt) function.
"""
    findweekday(weekday_target::Integer, yy::Integer, mm::Integer, occurrence::Integer, ascending::Bool) → Date

Given a year `yy` and month `mm`, finds a date where a choosen weekday occurs.

`weekday_target` values are declared in module `Base.Dates`: 
`Monday,Tuesday,Wednesday,Thursday,Friday,Saturday,Sunday = 1,2,3,4,5,6,7`.

If `ascending` is true, searches from the beggining of the month. If false, searches from the end of the month.

If `occurrence` is `2` and `weekday_target` is `Monday`, searches the 2nd Monday of the given month, and so on.
"""
function findweekday(weekday_target::Integer, yy::Integer, mm::Integer, occurrence::Integer, ascending::Bool)
    
    local dt::Date = Date(yy, mm, 1)
    local dt_dayofweek::Integer
    local offset::Integer

    @assert occurrence > 0 "occurrence must be > 0. Provided $(occurrence)."

    if ascending
        dt_dayofweek = dayofweek(dt)
        offset = rem(weekday_target + 7 - dt_dayofweek, 7) # rem = MOD function
    else
        dt = lastdayofmonth(dt)
        dt_dayofweek = dayofweek(dt)
        offset = rem(dt_dayofweek + 7 - weekday_target, 7)
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
