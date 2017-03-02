# helper functions for vector inputs

isweekend(dt::Vector{Date}) = isweekend.(dt)

function isbday(hc::HolidayCalendar, dt::Vector{Date})
    result = Array{Bool}(length(dt))
    
    for i in eachindex(dt)
        result[i] = isbday(hc, dt[i])
    end

    return result
end

function isbday(hc::Vector{HolidayCalendar}, dt::Vector{Date})
    const l_hc = length(hc)
    const l_dt = length(dt)

    @assert l_hc == l_dt "Input vectors must have the same size. $(l_hc) != $(l_dt)"

    result = Array{Bool}(length(dt))

    for i in 1:l_hc
        result[i] = isbday(hc[i], dt[i])
    end

    return result
end

isbday(calendar, dt::Vector{Date}) = isbday(convert(HolidayCalendar, calendar), dt)
isbday{A<:AbstractArray}(calendars::A, dt::Vector{Date}) = isbday(convert(Vector{HolidayCalendar}, calendars), dt)

function tobday(hc::HolidayCalendar, dt::Vector{Date}; forward::Bool = true)
    result = Array{Date}(length(dt))

    for i in eachindex(dt)
        result[i] = tobday(hc, dt[i]; forward=forward)
    end

    return result
end

function tobday(hc::Vector{HolidayCalendar}, dt::Vector{Date}; forward::Bool = true)
    const l_hc = length(hc)
    const l_dt = length(dt)

    @assert l_hc == l_dt "Input vectors must have the same size. $(l_hc) != $(l_dt)"

    result = Array{Date}(l_hc)

    for i in 1:l_hc
        result[i] = tobday(hc[i], dt[i]; forward=forward)
    end

    return result
end

tobday(calendar, dt::Vector{Date}; forward::Bool = true) = tobday(convert(HolidayCalendar, calendar), dt; forward=forward)
tobday{A<:AbstractArray}(calendars::A, dt::Vector{Date}; forward::Bool = true) = tobday(convert(Vector{HolidayCalendar}, calendars), dt; forward=forward)

function bdays(hc::HolidayCalendar, base_date::Date, dt_vec::Vector{Date})
    const len = length(dt_vec)

    result = Array{Day}(len)

    for i in 1:len
        result[i] = bdays(hc, base_date, dt_vec[i])
    end

    return result
end

function bdays(hc::HolidayCalendar, dt0::Vector{Date}, dt1::Vector{Date})
    const l0 = length(dt0)
    const l1 = length(dt1)

    @assert l0 == l1 "Input vectors must have the same size. $(l0) != $(l1)"

    result = Array{Day}(l0)

    for i in 1:l0
        result[i] = bdays(hc, dt0[i], dt1[i])
    end

    return result
end

function bdays(hc::Vector{HolidayCalendar}, dt0::Vector{Date}, dt1::Vector{Date})
    const l_hc = length(hc)
    const l0 = length(dt0)
    const l1 = length(dt1)

    @assert l_hc == l0 && l0 == l1 "Input vectors must have the same size. $(l_hc), $(l0), $(l1)"

    result = Array{Day}(l0)

    for i in 1:l0
        result[i] = bdays(hc[i], dt0[i], dt1[i])
    end

    return result
end

bdays{A<:AbstractArray}(calendars::A, dt0::Vector{Date}, dt1::Vector{Date}) = bdays(convert(Vector{HolidayCalendar}, calendars), dt0, dt1)

function advancebdays(hc::HolidayCalendar, dt::Date, bdays_count_vec::Vector{Int})
    const l = length(bdays_count_vec)
    result = Array{Date}(l)
    for i in 1:l
        result[i] = advancebdays(hc, dt, bdays_count_vec[i])
    end
    return result
end

advancebdays(calendar, dt::Date, bdays_count_vec::Vector{Int}) = advancebdays(convert(HolidayCalendar, calendar), dt, bdays_count_vec)
advancebdays(hc, dt::Date, bdays_range::UnitRange{Int}) = advancebdays(hc, dt, collect(bdays_range))
