# Checks for Saturdays or Sundays
function isweekend(x::Date)
	return dayofweek(x) in [6, 7]
end

# Checks for holidays and weekends
function isbday(hc::HolidayCalendar, dt::Date)
	if _getcachestate(hc)
		hcc :: HolidayCalendarCache = _getholidaycalendarcache(hc)
		return isbday(hcc, dt)
	else
		return !(isweekend(dt) || isholiday(hc, dt))
	end
end

# Ajusts date to next BusinessDay if dt !isbday.
# If isbday(dt), return dt.
function tobday(hc::HolidayCalendar, dt::Date; forward::Bool = true)
	if isbday(hc, dt)
		return dt
	else
		local next::Date
		local increment::Int64 = forward ? 1 : -1

		next = dt + Dates.Day(increment)
		while !isbday(hc, next)
			next += Dates.Day(increment)
		end
	end
	
	return next
end

function advancebdays(hc::HolidayCalendar, dt::Date, bdays_count::Int)
	# Computation starts by next Business Day if dt is not a BusinessDay, inspired by Banking Account convention.
	local result::Date = tobday(hc, dt)

	# does nothing
	if bdays_count == 0
		return result
	end

	# if bdays_count is positive, goes forward. Otherwise, goes backwards.
	local increment::Int = bdays_count > 0 ? +1 : -1

	local num_iterations::Int = abs(bdays_count)
	
	while num_iterations > 0
		result += Dates.Day(increment)

		# Looks for previous / next Business Day
		while !isbday(hc, result)
			result += Dates.Day(increment)
		end
		
		num_iterations += -1
	end

	return result
end

# Counts the number of BusinessDays between dt0 and dt1
# Returns instance of Dates.Day
function bdays(hc::HolidayCalendar, dt0::Date, dt1::Date)
	if _getcachestate(hc)
		hcc::HolidayCalendarCache = _getholidaycalendarcache(hc)
		return bdays(hcc, dt0, dt1)
	else
		# Computation is always based on next Business Days if given dates are not Business Days, inspired by Banking Account convention.
		dt0 = tobday(hc, dt0)
		dt1 = tobday(hc, dt1)
		inc::Int = dt0 <= dt1 ? +1 : -1

		local result::Int = 0
		while dt0 != dt1
			dt0 += Dates.Day(inc)

			# Looks for next/last Business Day
			while !isbday(hc, dt0)
				dt0 += Dates.Day(inc)
			end

			result += inc
		end

		return Dates.Day(result)
	end
end