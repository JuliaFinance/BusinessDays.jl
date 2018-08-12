
"""
Allows for combination of several Holiday Calendars.
"""
struct CompositeHolidayCalendar <: HolidayCalendar
    calendars::Vector{HolidayCalendar}
end

function isholiday(hc::CompositeHolidayCalendar, dt::Dates.Date)
    for c in hc.calendars
        if isholiday(c, dt)
            return true
        end
    end

    return false
end
