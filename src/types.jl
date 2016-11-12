
"""
*Abstract* type for Holiday Calendars.
"""
abstract HolidayCalendar

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

function symtocalendar(sym::Symbol)
    local result::HolidayCalendar

    if isdefined(BusinessDays, sym) && eval(BusinessDays, sym) <: HolidayCalendar
        result = eval(BusinessDays, sym)()
    elseif isdefined(current_module(), sym) && eval(current_module(), sym) <: HolidayCalendar
        result = eval(current_module(), sym)()
    else
        error("$sym is not a valid HolidayCalendar.")
    end
    return result
end
@vectorize_1arg Symbol symtocalendar

strtocalendar(str::AbstractString) = symtocalendar(Symbol(str))
@vectorize_1arg AbstractString strtocalendar

Base.convert(::Type{HolidayCalendar}, sym::Symbol) = symtocalendar(sym)
Base.convert(::Type{HolidayCalendar}, str::AbstractString) = strtocalendar(str)
Base.convert{T<:HolidayCalendar}(::Type{Array{T,1}}, syms::Array{Symbol, 1}) = symtocalendar(syms)
Base.convert{T<:HolidayCalendar, S<:AbstractString}(::Type{Array{T,1}}, strs::Array{S, 1}) = strtocalendar(strs)

"""
    isholiday(calendar, dt)

Checks if `dt` is a holiday based on a given `calendar` of holidays.

`calendar` can be an instance of `HolidayCalendar`,  a `Symbol` or an `AbstractString`.

Returns boolean values.
"""
isholiday(hc::HolidayCalendar, dt::Date) = error("isholiday for $(hc) not implemented.")

isholiday(calendar, dt::Date) = isholiday(convert(HolidayCalendar, calendar), dt)
