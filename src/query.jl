
"""
Returns a `Vector{Date}` with the list of holidays between `dt0` and `dt1`.
"""
function listholidays(hc::HolidayCalendar, dt0::Date, dt1::Date)
    const d0 = min(dt0, dt1)
    const d1 = max(dt0, dt1)
    const dt_range = d0:d1
    isholiday_vec = [ isholiday(hc, i) for i in dt_range ]
    return dt_range[isholiday_vec]
end

listholidays(calendar, dt0::Date, dt1::Date) = listholidays(convert(HolidayCalendar,calendar), dt0, dt1)

"""
Returns a `Vector{Date}` with the list of business days between `dt0` and `dt1`.
"""
function listbdays(hc::HolidayCalendar, dt0::Date, dt1::Date)
    d = tobday(hc,min(dt0,dt1))
    const d1 = max(dt0, dt1)

    # empty result
    if d > d1
        return Array(Date,0)
    end

    const n = convert(Int, d1-d)+1
    raw_vec::Array{Date, 1} = Array(Date, n)
    raw_vec[1] = d
    i::Int = 2
    d = advancebdays(hc,d,1)
    while d <= d1
        raw_vec[i] = d
        i+=1
        d = advancebdays(hc,d,1)
    end
    return raw_vec[1:(i-1)]
end

listbdays(calendar, dt0::Date, dt1::Date) = listbdays(convert(HolidayCalendar,calendar), dt0, dt1)
