
## v0.2.1 release notes

* A `HolidayCalendar` can now be referenced using `Symbol` or `String`.

```julia
julia> using BusinessDays
julia> bdays("Brazil", Date(2016,4,1), Date(2016,5,1))
julia> bdays(:Brazil, Date(2016,4,1), Date(2016,5,1))
```

## v0.2.0 release notes

* Submodule `HolidayCalendars` was removed.

* Holiday Calendar types were renamed. They are now based on [QuantLib](https://github.com/lballabio/QuantLib) names.

`BusinessDays.HolidayCalendars.BrazilBanking` → `BusinessDays.Brazil`

`BusinessDays.HolidayCalendars.UnitedStates` → `BusinessDays.USSettlement`

`BusinessDays.HolidayCalendars.UKEnglandBanking` → `BusinessDays.UKSettlement`

* Added `listholidays` function.
