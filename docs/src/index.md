
# BusinessDays.jl

A highly optimized *Business Days* calculator written in Julia language.
Also known as *Working Days* calculator.

## Requirements

* Julia v1.0 or newer.

## Installation

From a Julia session, run:

```julia
julia> using Pkg

julia> Pkg.add("BusinessDays")
```

## Motivation

This code was developed with a mindset of a Financial Institution that has a big *Fixed Income* portfolio.
Many financial contracts, specially *Fixed Income instruments*, depend on a particular calendar of holidays
to determine how many days exist between the valuation date and the maturity of the contract.
A *Business Days* calculator is a small piece of software used to perform this important step of the valuation process.

While there are many implementations of *Business Days* calculators out there,
the usual implementation is based on this kind of algorithm:

```r
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

For instance, let's try out this code using *R* and [QuantLib](https://github.com/lballabio/QuantLib) ([RQuantLib](https://github.com/eddelbuettel/rquantlib)):

```r
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

While one computation takes up to 2 milliseconds, we're in trouble if we have to repeat it for the whole portfolio: it takes about **half an hour** to complete. This is not due to R's performance, because [RQuantLib](https://github.com/eddelbuettel/rquantlib) is a simple wrapper to [QuantLib](https://github.com/lballabio/QuantLib) C++ library.

**BusinessDays.jl** uses a *tailor-made* cache to store Business Days results, reducing the time spent to the order of a few *microseconds* for a single computation. Also, the time spent to process the whole portfolio is reduced to **under a second**.

It's also important to point out that the initialization of the memory cache, which is done only once for each Julia runtime session, takes less than *half a second*, including JIT compilation time. Also, the *memory footprint* required for each cached calendar should take around 0.7 MB.

**Benchmark Code**

```julia
julia> using BusinessDays, Dates

julia> d0 = Date(2015, 06, 29) ; d1 = Date(2100, 12, 20) ;

julia> cal = BusinessDays.BRSettlement()
BusinessDays.BRSettlement()

julia> @time BusinessDays.initcache(cal)
  0.161972 seconds (598.85 k allocations: 30.258 MiB, 2.29% gc time)

julia> bdays(cal, d0, d1) # force JIT compilation
21471 days

julia> @time bdays(cal, d0, d1)
  0.000012 seconds (9 allocations: 240 bytes)
21471 days

julia> @time for i in 1:1000000 bdays(cal, d0, d1) end
  0.221275 seconds (5.00 M allocations: 76.294 MiB, 2.93% gc time)
```

**There's no magic**

If we disable BusinessDays's cache, however, the performance is slightly worse than QuantLib's implementation. It takes around 38 minutes to process the same benchmark test.

```julia
julia> BusinessDays.cleancache() # cleans existing cache, if any

julia> @time for i in 1:1000000 bdays(cal, d0, d1) end
# 2288.906548 seconds (5.00 M allocations: 76.294 MB, 0.00% gc time)
```

It's important to point out that **cache is disabled by default**. So, in order to take advantage of high speed computation provided by this package, one must call `BusinessDays.initcache` function.

## Tutorial

```julia
julia> using BusinessDays, Dates

# creates cache for US Federal holidays, allowing fast computations
julia> BusinessDays.initcache(:USSettlement)

# Calendars can be referenced using symbols
julia> isbday(:USSettlement, Date(2015, 1, 1))
false

# ... and also strings
julia> isbday("USSettlement", Date(2015, 1, 1))
false

# but for the best performance, use a singleton instance
julia> isbday(BusinessDays.USSettlement(), Date(2015, 1, 1))
false

# Adjust to next business day
julia> tobday(:USSettlement, Date(2015, 1, 1))
2015-01-02

# Adjust to last business day
julia> tobday(:USSettlement, Date(2015, 1, 1); forward = false)
2014-12-31

# advances 1 business day
julia> advancebdays(:USSettlement, Date(2015, 1, 2), 1)
2015-01-05

# goes back 1 business day
julia> advancebdays(:USSettlement, Date(2015, 1, 2), -1)
2014-12-31

# counts the number of business days between dates
julia> bdays(:USSettlement, Date(2014, 12, 31), Date(2015, 1, 5))
2 days

# same as above, but returns integer
julia> bdayscount(:USSettlement, Date(2014, 12, 31), Date(2015, 1, 5))
2

julia> isbday(:USSettlement, [Date(2014,12,31),Date(2015,1,1),Date(2015,1,2),Date(2015,1,3),Date(2015,1,5)])
5-element Array{Bool,1}:
  true
 false
  true
 false
  true

julia> bdays(:USSettlement, [Date(2014,12,31),Date(2015,1,2)], [Date(2015,1,5),Date(2015,1,5)])
2-element Array{Base.Dates.Day,1}:
 2 days
 1 day

```

See *runtests.jl* for more examples.

## Available Business Days Calendars

- **AustraliaASX** : Public holidays for the Australian Stock Exchange (ASX).
- **Australia(state)** : Public holidays for the Australian states and territories. Available for each state: `Australia(:ACT)`, `Australia(:NSW)`, `Australia(:NT)`, `Australia(:QLD)`, `Australia(:SA)`, `Australia(:TAS)`, `Australia(:WA)`, `Australia(:VIC)`.
- **BRSettlement** or **Brazil** : banking holidays for Brazil (federal holidays plus Carnival).
- **BrazilExchange** or **BrazilB3** : holidays for B3 Stock Exchange.
- **CanadaSettlement** or **Canada**: holidays for Canada.
- **CanadaTSX**: holidays for Toronto Stock Exchange
- **CompositeHolidayCalendar** : supports combination of Holiday Calendars.
- **Germany(state)** or **DE(state)** : State-wide (except BY/BYP) public holidays for the German
  federal states. 
  - Available for each state: `Germany(:BW)`, `Germany(:BY)` (including Assumption of
    Mary for Catholic communities), `Germany(:BYP)` (only Protestant communities without Assumption of
    Mary), `Germany(:BE)`, `Germany(:BB)`, `Germany(:HB)`, `Germany(:HH)`, `Germany(:HE)`,
    `Germany(:MV)`, `Germany(:NI)`, `Germany(:NW)`, `Germany(:RP)`, `Germany(:SL)`, `Germany(:SN)`,
    `Germany(:ST)`, `Germany(:SH)`, `Germany(:TH)`.
- **NullHolidayCalendar** : `isholiday` returns `false` and `isbday` returns `true` for any date. `bdays` returns the actual days between dates.
- **TARGET** or **TARGET2** or **EuroZone** : [TARGET / TARGET2 Euro Zone](https://en.wikipedia.org/wiki/TARGET2) holiday calendar.
- **USSettlement** or **UnitedStates**: United States federal holidays.
- **USNYSE** : United States NYSE holidays.
- **USGovernmentBond** : United States Government Bond calendar. See <https://www.sifma.org/resources/general/holiday-schedule/>.
- **UKSettlement** or **UnitedKingdom**: banking holidays for England and Wales.
- **WeekendsOnly** : for this calendar, `isholiday` returns `false`, but `isbday` returns `false` for Saturdays and Sundays.

## Adding new Holiday Calendars

You can add your custom Holiday Calendar by doing the following:

1. Define a subtype of `HolidayCalendar`.
2. Implement a new method for `isholiday` for your calendar.

**Example Code**

```julia
julia> using BusinessDays, Dates

julia> struct CustomCalendar <: HolidayCalendar end

julia> BusinessDays.isholiday(::CustomCalendar, dt::Date) = dt == Date(2015,8,27)

julia> cc = CustomCalendar()
CustomCalendar()

julia> isholiday(cc, Date(2015,8,26))
false

julia> isholiday(cc, Date(2015,8,27))
true

julia> isholiday(:CustomCalendar, Date(2015,8,27))
true

julia> isholiday("CustomCalendar", Date(2015,8,27))
true
```

## Generic Holiday Calendar

You can use a fixed set of holidays to define a new Holiday Calendar using `GenericHolidayCalendar` type.

```julia
julia> using BusinessDays, Dates

julia> holidays = Set([Date(2018,1,16), Date(2018,1,18)])

julia> dtmin = Date(2018,1,15); dtmax = Date(2018,1,19)

julia> gen_calendar = GenericHolidayCalendar(holidays, dtmin, dtmax)

julia> bdayscount(gen_calendar, Date(2018,1,15), Date(2018,1,17))
1
```

The constructor is given by: `GenericHolidayCalendar(holidays, [dtmin], [dtmax], [_initcache_])`, where

* `holidays`: a set of holiday dates

* `dtmin`: minimum date allowed to check for holidays in holidays set. Defaults to `min(holidays...)`.

* `dtmax`: maximum date allowed to check for holidays in holidays set. Defaults to `max(holidays...)`.

* `_initcache_`: initializes the cache for this calendar. Defaults to `true`.

## Source Code

The source code for this package is hosted at
[https://github.com/JuliaFinance/BusinessDays.jl](https://github.com/JuliaFinance/BusinessDays.jl).

## License

The source code for the package **BusinessDays.jl** is licensed under
the [MIT License](https://raw.githubusercontent.com/JuliaFinance/BusinessDays.jl/master/LICENSE).

## Alternative Packages

* [Ito.jl](http://aviks.github.io/Ito.jl/time.html)

* [FinancialMarkets.jl](https://github.com/imanuelcostigan/FinancialMarkets.jl)

* [QuantLib.jl](https://github.com/pazzo83/QuantLib.jl)

* [QuantLib C++ Library](https://github.com/lballabio/QuantLib)
