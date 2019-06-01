
"""
A highly optimized Business Days calculator written in Julia language. Also known as Working Days calculator.

Website: https://github.com/felipenoris/BusinessDays.jl
"""
module BusinessDays

import Dates

# exported types
export
    HolidayCalendar,
    CompositeHolidayCalendar,
    GenericHolidayCalendar

# exported functions
export
    isholiday,
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
