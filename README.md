#BusinessDays.jl
A highly optimized *Business Days* calculator written in Julia language.
Also known as *Working Days* calculator.

**Installation**: 
```
julia> Pkg.update()
julia> Pkg.add("BusinessDays")
```
*Current version is v0.0.2*

[![Build Status](https://travis-ci.org/felipenoris/BusinessDays.jl.svg?branch=master)](https://travis-ci.org/felipenoris/BusinessDays.jl)

##Motivation
This code was developed with a mindset of a Financial Institution that has a big *Fixed Income* portfolio. Many financial contracts, especially *Fixed Income instruments*, depend on a particular calendar of holidays to determine how many days exist between the valuation date and the maturity of the contract. A *Business Days* calculator is a small piece of software used to perform this important step of the valuation process.
While there are many implementations of *Business Days* calculators out there, the usual implementation is based on this kind of algorithm:
```
dt0 = initial_date
dt1 = final_date
holidays = vector_of_holidays
bdays = 0
while d0 <= d1
	if d0 not in holidays
		bdays = bdays + 1
	end
	d0 = d0 +1
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

Running this code, we get the following:
```
Unit: milliseconds
                                    expr     min       lq     mean   median       uq      max neval
 businessDaysBetween("Brazil", from, to) 1.63803 1.663067 1.869885 1.698184 1.969011 3.594702   100

Unit: seconds
                                              expr      min       lq     mean   median       uq      max neval
 businessDaysBetween("Brazil", from_vect, to_vect) 1837.476 1837.476 1837.476 1837.476 1837.476 1837.476     1

```

While one computation takes up to 2 milliseconds, we're in trouble if we have to repeat it for the whole portfolio: it takes about **half an hour** to complete.

**BusinessDays.jl** uses a *tailor-made* cache to store Business Days results, reducing the time spent to the order of a few *microseconds* for a single computation. Also, the time spent to process the whole portfolio is reduced to **under a second**.

It's also important to point out that the initialization of the memory cache, which is done only once for each Julia runtime session, takes less than *half a second*, including JIT compilation time. Also, the *memory footprint* required for each cached calendar should take around 0.7 MB.

**Example Code**
```julia
using Base.Dates
using BusinessDays
using Base.Test

d0 = Date(1950, 01, 01); d1 = Date(2100, 12, 20)

cal = BrazilBanking()
@time BusinessDays.initcache(cal)
bdays(cal, d0, d1) # force JIT compilation
@time bdays(cal, d0, d1)
@time for i in 1:1000000 bdays(cal, d0, d1) end
```

**Results**
```
 210.319 milliseconds (489 k allocations: 19372 KB, 9.45% gc time)
   3.859 microseconds (10 allocations: 240 bytes)
 633.931 milliseconds (6000 k allocations: 93750 KB, 0.94% gc time)
 ```

##Usage
See *runtests.jl* for examples.

##Package Documentation

**HolidayCalendar**

*Abstract* type for Holiday Calendars.

**holidaycalendarlist()**

Accessor function for `HolidayCalendar` subtypes.

**easter_rata(y :: Year)**

Returns Easter date as a *[Rata Die](https://en.wikipedia.org/wiki/Rata_Die)* number (`Int64`).

**easter_date(y :: Year)**

Returns result of `easter_rata` as a `Base.Date` instance.

**isholiday(hc :: HolidayCalendar, dt :: TimeType)**

Checks if `dt` is a holiday. Returns Bool.

**findweekday(weekday_target :: Int64, yy :: Int64, mm :: Int64, occurrence :: Int64, ascending :: Bool)**

Given a year `yy` and month `mm`, finds a date where a choosen weekday occurs.
`weekday_target` values are declared in the `Dates` module.
`const Monday,Tuesday,Wednesday,Thursday,Friday,Saturday,Sunday = 1,2,3,4,5,6,7`
If `ascending` is true, searches from the beggining of the month. If false, searches from the end of the month.
If `occurrence` is 2 and `weekday_target` is Monday, searches the 2nd Monday of the given month, and so on.

**isweekend(x :: TimeType)**

Checks if `x` is a weekend day.

**isbday(hc :: HolidayCalendar, dt :: TimeType)**

Checks for a Business Day. Usually it checks two conditions: whether it's not a holiday, and not a weekend day.

**tobday(hc :: HolidayCalendar, dt :: TimeType; forward :: Bool = true)**

Ajusts given date to next Business Day if `forward = true`.
Ajusts to the last Business Day if `forward = false`.

**advancebdays(hc :: HolidayCalendar, dt :: TimeType, bdays_count :: Int)**

Ajusts given date `bdays_count` Business Days forward (or backwards if `bdays_count` is negative).

**bdays(hc :: HolidayCalendar, dt0 :: TimeType, dt1 :: TimeType)**

Counts number of Business Days between `dt0` and `dt1`.

**initcache(hc :: HolidayCalendar)**

Creates cache for given calendar. Check `methods(initcache)` for alternatives.

##Available Business Days Calendars
- **BrazilBanking** : banking holidays for Brazil (federal holidays plus Carnival).
- **UnitedStates** : United States federal holidays.
- **UKEnglandBanking** : banking holidays for England and Wales.

## Adding new Holiday Calendars
You can add your custom Holiday Calendar by doing the following:

1. Define an immutable subtype of HolidayCalendar. `immutable MyCal <: HolidayCalendar end`
2. Implement a new method for `isholiday` for your calendar. `function isholiday(:: MyCal, dt :: TimeType)`

And that's it.

##Requirements
This package was writen in pure Julia code.
Although the code does not depend on packages outside Base, it requires Julia v0.4 *cutting-edge* version, due to the Dates module.

##But, why Julia?
Julia is an alternative language to Matlab, R, Scilab, Python, and others, but without the *non-vectorizable code penalty*. In fact, the following two pieces of code run with almost the same performance. This is due to the JIT compiler built into the julia runtime.

```julia
# sum all elements of 2 vectors, quick code
function sum2V(x, y)
	sum(x) + sum(y)
end

# sum all elements of 2 vectors, specialized code
function sum2V_2(x::Array{Float64, 1}, y::Array{Float64, 1})

  const lx = length(x)
  const ly = length(y)
  
  if lx != ly
    error("x y must have equal sizes")
  end
  
  r::Float64 = 0
  for i = 1:lx
    r += x[i] + y[i]
  end
  
  return r
end

x = rand(convert(Int, 1e7))
y = rand(convert(Int, 1e7))

r1 = sum2V(x, y)
r2 = sum2V_2(x, y)

@time sum2V(x, y)
@time sum2V_2(x, y)
```

I would like to point out that, currently, there's nothing special about the **BusinessDays.jl** implementation. One could implement the same code in any computer language, using standard data structures. As a matter of fact, I've done this before in VBA and C, with similar performance results. But, I decided to do it in Julia for the following reasons:
* The Julia Language is all about optimization.
* The Julia Language is a lot of fun to code in.
* I would like to encourage others to get to know about Julia.

You can find more about Julia at http://julialang.org.

There's also an alternative library to Business Days counting in Julia at http://aviks.github.io/Ito.jl/time.html .

##Roadmap for v0.1.0
- [ ] Include helper functions for vector inputs.
- [x] Use Julia's package development tools (Pkg).
- [x] Holiday Calendar for United States.
- [x] Holiday Calendar for UK.
- [ ] Package documentation using Julia's framework.
- [x] Package documentation on Readme file.
- [x] Add this package to Julia's official package list.
- [ ] Support for Composite Holiday Calendars.
