
using BusinessDays

struct CustomCalendar <: HolidayCalendar end

BusinessDays.isholiday(::CustomCalendar, dt::Date) = dt == Date(2015,8,27)

cc = CustomCalendar()
println("Returns false: $(isholiday(cc, Date(2015,8,26)))")
println("Returns true: $(isholiday(cc, Date(2015,8,27)))")
