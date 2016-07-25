
#BusinessDays.jl
[![Build Status](https://travis-ci.org/felipenoris/BusinessDays.jl.svg?branch=master)](https://travis-ci.org/felipenoris/BusinessDays.jl) [![Coverage Status](https://coveralls.io/repos/felipenoris/BusinessDays.jl/badge.svg?branch=master&service=github)](https://coveralls.io/github/felipenoris/BusinessDays.jl?branch=master) [![codecov.io](http://codecov.io/github/felipenoris/BusinessDays.jl/coverage.svg?branch=master)](http://codecov.io/github/felipenoris/BusinessDays.jl?branch=master) [![BusinessDays](http://pkg.julialang.org/badges/BusinessDays_0.4.svg)](http://pkg.julialang.org/?pkg=BusinessDays&ver=0.4) [![BusinessDays](http://pkg.julialang.org/badges/BusinessDays_0.5.svg)](http://pkg.julialang.org/?pkg=BusinessDays&ver=0.5) [![License](http://img.shields.io/badge/license-MIT-brightgreen.svg?style=flat)](LICENSE)

A highly optimized *Business Days* calculator written in Julia language.
Also known as *Working Days* calculator.

**Installation**: 
```julia
julia> Pkg.update()
julia> Pkg.add("BusinessDays")
```

##Motivation
This code was developed with a mindset of a Financial Institution that has a big *Fixed Income* portfolio. Many financial contracts, specially *Fixed Income instruments*, depend on a particular calendar of holidays to determine how many days exist between the valuation date and the maturity of the contract. A *Business Days* calculator is a small piece of software used to perform this important step of the valuation process.
While there are many implementations of *Business Days* calculators out there, the usual implementation is based on this kind of algorithm:
```R
dt0 = initial_date
dt1 = final_date
holidays = vector_of_holidays
bdays = 0
while d0 <= d1
    if d0 not in holidays
        bdays = bdays + 1
    end
    d0 = d0 + 1
end while
```

This works fine for general use. But the performance becomes an issue if one must repeat this calculation many times. Say you have 50 000 contracts, each contract with 20 cash flows. If you need to apply this algorithm to each cash flow, you will need to perform it 1 000 000 times.

For instance, let's try out this code using *R* and *QuantLib* (*RQuantLib* package):
```R
library(RQuantLib)
library(microbenchmark)

from <- as.Date("2015-06-29")
to <- as.Date("2100-12-20")
microbenchmark(businessDaysBetween("Brazil", from, to))

from_vect <- rep(from, 1000000)
to_vect <- rep(to, 1000000)
microbenchmark(businessDaysBetween("Brazil", from_vect, to_vect), times=1)
```

Running this code, we get the following: *(only the fastest execution is shown)*
```
Unit: milliseconds
                                    expr     min
 businessDaysBetween("Brazil", from, to) 1.63803

Unit: seconds
                                              expr      min
 businessDaysBetween("Brazil", from_vect, to_vect) 1837.476

```

While one computation takes up to 2 milliseconds, we're in trouble if we have to repeat it for the whole portfolio: it takes about **half an hour** to complete. This is not due to R's performance, because *RQuantLib* is a simple wrapper to QuantLib *C++* library.

**BusinessDays.jl** uses a *tailor-made* cache to store Business Days results, reducing the time spent to the order of a few *microseconds* for a single computation. Also, the time spent to process the whole portfolio is reduced to **under a second**.

It's also important to point out that the initialization of the memory cache, which is done only once for each Julia runtime session, takes less than *half a second*, including JIT compilation time. Also, the *memory footprint* required for each cached calendar should take around 0.7 MB.

**Example Code**
```julia
using BusinessDays
bd = BusinessDays

d0 = Date(2015, 06, 29) ; d1 = Date(2100, 12, 20)

cal = bd.Brazil()
@time bd.initcache(cal)
bdays(cal, d0, d1) # force JIT compilation
@time bdays(cal, d0, d1)
@time for i in 1:1000000 bdays(cal, d0, d1) end
```

**Results**
```
0.177943 seconds (245.69 k allocations: 12.450 MB)
0.000007 seconds (9 allocations: 240 bytes)
0.427177 seconds (5.00 M allocations: 76.294 MB, 2.23% gc time)
```

**There's no magic**

If we disable BusinessDays's cache, however, the performance is worse than QuantLib's implementation. It takes around 1 hour to process the same benchmark test.

```julia
julia> BusinessDays.cleancache() # cleans existing cache
julia> @time for i in 1:1000000 bdays(cal, d0, d1) end
# 4025.424090 seconds (31.22 G allocations: 2.272 TB, 8.14% gc time)
```

It's important to point out that **cache is disabled by default**. So, in order to take advantage of high speed computation provided by this package, one must call `BusinessDays.initcache` function.

##Usage
```julia
julia> using BusinessDays
julia> BusinessDays.initcache(:USSettlement) # creates cache for US Federal holidays, allowing fast computations
BusinessDays.HolidayCalendarCache(BusinessDays.USSettlement(),Bool[false,true,true,true,false,false,true,true,true,true  …  true,false,false,true,true,true,true,true,false,false],UInt32[0x00000000,0x00000001,0x00000002,0x00000003,0x00000003,0x00000003,0x00000004,0x00000005,0x00000006,0x00000007  …  0x0000a78d,0x0000a78d,0x0000a78d,0x0000a78e,0x0000a78f,0x0000a790,0x0000a791,0x0000a792,0x0000a792,0x0000a792],1980-01-01,2150-12-20)

julia> isbday(:USSettlement, Date(2015, 01, 01)) # New Year's Day - Thursday
false

julia> tobday(:USSettlement, Date(2015, 01, 01)) # Adjust to next business day
2015-01-02

julia> tobday(:USSettlement, Date(2015, 01, 01); forward = false) # Adjust to last business day
2014-12-31

julia> advancebdays(:USSettlement, Date(2015, 01, 02), 1) # advances 1 business day
2015-01-05

julia> advancebdays(:USSettlement, Date(2015, 01, 02), -1) # goes back 1 business day
2014-12-31

julia> bdays(:USSettlement, Date(2014, 12, 31), Date(2015, 01, 05)) # counts the number of business days between dates
2 days

julia> isbday(:USSettlement, [Date(2014,12,31),Date(2015,01,01),Date(2015,01,02),Date(2015,01,03),Date(2015,01,05)])
5-element Array{Bool,1}:
  true
 false
  true
 false
  true

julia> bdays(:USSettlement, [Date(2014,12,31),Date(2015,01,02)], [Date(2015,01,05),Date(2015,01,05)])
2-element Array{Base.Dates.Day,1}:
 2 days
 1 day 

```

See *runtests.jl* for more examples.

##Package Documentation

**HolidayCalendar**

*Abstract* type for Holiday Calendars.

**BusinessDays.easter_rata(y::Year) → Int**

Returns Easter date as a *[Rata Die](https://en.wikipedia.org/wiki/Rata_Die)* number.

**BusinessDays.easter_date(y::Year) → Date**

Returns result of `easter_rata` as a `Date` instance.

**BusinessDays.findweekday(weekday_target::Int, yy::Int, mm::Int, occurrence::Int, ascending::Bool) → Date**

Given a year `yy` and month `mm`, finds a date where a choosen weekday occurs.

`weekday_target` values are declared in module `Base.Dates`: 
`Monday,Tuesday,Wednesday,Thursday,Friday,Saturday,Sunday = 1,2,3,4,5,6,7`.

If `ascending` is true, searches from the beggining of the month. If false, searches from the end of the month.

If `occurrence` is `2` and `weekday_target` is `Monday`, searches the 2nd Monday of the given month, and so on.

**isholiday(calendar, dt)**

Checks if `dt` is a holiday based on a given `calendar` of holidays.

`calendar` can be an instance of `HolidayCalendar`,  a `Symbol` or an `AbstractString`.

Returns boolean values.

**isweekend(dt)**

Returns `true` for Saturdays or Sundays.
Returns `false` otherwise.

**isbday(calendar, dt)**

Returns `true` for weekends or holidays.
Returns `false` otherwise.

**tobday(calendar, dt; [forward=true])**

Adjusts `dt` to next Business Day if it's not a Business Day.
If `isbday(dt)`, returns `dt`.

**advancebdays(calendar, dt, bdays_count)**

Increments given date `dt` by `bdays_count`.
Decrements it if `bdays_count` is negative.
`bdays_count` can be a `Int`, `Vector{Int}` or a `UnitRange`.

Computation starts by next Business Day if `dt` is not a Business Day.

**bdays(calendar, dt0, dt1)**

Counts the number of Business Days between `dt0` and `dt1`.
Returns instances of `Dates.Day`.

Computation is always based on next Business Day if given dates are not Business Days.

**listholidays(calendar, dt0::Date, dt1::Date) → Vector{Date}**

Returns the list of holidays between `dt0` and `dt1`.

**listbdays(calendar, dt0::Date, dt1::Date) → Vector{Date}**

Returns the list of business days between `dt0` and `dt1`.

**BusinessDays.initcache(calendar, [d0], [d1])**

Creates cache for a given Holiday Calendar. After calling this function, any call to `isbday`
function, or any function that uses `isbday`, will be optimized to use this cache.

You can pass `calendar` as an instance of `HolidayCalendar`, `Symbol` or `AbstractString`.
You can also pass `calendar` as an `AbstractArray` of those types.

**BusinessDays.cleancache([calendar])**

Cleans cache for a given instance or list of `HolidayCalendar`, `Symbol` or `AbstractString`.

##Available Business Days Calendars
- **BRSettlement** or **Brazil** : banking holidays for Brazil (federal holidays plus Carnival).
- **USSettlement** or **UnitedStates**: United States federal holidays.
- **USNYSE** : United States NYSE holidays.
- **USGovernmentBond** : United States Government Bond calendar.
- **UKSettlement** or **UnitedKingdom**: banking holidays for England and Wales.
- **CompositeHolidayCalendar** : supports combination of Holiday Calendars.

## Adding new Holiday Calendars
You can add your custom Holiday Calendar by doing the following:

1. Define a subtype of `HolidayCalendar`.
2. Implement a new method for `isholiday` for your calendar.

**Example Code**

```julia
using BusinessDays
import BusinessDays.isholiday

type CustomCalendar <: HolidayCalendar end
isholiday(::CustomCalendar, dt::Date) = dt == Date(2015,8,27)

cc = CustomCalendar()
println("$(isholiday(cc, Date(2015,8,26)))")
println("$(isholiday(cc, Date(2015,8,27)))")
```

## Alternative Libraries

* Ito.jl: http://aviks.github.io/Ito.jl/time.html

* FinancialMarkets.jl: https://github.com/imanuelcostigan/FinancialMarkets.jl

* QuantLib.jl : https://github.com/pazzo83/QuantLib.jl
