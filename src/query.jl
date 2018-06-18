
"""
    listholidays(calendar, dt0::Date, dt1::Date) → Vector{Date}

Returns the list of holidays between `dt0` and `dt1`.
"""
function listholidays(hc::HolidayCalendar, dt0::Date, dt1::Date)
    d0 = min(dt0, dt1)
    d1 = max(dt0, dt1)
    dt_range = d0:d1
    isholiday_vec = [ isholiday(hc, i) for i in dt_range ]
    return dt_range[isholiday_vec]
end

listholidays(calendar, dt0::Date, dt1::Date) = listholidays(convert(HolidayCalendar,calendar), dt0, dt1)

"""
    listbdays(calendar, dt0::Date, dt1::Date) → Vector{Date}

Returns the list of business days between `dt0` and `dt1`.
"""
function listbdays(hc::HolidayCalendar, dt0::Date, dt1::Date)
    d = tobday(hc, min(dt0, dt1))
    d1 = max(dt0, dt1)

    # empty result
    if d > d1
        return Vector{Date}()
    end

    n = Dates.value(d1) - Dates.value(d) + 1
    raw_vec = Vector{Date}(n)
    raw_vec[1] = d
    d = advancebdays(hc,d,1)
    i = 2
    while d <= d1
        raw_vec[i] = d
        i += 1
        d = advancebdays(hc,d,1)
    end

    return raw_vec[1:(i-1)]
end

listbdays(calendar, dt0::Date, dt1::Date) = listbdays(convert(HolidayCalendar,calendar), dt0, dt1)
