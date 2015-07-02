# Checks for Saturdays or Sundays
function isweekend(x::TimeType)
	return dayofweek(x) in [6, 7]
end

# Checks for holidays and weekends
function isbday( hc :: HolidayCalendar, dt :: TimeType)
	if _getcachestate(hc)
		hcc :: HolidayCalendarCache = _getholidaycalendarcache(hc)
		return isbday(hcc, dt)
	else
		return !(  isweekend(dt) || isholiday(hc, dt)  )
	end
end

# Ajusts date to next BusinessDay if dt !isbday.
# If isbday(dt), return dt.
function tobday(hc :: HolidayCalendar, dt :: TimeType)
	if isbday(hc, dt)
		return dt
	else
		local next :: TimeType = dt + Dates.Day(1)
		while !isbday(hc, next)
			next += Dates.Day(1)
		end
	end
	return next
end

function advancebdays(hc :: HolidayCalendar, dt :: TimeType, bdays_count :: Int)
	# Computation starts by next Business Day if dt is not a BusinessDay, inspired by Banking Account convention.
	local result :: TimeType = tobday(hc, dt)

	# does nothing
	if bdays_count == 0
		return result
	end

	# if bdays_count is positive, goes forward. Otherwise, goes backwards.
	local increment :: Int = bdays_count > 0 ? +1 : -1

	local num_iterations :: Int = abs(bdays_count)
	
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
function bdays(hc :: HolidayCalendar, dt0 :: TimeType, dt1 :: TimeType)
	if _getcachestate(hc)
		hcc :: HolidayCalendarCache = _getholidaycalendarcache(hc)
		return bdays(hcc, dt0, dt1)
	else
		# Supports dt0 and dt1 in any given order, so the result is always a positive integer
		local initial_dt :: TimeType = min(dt0, dt1)
		local final_dt :: TimeType = max(dt0, dt1)

		# Computation is always based on next Business Days if given dates are not Business Days, inspired by Banking Account convention.
		initial_dt = tobday(hc, initial_dt)
		final_dt = tobday(hc, final_dt)

		local result :: Int = 0
		while initial_dt < final_dt
			initial_dt += Dates.Day(1)

			# Looks for next Business Day
			while !isbday(hc, initial_dt)
				initial_dt += Dates.Day(1)
			end

			result += 1
		end

		return Dates.Day(result)
	end
end