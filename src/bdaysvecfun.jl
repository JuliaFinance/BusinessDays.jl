# helper functions for vector inputs

@vectorize_1arg Date isweekend

function isbday(hc::HolidayCalendar, dt::Array{Date,1})
	result = Array(Bool, length(dt))
	
	for i in eachindex(dt)
		result[i] = isbday(hc, dt[i])
	end

	return result
end

function isbday(hc::Array{HolidayCalendar,1}, dt::Array{Date,1})
	const l_hc = length(hc)
	const l_dt = length(dt)

	if l_hc != l_dt
		error("Input vector must have the same sizes. $(l_hc) != $(l_dt)")
	end

	result = Array(Bool, length(dt))

	for i in 1:l_hc
		result[i] = isbday(hc[i], dt[i])
	end

	return result
end

function tobday(hc::HolidayCalendar, dt::Array{Date,1}; forward::Bool = true)
	result = Array(Date, length(dt))

	for i in eachindex(dt)
		result[i] = tobday(hc, dt[i]; forward=forward)
	end

	return result
end

function tobday(hc::Array{HolidayCalendar,1}, dt::Array{Date,1}; forward::Bool = true)
	const l_hc = length(hc)
	const l_dt = length(dt)

	if l_hc != l_dt
		error("Input vector must have the same sizes. $(l_hc) != $(l_dt)")
	end

	result = Array(Date, l_hc)

	for i in 1:l_hc
		result[i] = tobday(hc[i], dt[i]; forward=forward)
	end
end

function bdays(hc::HolidayCalendar, dt0::Array{Date,1}, dt1::Array{Date,1})
	const l0 = length(dt0)
	const l1 = length(dt1)

	if l0 != l1
		error("Input vectors must have the same sizes. $(l0) != $(l1)")
	end

	result = Array(Day, l0)

	for i in 1:l0
		result[i] = bdays(hc, dt0[i], dt1[i])
	end

	return result
end

function bdays(hc::Array{HolidayCalendar,1}, dt0::Array{Date,1}, dt1::Array{Date,1})
	const l_hc = length(hc)
	const l0 = length(dt0)
	const l1 = length(dt1)

	if l_hc != l0 || l0 != l1
		error("Input vectors must have the same sizes. $(l_hc), $(l0), $(l1)")
	end

	result = Array(Day, l0)

	for i in 1:l0
		result[i] = bdays(hc[i], dt0[i], dt1[i])
	end

	return result
end