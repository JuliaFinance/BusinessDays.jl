#
# Cache routines for Business Days precalculated days
#

# Key = HolidayCalendar instance
# Value = instance of HolidayCalendarCache
global _CACHE_DICT = Dict{HolidayCalendar, HolidayCalendarCache }()

function _getcachestate(hc :: HolidayCalendar)
	return haskey(_CACHE_DICT, hc)
end

function _getholidaycalendarcache(hc :: HolidayCalendar)
	return _CACHE_DICT[hc]
end

function checkbounds(hcc :: HolidayCalendarCache, dt :: TimeType)
	if !((hcc.dtmin <= dt) && (dt <= hcc.dtmax))
		error("Date out of cache bounds. Use initcache function with a wider time spread. Provided date: $(dt).")
	end
end

function _linenumber(hcc :: HolidayCalendarCache, dt :: TimeType)
	return Dates.days(dt) - Dates.days(hcc.dtmin)  + 1
end

function isbday(hcc :: HolidayCalendarCache, dt :: TimeType)
	checkbounds(hcc, dt)
	return hcc.isbday_array[ _linenumber(hcc, dt) ]
end

function bdays(hcc :: HolidayCalendarCache, dt0 :: TimeType, dt1 :: TimeType)
	# Supports dt0 and dt1 in any given order, so the result is always a positive integer
	local initial_dt :: TimeType = min(dt0, dt1)
	local final_dt :: TimeType = max(dt0, dt1)

	# Computation is always based on next Business Days if given dates are not Business Days, inspired by Banking Account convention.
	initial_dt = tobday(hcc.hc, initial_dt)
	final_dt = tobday(hcc.hc, final_dt)

	checkbounds(hcc, initial_dt) ; checkbounds(hcc, final_dt)

	return Day( hcc.bdayscounter_array[ _linenumber(hcc, final_dt) ] - hcc.bdayscounter_array[ _linenumber(hcc, initial_dt) ]  )
end


# Be sure to use this function on a syncronized code (not parallel).
function initcache(hc :: HolidayCalendar, d0 :: Date, d1 :: Date)
	isbday_array , bdayscounter_array = _createbdayscache(hc, d0, d1)
	_CACHE_DICT[hc] = HolidayCalendarCache(hc, isbday_array, bdayscounter_array, min(d0, d1), max(d0, d1))
end

# Defaults to d0 = 1st Jan 1900 , d1 = 20th dec 2100
function initcache(hc :: HolidayCalendar)
	initcache(hc, Date(1900, 01, 01), Date(2100, 12, 20))
end

function initcache()
	l = holidaycalendarlist() # see types.jl
	for hc in l
		initcache(hc)
	end
end

# Returns tuple
# tuple[1] = Array of Bool (isBday) , tuple[2] = Array of UInt32 (bdaycounter)
function _createbdayscache(hc :: HolidayCalendar, d0 :: Date, d1 :: Date)

	const d0_ = min(d0, d1)
	const d1_ = max(d0, d1)

	const d0_rata = Dates.days(d0_)
	const d1_rata = Dates.days(d1_)
	
	# length of the cache arrays
	const len :: Int64 = d1_rata - d0_rata + 1

	# This function uses UInt16 to store bdayscounter array.
	# We need to check if we'll exceed typemax(UInt32)
	if len > convert(Int64, typemax(UInt32))
		error("Maximum size allowed for bdays array is $(typemax(UInt32)). Required lenght of $(len).")
	end

	isbday_array = zeros(Bool, len)
	bdayscounter_array = zeros(UInt32, len)

	isbday_array[1] = isbday(hc, d0_)
	bdayscounter_array[1] = 0

	for i in 2:len
		isbday_array[i] = isbday(hc, d0_ + Dates.Day(i-1))
		bdayscounter_array[i] = bdayscounter_array[i-1] + isbday_array[i]
	end

	return isbday_array, bdayscounter_array
end
