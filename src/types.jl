
"""
*Abstract* type for Holiday Calendars.
"""
abstract HolidayCalendar

"""
A calendar with no holidays or weekends.
"""
type NullHolidayCalendar <: HolidayCalendar end

"""
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

HCDICT = Dict{Symbol, HolidayCalendar}(
    :BRSettlement=>BRSettlement(),
    :Brazil=>Brazil(),
    :USSettlement=>USSettlement(),
    :UnitedStates=>UnitedStates(),
    :USNYSE=>USNYSE(),
    :USGovernmentBond=>USGovernmentBond(),
    :UKSettlement=>UKSettlement(),
    :UnitedKingdom=>UnitedKingdom()
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
