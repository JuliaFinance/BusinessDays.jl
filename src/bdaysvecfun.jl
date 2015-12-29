# helper functions for vector inputs

@vectorize_1arg Date isweekend

function isbday(hc::HolidayCalendar, dt::Vector{Date})
	result = Array(Bool, length(dt))
	
	for i in eachindex(dt)
		result[i] = isbday(hc, dt[i])
	end

	return result
end

function isbday(hc::Vector{HolidayCalendar}, dt::Vector{Date})
	const l_hc = length(hc)
	const l_dt = length(dt)

	if l_hc != l_dt
		error("Input vectors must have the same size. $(l_hc) != $(l_dt)")
	end

	result = Array(Bool, length(dt))

	for i in 1:l_hc
		result[i] = isbday(hc[i], dt[i])
	end

	return result
end

function tobday(hc::HolidayCalendar, dt::Vector{Date}; forward::Bool = true)
	result = Array(Date, length(dt))

	for i in eachindex(dt)
		result[i] = tobday(hc, dt[i]; forward=forward)
	end

	return result
end

function tobday(hc::Vector{HolidayCalendar}, dt::Vector{Date}; forward::Bool = true)
	const l_hc = length(hc)
	const l_dt = length(dt)

	if l_hc != l_dt
		error("Input vectors must have the same size. $(l_hc) != $(l_dt)")
	end

	result = Array(Date, l_hc)

	for i in 1:l_hc
		result[i] = tobday(hc[i], dt[i]; forward=forward)
	end

	return result
end

function bdays(hc::HolidayCalendar, dt0::Vector{Date}, dt1::Vector{Date})
	const l0 = length(dt0)
	const l1 = length(dt1)

	if l0 != l1
		error("Input vectors must have the same size. $(l0) != $(l1)")
	end

	result = Array(Day, l0)

	for i in 1:l0
		result[i] = bdays(hc, dt0[i], dt1[i])
	end

	return result
end

function bdays(hc::Vector{HolidayCalendar}, dt0::Vector{Date}, dt1::Vector{Date})
	const l_hc = length(hc)
	const l0 = length(dt0)
	const l1 = length(dt1)

	if l_hc != l0 || l0 != l1
		error("Input vectors must have the same size. $(l_hc), $(l0), $(l1)")
	end

	result = Array(Day, l0)

	for i in 1:l0
		result[i] = bdays(hc[i], dt0[i], dt1[i])
	end

	return result
end

function advancebdays(hc::HolidayCalendar, dt::Date, bdays_count_vec::Vector{Int})
	l = length(bdays_count_vec)
	result = Array(Date, l)
	for i in 1:l
		result[i] = advancebdays(hc, dt, bdays_count_vec[i])
	end
	return result
end

advancebdays(hc::HolidayCalendar, dt::Date, bdays_range::UnitRange{Int}) = advancebdays(hc, dt, collect(bdays_range))
