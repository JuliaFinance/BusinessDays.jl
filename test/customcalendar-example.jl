using BusinessDays
import BusinessDays.isholiday

type CustomCalendar <: HolidayCalendar end
isholiday(::CustomCalendar, dt::Date) = dt == Date(2015,8,27)

cc = CustomCalendar()
println("$(isholiday(cc, Date(2015,8,26)))")
println("$(isholiday(cc, Date(2015,8,27)))")
