
"""
    listholidays(calendar, dt0::Dates.Date, dt1::Dates.Date) → Vector{Dates.Date}

Returns the list of holidays between `dt0` and `dt1`.
"""
function listholidays(hc::HolidayCalendar, dt0::Dates.Date, dt1::Dates.Date)
    d0 = min(dt0, dt1)
    d1 = max(dt0, dt1)
    dt_range = d0:Dates.Day(1):d1
    isholiday_vec = [ isholiday(hc, i) for i in dt_range ]
    return dt_range[isholiday_vec]
end

listholidays(calendar, dt0::Dates.Date, dt1::Dates.Date) = listholidays(convert(HolidayCalendar, calendar), dt0, dt1)

"""
    listbdays(calendar, dt0::Dates.Date, dt1::Dates.Date) → Vector{Dates.Date}

Returns the list of business days between `dt0` and `dt1`.
"""
function listbdays(hc::HolidayCalendar, dt0::Dates.Date, dt1::Dates.Date)
    d = tobday(hc, min(dt0, dt1))
    d1 = max(dt0, dt1)

    # empty result
    if d > d1
        return Vector{Dates.Date}()
    end

    n = Dates.value(d1) - Dates.value(d) + 1
    raw_vec = Vector{Dates.Date}(undef, n)
    raw_vec[1] = d
    d = advancebdays(hc, d, 1)
    i = 2
    while d <= d1
        raw_vec[i] = d
        i += 1
        d = advancebdays(hc,d,1)
    end

    return raw_vec[1:(i-1)]
end

listbdays(calendar, dt0::Dates.Date, dt1::Dates.Date) = listbdays(convert(HolidayCalendar,calendar), dt0, dt1)
