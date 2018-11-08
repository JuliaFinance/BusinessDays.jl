
# helper functions for vector inputs

@inline isweekend(dt::Vector{Dates.Date}) = isweekend.(dt)

function isbday(hc::HolidayCalendar, dt::Vector{Dates.Date})
    result = Vector{Bool}(undef, length(dt))

    for i in eachindex(dt)
        @inbounds result[i] = isbday(hc, dt[i])
    end

    return result
end

function isbday(hc::Vector{HolidayCalendar}, dt::Vector{Dates.Date})
    l_hc = length(hc)
    l_dt = length(dt)

    @assert l_hc == l_dt "Input vectors must have the same size. $(l_hc) != $(l_dt)"

    result = Vector{Bool}(undef, length(dt))

    for i in 1:l_hc
        @inbounds result[i] = isbday(hc[i], dt[i])
    end

    return result
end

isbday(calendar, dt::Vector{Dates.Date}) = isbday(convert(HolidayCalendar, calendar), dt)
isbday(calendars::A, dt::Vector{Dates.Date}) where {A<:AbstractArray} = isbday(convert(Vector{HolidayCalendar}, calendars), dt)

function tobday(hc::HolidayCalendar, dt::Vector{Dates.Date}; forward::Bool = true)
    result = Vector{Dates.Date}(undef, length(dt))

    for i in eachindex(dt)
        @inbounds result[i] = tobday(hc, dt[i]; forward=forward)
    end

    return result
end

function tobday(hc::Vector{HolidayCalendar}, dt::Vector{Dates.Date}; forward::Bool = true)
    l_hc = length(hc)
    l_dt = length(dt)

    @assert l_hc == l_dt "Input vectors must have the same size. $(l_hc) != $(l_dt)"

    result = Vector{Dates.Date}(undef, l_hc)

    for i in 1:l_hc
        @inbounds result[i] = tobday(hc[i], dt[i]; forward=forward)
    end

    return result
end

tobday(calendar, dt::Vector{Dates.Date}; forward::Bool = true) = tobday(convert(HolidayCalendar, calendar), dt; forward=forward)
tobday(calendars::A, dt::Vector{Dates.Date}; forward::Bool = true) where {A<:AbstractArray} = tobday(convert(Vector{HolidayCalendar}, calendars), dt; forward=forward)

function bdays(hc::HolidayCalendar, base_date::Dates.Date, dt_vec::Vector{Dates.Date})
    len = length(dt_vec)
    result = Vector{Dates.Day}(undef, len)

    for i in 1:len
        @inbounds result[i] = bdays(hc, base_date, dt_vec[i])
    end

    return result
end

function bdayscount(hc::HolidayCalendar, base_date::Dates.Date, dt_vec::Vector{Dates.Date})
    len = length(dt_vec)
    result = Vector{Int}(undef, len)

    for i in 1:len
        @inbounds result[i] = bdayscount(hc, base_date, dt_vec[i])
    end

    return result
end

function bdays(hc::HolidayCalendar, dt0::Vector{Dates.Date}, dt1::Vector{Dates.Date})
    l0 = length(dt0)
    l1 = length(dt1)

    @assert l0 == l1 "Input vectors must have the same size. $(l0) != $(l1)"

    result = Vector{Dates.Day}(undef, l0)

    for i in 1:l0
        @inbounds result[i] = bdays(hc, dt0[i], dt1[i])
    end

    return result
end

function bdayscount(hc::HolidayCalendar, dt0::Vector{Dates.Date}, dt1::Vector{Dates.Date})
    l0 = length(dt0)
    l1 = length(dt1)

    @assert l0 == l1 "Input vectors must have the same size. $(l0) != $(l1)"

    result = Vector{Int}(undef, l0)

    for i in 1:l0
        @inbounds result[i] = bdayscount(hc, dt0[i], dt1[i])
    end

    return result
end

function bdays(hc::Vector{HolidayCalendar}, dt0::Vector{Dates.Date}, dt1::Vector{Dates.Date})
    l_hc = length(hc)
    l0 = length(dt0)
    l1 = length(dt1)

    @assert l_hc == l0 && l0 == l1 "Input vectors must have the same size. $(l_hc), $(l0), $(l1)"

    result = Vector{Dates.Day}(undef, l0)

    for i in 1:l0
        @inbounds result[i] = bdays(hc[i], dt0[i], dt1[i])
    end

    return result
end

function bdayscount(hc::Vector{HolidayCalendar}, dt0::Vector{Dates.Date}, dt1::Vector{Dates.Date})
    l_hc = length(hc)
    l0 = length(dt0)
    l1 = length(dt1)

    @assert l_hc == l0 && l0 == l1 "Input vectors must have the same size. $(l_hc), $(l0), $(l1)"

    result = Vector{Int}(undef, l0)

    for i in 1:l0
        @inbounds result[i] = bdayscount(hc[i], dt0[i], dt1[i])
    end

    return result
end

bdays(calendars::A, dt0::Vector{Dates.Date}, dt1::Vector{Dates.Date}) where {A<:AbstractArray} = bdays(convert(Vector{HolidayCalendar}, calendars), dt0, dt1)
bdayscount(calendars::A, dt0::Vector{Dates.Date}, dt1::Vector{Dates.Date}) where {A<:AbstractArray} = bdayscount(convert(Vector{HolidayCalendar}, calendars), dt0, dt1)

function advancebdays(hc::HolidayCalendar, dt::Dates.Date, bdays_count_vec::Vector{Int})
    l = length(bdays_count_vec)
    result = Vector{Dates.Date}(undef, l)
    for i in 1:l
        @inbounds result[i] = advancebdays(hc, dt, bdays_count_vec[i])
    end
    return result
end

advancebdays(calendar, dt::Dates.Date, bdays_count_vec::Vector{Int}) = advancebdays(convert(HolidayCalendar, calendar), dt, bdays_count_vec)
advancebdays(hc, dt::Dates.Date, bdays_range::AbstractRange) = advancebdays(hc, dt, collect(bdays_range))

