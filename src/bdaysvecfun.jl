# helper functions for vector inputs

@vectorize_1arg Date isweekend

function isbday(hc::HolidayCalendar, dt::Array{Date,1})
	result = Array(Bool, length(dt))
	
	for i in eachindex(dt)
		result[i] = isbday(hc, dt[i])
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

function bdays(hc::HolidayCalendar, dt0::Array{Date,1}, dt1::Array{Date,1})
	const l0 = length(dt0)
	const l1 = length(dt1)

	if length(dt0) != length(dt1)
		error("Input vectors must have the same sizes. $(l0) != $(l1)")
	end

	result = Array(Day, l0)

	for i in 1:l0
		result[i] = bdays(hc, dt0[i], dt1[i])
	end

	return result
end