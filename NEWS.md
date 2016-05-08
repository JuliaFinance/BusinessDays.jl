
## v0.2.0 release notes

* Submodule `HolidayCalendars` was removed.

* Holiday Calendar types were renamed. They are now based on [QuantLib](https://github.com/lballabio/QuantLib) names.

`BusinessDays.HolidayCalendars.BrazilBanking` → `BusinessDays.Brazil`

`BusinessDays.HolidayCalendars.UnitedStates` → `BusinessDays.USSettlement`

`BusinessDays.HolidayCalendars.UKEnglandBanking` → `BusinessDays.UKSettlement`

* Added `listholidays` function.
