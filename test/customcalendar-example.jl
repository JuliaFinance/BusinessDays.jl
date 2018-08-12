
using BusinessDays

struct CustomCalendar <: HolidayCalendar end

BusinessDays.isholiday(::CustomCalendar, dt::Dates.Date) = dt == Dates.Date(2015,8,27)

cc = CustomCalendar()
println("Returns false: $(isholiday(cc, Dates.Date(2015,8,26)))")
println("Returns true: $(isholiday(cc, Dates.Date(2015,8,27)))")
