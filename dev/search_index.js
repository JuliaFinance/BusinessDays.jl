var documenterSearchIndex = {"docs":
[{"location":"api/#API-Reference","page":"API Reference","title":"API Reference","text":"","category":"section"},{"location":"api/","page":"API Reference","title":"API Reference","text":"BusinessDays.HolidayCalendar\nBusinessDays.easter_rata\nBusinessDays.easter_date\nBusinessDays.findweekday\nBusinessDays.isholiday\nBusinessDays.isweekend\nBusinessDays.isweekday\nBusinessDays.isbday\nBusinessDays.tobday\nBusinessDays.advancebdays\nBusinessDays.bdays\nBusinessDays.bdayscount\nBusinessDays.firstbdayofmonth\nBusinessDays.lastbdayofmonth\nBusinessDays.listholidays\nBusinessDays.listbdays\nBusinessDays.initcache\nBusinessDays.cleancache","category":"page"},{"location":"api/#BusinessDays.HolidayCalendar","page":"API Reference","title":"BusinessDays.HolidayCalendar","text":"Abstract type for Holiday Calendars.\n\n\n\n\n\n","category":"type"},{"location":"api/#BusinessDays.easter_rata","page":"API Reference","title":"BusinessDays.easter_rata","text":"easter_rata(y::Dates.Year) → Int\n\nReturns Easter date as a Rata Die number.\n\nBased on Algo R.\n\n\n\n\n\n","category":"function"},{"location":"api/#BusinessDays.easter_date","page":"API Reference","title":"BusinessDays.easter_date","text":"easter_date(y::Dates.Year) → Dates.Date\n\nReturns result of easter_rata as a Dates.Date instance.\n\n\n\n\n\n","category":"function"},{"location":"api/#BusinessDays.findweekday","page":"API Reference","title":"BusinessDays.findweekday","text":"findweekday(weekday_target::Integer, yy::Integer, mm::Integer, occurrence::Integer, ascending::Bool) → Date\n\nGiven a year yy and month mm, finds a date where a choosen weekday occurs.\n\nweekday_target values are declared in module Base.Dates: Monday,Tuesday,Wednesday,Thursday,Friday,Saturday,Sunday = 1,2,3,4,5,6,7.\n\nIf ascending is true, searches from the beginning of the month. If false, searches from the end of the month.\n\nIf occurrence is 2 and weekday_target is Monday, searches the 2nd Monday of the given month, and so on.\n\n\n\n\n\n","category":"function"},{"location":"api/#BusinessDays.isholiday","page":"API Reference","title":"BusinessDays.isholiday","text":"isholiday(calendar, dt) :: Bool\n\nChecks if dt is a holiday based on a given calendar of holidays.\n\ncalendar can be an instance of HolidayCalendar,  a Symbol or an AbstractString.\n\n\n\n\n\nisholiday(cal::DE, dt::Dates.Date)::Bool\n\nReturn true if dt is a is a holiday in the German calender (cal), otherwise false.\n\n\n\n\n\n","category":"function"},{"location":"api/#BusinessDays.isweekend","page":"API Reference","title":"BusinessDays.isweekend","text":"isweekend(dt) :: Bool\n\nReturns true for Saturdays or Sundays. Returns false otherwise.\n\n\n\n\n\n","category":"function"},{"location":"api/#BusinessDays.isweekday","page":"API Reference","title":"BusinessDays.isweekday","text":"isweekday(dt) :: Bool\n\nReturns true for Monday to Friday. Returns false otherwise.\n\n\n\n\n\n","category":"function"},{"location":"api/#BusinessDays.isbday","page":"API Reference","title":"BusinessDays.isbday","text":"isbday(calendar, dt) :: Bool\n\nReturns false for weekends or holidays. Returns true otherwise.\n\n\n\n\n\n","category":"function"},{"location":"api/#BusinessDays.tobday","page":"API Reference","title":"BusinessDays.tobday","text":"tobday(calendar, dt; [forward=true]) :: Dates.Date\n\nAdjusts dt to next Business Day if it's not a Business Day. If isbday(dt), returns dt.\n\n\n\n\n\n","category":"function"},{"location":"api/#BusinessDays.advancebdays","page":"API Reference","title":"BusinessDays.advancebdays","text":"advancebdays(calendar, dt, bdays_count) :: Dates.Date\n\nIncrements given date dt by bdays_count. Decrements it if bdays_count is negative. bdays_count can be a Int, Dates.Day, Vector{Int}, Vector{Dates.Day} or a UnitRange.\n\nComputation starts by next Business Day if dt is not a Business Day.\n\n\n\n\n\n","category":"function"},{"location":"api/#BusinessDays.bdays","page":"API Reference","title":"BusinessDays.bdays","text":"bdays(calendar, dt0, dt1) :: Dates.Day\n\nCounts the number of Business Days between dt0 and dt1. Returns instances of Dates.Day.\n\nComputation is always based on next Business Day if given dates are not Business Days.\n\n\n\n\n\n","category":"function"},{"location":"api/#BusinessDays.bdayscount","page":"API Reference","title":"BusinessDays.bdayscount","text":"bdayscount(calendar, dt0, dt1) :: Int\n\nCounts the number of Business Days between dt0 and dt1. Returns Int.\n\nComputation is always based on next Business Day if given dates are not Business Days.\n\n\n\n\n\n","category":"function"},{"location":"api/#BusinessDays.firstbdayofmonth","page":"API Reference","title":"BusinessDays.firstbdayofmonth","text":"firstbdayofmonth(calendar, dt) :: Dates.Date\nfirstbdayofmonth(calendar, yy, mm) :: Dates.Date\n\nReturns the first business day of month.\n\n\n\n\n\n","category":"function"},{"location":"api/#BusinessDays.lastbdayofmonth","page":"API Reference","title":"BusinessDays.lastbdayofmonth","text":"lastbdayofmonth(calendar, dt) :: Dates.Date\nlastbdayofmonth(calendar, yy, mm) :: Dates.Date\n\nReturns the last business day of month.\n\n\n\n\n\n","category":"function"},{"location":"api/#BusinessDays.listholidays","page":"API Reference","title":"BusinessDays.listholidays","text":"listholidays(calendar, dt0::Dates.Date, dt1::Dates.Date) → Vector{Dates.Date}\n\nReturns the list of holidays between dt0 and dt1.\n\n\n\n\n\n","category":"function"},{"location":"api/#BusinessDays.listbdays","page":"API Reference","title":"BusinessDays.listbdays","text":"listbdays(calendar, dt0::Dates.Date, dt1::Dates.Date) → Vector{Dates.Date}\n\nReturns the list of business days between dt0 and dt1.\n\n\n\n\n\n","category":"function"},{"location":"api/#BusinessDays.initcache","page":"API Reference","title":"BusinessDays.initcache","text":"initcache(calendar, [d0], [d1])\n\nCreates cache for a given Holiday Calendar. After calling this function, any call to isbday function, or any function that uses isbday, will be optimized to use this cache.\n\nYou can pass calendar as an instance of HolidayCalendar, Symbol or AbstractString. You can also pass calendar as an AbstractArray of those types.\n\n\n\n\n\n","category":"function"},{"location":"api/#BusinessDays.cleancache","page":"API Reference","title":"BusinessDays.cleancache","text":"cleancache([calendar])\n\nCleans cache for a given instance or list of HolidayCalendar, Symbol or AbstractString.\n\n\n\n\n\n","category":"function"},{"location":"#BusinessDays.jl","page":"Home","title":"BusinessDays.jl","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"A highly optimized Business Days calculator written in Julia language. Also known as Working Days calculator.","category":"page"},{"location":"#Requirements","page":"Home","title":"Requirements","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"Julia v1.0 or newer.","category":"page"},{"location":"#Installation","page":"Home","title":"Installation","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"From a Julia session, run:","category":"page"},{"location":"","page":"Home","title":"Home","text":"julia> using Pkg\n\njulia> Pkg.add(\"BusinessDays\")","category":"page"},{"location":"#Motivation","page":"Home","title":"Motivation","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"This code was developed with a mindset of a Financial Institution that has a big Fixed Income portfolio. Many financial contracts, specially Fixed Income instruments, depend on a particular calendar of holidays to determine how many days exist between the valuation date and the maturity of the contract. A Business Days calculator is a small piece of software used to perform this important step of the valuation process.","category":"page"},{"location":"","page":"Home","title":"Home","text":"While there are many implementations of Business Days calculators out there, the usual implementation is based on this kind of algorithm:","category":"page"},{"location":"","page":"Home","title":"Home","text":"dt0 = initial_date\ndt1 = final_date\nholidays = vector_of_holidays\nbdays = 0\nwhile d0 <= d1\n    if d0 not in holidays\n        bdays = bdays + 1\n    end\n    d0 = d0 + 1\nend while","category":"page"},{"location":"","page":"Home","title":"Home","text":"This works fine for general use. But the performance becomes an issue if one must repeat this calculation many times. Say you have 50 000 contracts, each contract with 20 cash flows. If you need to apply this algorithm to each cash flow, you will need to perform it 1 000 000 times.","category":"page"},{"location":"","page":"Home","title":"Home","text":"For instance, let's try out this code using R and QuantLib (RQuantLib):","category":"page"},{"location":"","page":"Home","title":"Home","text":"library(RQuantLib)\nlibrary(microbenchmark)\n\nfrom <- as.Date(\"2015-06-29\")\nto <- as.Date(\"2100-12-20\")\nmicrobenchmark(businessDaysBetween(\"Brazil\", from, to))\n\nfrom_vect <- rep(from, 1000000)\nto_vect <- rep(to, 1000000)\nmicrobenchmark(businessDaysBetween(\"Brazil\", from_vect, to_vect), times=1)","category":"page"},{"location":"","page":"Home","title":"Home","text":"Running this code, we get the following: (only the fastest execution is shown)","category":"page"},{"location":"","page":"Home","title":"Home","text":"Unit: milliseconds\n                                    expr     min\n businessDaysBetween(\"Brazil\", from, to) 1.63803\n\nUnit: seconds\n                                              expr      min\n businessDaysBetween(\"Brazil\", from_vect, to_vect) 1837.476\n","category":"page"},{"location":"","page":"Home","title":"Home","text":"While one computation takes up to 2 milliseconds, we're in trouble if we have to repeat it for the whole portfolio: it takes about half an hour to complete. This is not due to R's performance, because RQuantLib is a simple wrapper to QuantLib C++ library.","category":"page"},{"location":"","page":"Home","title":"Home","text":"BusinessDays.jl uses a tailor-made cache to store Business Days results, reducing the time spent to the order of a few microseconds for a single computation. Also, the time spent to process the whole portfolio is reduced to under a second.","category":"page"},{"location":"","page":"Home","title":"Home","text":"It's also important to point out that the initialization of the memory cache, which is done only once for each Julia runtime session, takes less than half a second, including JIT compilation time. Also, the memory footprint required for each cached calendar should take around 0.7 MB.","category":"page"},{"location":"","page":"Home","title":"Home","text":"Benchmark Code","category":"page"},{"location":"","page":"Home","title":"Home","text":"julia> using BusinessDays, Dates\n\njulia> d0 = Date(2015, 06, 29) ; d1 = Date(2100, 12, 20) ;\n\njulia> cal = BusinessDays.BRSettlement()\nBusinessDays.BRSettlement()\n\njulia> @time BusinessDays.initcache(cal)\n  0.161972 seconds (598.85 k allocations: 30.258 MiB, 2.29% gc time)\n\njulia> bdays(cal, d0, d1) # force JIT compilation\n21471 days\n\njulia> @time bdays(cal, d0, d1)\n  0.000012 seconds (9 allocations: 240 bytes)\n21471 days\n\njulia> @time for i in 1:1000000 bdays(cal, d0, d1) end\n  0.221275 seconds (5.00 M allocations: 76.294 MiB, 2.93% gc time)","category":"page"},{"location":"","page":"Home","title":"Home","text":"There's no magic","category":"page"},{"location":"","page":"Home","title":"Home","text":"If we disable BusinessDays's cache, however, the performance is slightly worse than QuantLib's implementation. It takes around 38 minutes to process the same benchmark test.","category":"page"},{"location":"","page":"Home","title":"Home","text":"julia> BusinessDays.cleancache() # cleans existing cache, if any\n\njulia> @time for i in 1:1000000 bdays(cal, d0, d1) end\n# 2288.906548 seconds (5.00 M allocations: 76.294 MB, 0.00% gc time)","category":"page"},{"location":"","page":"Home","title":"Home","text":"It's important to point out that cache is disabled by default. So, in order to take advantage of high speed computation provided by this package, one must call BusinessDays.initcache function.","category":"page"},{"location":"#Tutorial","page":"Home","title":"Tutorial","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"julia> using BusinessDays, Dates\n\n# creates cache for US Federal holidays, allowing fast computations\njulia> BusinessDays.initcache(:USSettlement)\n\n# Calendars can be referenced using symbols\njulia> isbday(:USSettlement, Date(2015, 1, 1))\nfalse\n\n# ... and also strings\njulia> isbday(\"USSettlement\", Date(2015, 1, 1))\nfalse\n\n# but for the best performance, use a singleton instance\njulia> isbday(BusinessDays.USSettlement(), Date(2015, 1, 1))\nfalse\n\n# Adjust to next business day\njulia> tobday(:USSettlement, Date(2015, 1, 1))\n2015-01-02\n\n# Adjust to last business day\njulia> tobday(:USSettlement, Date(2015, 1, 1); forward = false)\n2014-12-31\n\n# advances 1 business day\njulia> advancebdays(:USSettlement, Date(2015, 1, 2), 1)\n2015-01-05\n\n# goes back 1 business day\njulia> advancebdays(:USSettlement, Date(2015, 1, 2), -1)\n2014-12-31\n\n# counts the number of business days between dates\njulia> bdays(:USSettlement, Date(2014, 12, 31), Date(2015, 1, 5))\n2 days\n\n# same as above, but returns integer\njulia> bdayscount(:USSettlement, Date(2014, 12, 31), Date(2015, 1, 5))\n2\n\njulia> isbday(:USSettlement, [Date(2014,12,31),Date(2015,1,1),Date(2015,1,2),Date(2015,1,3),Date(2015,1,5)])\n5-element Array{Bool,1}:\n  true\n false\n  true\n false\n  true\n\njulia> bdays(:USSettlement, [Date(2014,12,31),Date(2015,1,2)], [Date(2015,1,5),Date(2015,1,5)])\n2-element Array{Base.Dates.Day,1}:\n 2 days\n 1 day\n","category":"page"},{"location":"","page":"Home","title":"Home","text":"See runtests.jl for more examples.","category":"page"},{"location":"#Available-Business-Days-Calendars","page":"Home","title":"Available Business Days Calendars","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"AustraliaASX : Public holidays for the Australian Stock Exchange (ASX).\nAustralia(state) : Public holidays for the Australian states and territories. Available for each state: Australia(:ACT), Australia(:NSW), Australia(:NT), Australia(:QLD), Australia(:SA), Australia(:TAS), Australia(:WA), Australia(:VIC).\nBRSettlement or Brazil : banking holidays for Brazil (federal holidays plus Carnival).\nBrazilExchange or BrazilB3 : holidays for B3 Stock Exchange.\nCanadaSettlement or Canada: holidays for Canada.\nCanadaTSX: holidays for Toronto Stock Exchange\nCompositeHolidayCalendar : supports combination of Holiday Calendars.\nGermany(state) or DE(state) : State-wide (except BY/BYP) public holidays for the German federal states.\nAvailable for each state: Germany(:BW), Germany(:BY) (including Assumption of Mary for Catholic communities), Germany(:BYP) (only Protestant communities without Assumption of Mary), Germany(:BE), Germany(:BB), Germany(:HB), Germany(:HH), Germany(:HE), Germany(:MV), Germany(:NI), Germany(:NW), Germany(:RP), Germany(:SL), Germany(:SN), Germany(:ST), Germany(:SH), Germany(:TH).\nNullHolidayCalendar : isholiday returns false and isbday returns true for any date. bdays returns the actual days between dates.\nTARGET or TARGET2 or EuroZone : TARGET / TARGET2 Euro Zone holiday calendar.\nUSSettlement or UnitedStates: United States federal holidays.\nUSNYSE : United States NYSE holidays.\nUSGovernmentBond : Broadly accepted holidays for United States Government Bond market. SOFR Rate calendar. See https://www.sifma.org/resources/general/holiday-schedule/.\nUKSettlement or UnitedKingdom: banking holidays for England and Wales. See https://www.gov.uk/bank-holidays.\nWeekendsOnly : for this calendar, isholiday returns false, but isbday returns false for Saturdays and Sundays.","category":"page"},{"location":"#Adding-new-Holiday-Calendars","page":"Home","title":"Adding new Holiday Calendars","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"You can add your custom Holiday Calendar by doing the following:","category":"page"},{"location":"","page":"Home","title":"Home","text":"Define a subtype of HolidayCalendar.\nImplement a new method for isholiday for your calendar.","category":"page"},{"location":"","page":"Home","title":"Home","text":"Example Code","category":"page"},{"location":"","page":"Home","title":"Home","text":"julia> using BusinessDays, Dates\n\njulia> struct CustomCalendar <: HolidayCalendar end\n\njulia> BusinessDays.isholiday(::CustomCalendar, dt::Date) = dt == Date(2015,8,27)\n\njulia> cc = CustomCalendar()\nCustomCalendar()\n\njulia> isholiday(cc, Date(2015,8,26))\nfalse\n\njulia> isholiday(cc, Date(2015,8,27))\ntrue\n\njulia> isholiday(:CustomCalendar, Date(2015,8,27))\ntrue\n\njulia> isholiday(\"CustomCalendar\", Date(2015,8,27))\ntrue","category":"page"},{"location":"#Generic-Holiday-Calendar","page":"Home","title":"Generic Holiday Calendar","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"You can use a fixed set of holidays to define a new Holiday Calendar using GenericHolidayCalendar type.","category":"page"},{"location":"","page":"Home","title":"Home","text":"julia> using BusinessDays, Dates\n\njulia> holidays = Set([Date(2018,1,16), Date(2018,1,18)])\n\njulia> dtmin = Date(2018,1,15); dtmax = Date(2018,1,19)\n\njulia> gen_calendar = GenericHolidayCalendar(holidays, dtmin, dtmax)\n\njulia> bdayscount(gen_calendar, Date(2018,1,15), Date(2018,1,17))\n1","category":"page"},{"location":"","page":"Home","title":"Home","text":"The constructor is given by: GenericHolidayCalendar(holidays, [dtmin], [dtmax], [_initcache_]), where","category":"page"},{"location":"","page":"Home","title":"Home","text":"holidays: a set of holiday dates\ndtmin: minimum date allowed to check for holidays in holidays set. Defaults to min(holidays...).\ndtmax: maximum date allowed to check for holidays in holidays set. Defaults to max(holidays...).\n_initcache_: initializes the cache for this calendar. Defaults to true.","category":"page"},{"location":"#Source-Code","page":"Home","title":"Source Code","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"The source code for this package is hosted at https://github.com/JuliaFinance/BusinessDays.jl.","category":"page"},{"location":"#License","page":"Home","title":"License","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"The source code for the package BusinessDays.jl is licensed under the MIT License.","category":"page"},{"location":"#Alternative-Packages","page":"Home","title":"Alternative Packages","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"Ito.jl\nFinancialMarkets.jl\nQuantLib.jl\nQuantLib C++ Library","category":"page"}]
}
