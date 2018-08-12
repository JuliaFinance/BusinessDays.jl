
"""
*Abstract* type for Holiday Calendars.
"""
abstract type HolidayCalendar end

Base.string(hc::HolidayCalendar) = string(typeof(hc))

function symtocalendar(sym::Symbol) :: HolidayCalendar
    if isdefined(BusinessDays, sym) && Core.eval(BusinessDays, sym) <: HolidayCalendar
        return Core.eval(BusinessDays, sym)()
    elseif isdefined(@__MODULE__, sym) && Core.eval(@__MODULE__, sym) <: HolidayCalendar
        return Core.eval(@__MODULE__, sym)()
    elseif isdefined(Main, sym) && Core.eval(Main, sym) <: HolidayCalendar
        return Core.eval(Main, sym)()
    else
        error("$sym is not a valid HolidayCalendar.")
    end
end

@inline strtocalendar(str::AbstractString) = symtocalendar(Symbol(str))

Base.convert(::Type{HolidayCalendar}, sym::Symbol) = symtocalendar(sym)
Base.convert(::Type{HolidayCalendar}, str::AbstractString) = strtocalendar(str)

"""
    isholiday(calendar, dt)

Checks if `dt` is a holiday based on a given `calendar` of holidays.

`calendar` can be an instance of `HolidayCalendar`,  a `Symbol` or an `AbstractString`.

Returns boolean values.
"""
isholiday(hc::HolidayCalendar, dt::Dates.Date) = error("isholiday for $(hc) not implemented.")

isholiday(calendar, dt::Dates.Date) = isholiday(convert(HolidayCalendar, calendar), dt)
