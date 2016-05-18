
## v0.3.0 release notes

* A `HolidayCalendar` can now be referenced using `Symbol` or `String`.

```julia
julia> using BusinessDays
julia> bdays("Brazil", Date(2016,4,1), Date(2016,5,1))
julia> bdays(:Brazil, Date(2016,4,1), Date(2016,5,1))
```

* `Brazil` Holiday Calendar type was renamed to `BRSettlement`.

* Added type aliases for *settlement* calendars:

    * `BRSettlement` : `Brazil`
    * `USSettlement` : `UnitedStates`
    * `UKSettlement` : `UnitedKingdom`

* Added utility functions `listholidays` and `listbdays`.

* Fix applied to USSettlement calendar for years before 1983.

* Improved package documentation.

## v0.2.0 release notes

* Submodule `HolidayCalendars` was removed.

* Holiday Calendar types were renamed. They are now based on [QuantLib](https://github.com/lballabio/QuantLib) names.

`BusinessDays.HolidayCalendars.BrazilBanking` → `BusinessDays.Brazil`

`BusinessDays.HolidayCalendars.UnitedStates` → `BusinessDays.USSettlement`

`BusinessDays.HolidayCalendars.UKEnglandBanking` → `BusinessDays.UKSettlement`

* Added `listholidays` function.
