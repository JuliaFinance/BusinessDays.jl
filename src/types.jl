
doc"""
*Abstract* type for Holiday Calendars.
"""
abstract HolidayCalendar

doc"""
Data structure for calendar cache.
"""
type HolidayCalendarCache
	hc::HolidayCalendar
	isbday_array::Vector{Bool}
	bdayscounter_array::Vector{UInt32}
	dtmin::Date
	dtmax::Date
end

Base.string(hc::HolidayCalendar) = string(typeof(hc))

#####################################
## CONCRETE CALENDAR IMPLEMENTATIONS
#####################################
doc"""
Banking holidays for Brazil (federal holidays plus Carnival).
"""
type Brazil <: HolidayCalendar end

doc"""
United States federal holidays.
"""
type USSettlement <: HolidayCalendar end

doc"""
United States NYSE holidays.
"""
type USNYSE <: HolidayCalendar end

doc"""
United States Government Bond calendar.
"""
type USGovernmentBond <: HolidayCalendar end

doc"""
Banking holidays for England and Wales.
"""
type UKSettlement <: HolidayCalendar end

type NullHolidayCalendar <: HolidayCalendar end

HCDICT = Dict{Symbol, HolidayCalendar}(
	:Brazil=>Brazil(),
	:USSettlement=>USSettlement(),
	:USNYSE=>USNYSE(),
	:USGovernmentBond=>USGovernmentBond(),
	:UKSettlement=>UKSettlement()
)

function symtocalendar(sym::Symbol)
	nc::HolidayCalendar = NullHolidayCalendar()
	hc::HolidayCalendar = get(HCDICT, sym, nc)
	if hc == nc
		error("Invalid calendar: $sym")
	end
	return hc
end
@vectorize_1arg Symbol symtocalendar

strtocalendar(str::AbstractString) = symtocalendar(Symbol(str))
@vectorize_1arg AbstractString strtocalendar

Base.convert(::Type{HolidayCalendar}, sym::Symbol) = symtocalendar(sym)
Base.convert(::Type{HolidayCalendar}, str::AbstractString) = strtocalendar(str)
Base.convert{T<:HolidayCalendar}(::Type{Array{T,1}}, syms::Array{Symbol, 1}) = symtocalendar(syms)
Base.convert{T<:HolidayCalendar, S<:AbstractString}(::Type{Array{T,1}}, strs::Array{S, 1}) = strtocalendar(strs)
