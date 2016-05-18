
VERSION >= v"0.4.0-dev+6521" && __precompile__()

"""
A highly optimized Business Days calculator written in Julia language. Also known as Working Days calculator.

Website: https://github.com/felipenoris/BusinessDays.jl
"""
module BusinessDays

using Base.Dates

# types.jl
export
    HolidayCalendar,
    CompositeHolidayCalendar

# isholiday.jl
export
    isholiday

# bdays.jl : main functions for BusinessDays module
export
    isweekend,
    isbday,
    tobday,
    advancebdays,
    bdays,
    listholidays,
    listbdays

include("dateutils.jl")
include("types.jl")
include("isholiday.jl")
include("bdayscache.jl")
include("bdays.jl")
include("bdaysvecfun.jl")
include("composite.jl")
include("query.jl")

end # module BusinessDays
