
__precompile__(true)

"""
A highly optimized Business Days calculator written in Julia language. Also known as Working Days calculator.

Website: https://github.com/felipenoris/BusinessDays.jl
"""
module BusinessDays

# types.jl
export
    HolidayCalendar,
    CompositeHolidayCalendar,
    GenericHolidayCalendar

# isholiday.jl
export
    isholiday

# bdays.jl : main functions for BusinessDays module
export
    isweekday,
    isweekend,
    isbday,
    tobday,
    advancebdays,
    bdayscount,
    bdays,
    firstbdayofmonth,
    lastbdayofmonth,
    listholidays,
    listbdays

include("dateutils.jl")
include("holidaycalendar.jl")
include("bdayscache.jl")
include("bdays.jl")
include("bdaysvecfun.jl")
include("composite.jl")
include("query.jl")
include("calendars/calendars.jl")
include("generic.jl")

end # module BusinessDays
