
using BusinessDays
using Test
import Dates

# Issue #18
Dict(Any[])

# Issue #30
# list holidays for all available calendars
for c in [:BRSettlement, :BrazilExchange, :USNYSE, :USGovernmentBond, :USSettlement, :CanadaTSX, :CanadaSettlement, :EuroZone, :UKSettlement, :AustraliaASX]
    listholidays(c, Dates.Date(1900,1,1), Dates.Date(2100,1,1))
end

# Types
bhc = BusinessDays.Brazil()
ushc = BusinessDays.USSettlement()
ukhc = BusinessDays.UKSettlement()
usnysehc = BusinessDays.USNYSE()
usgovbondhc = BusinessDays.USGovernmentBond()
targethc = BusinessDays.TARGET()
hc_composite_BR_USA = CompositeHolidayCalendar([BusinessDays.Brazil(), BusinessDays.USSettlement()])
all_calendars_vec = [bhc, ushc, ukhc, hc_composite_BR_USA, usnysehc, usgovbondhc]

# two different instances of the same HolidayCalendar subtype should be equal
@test bhc == BusinessDays.Brazil()
@test ushc == BusinessDays.USSettlement()
@test bhc != ushc
@test string(bhc) == "BusinessDays.BRSettlement"

# Check typing system
@test isa(bhc,HolidayCalendar)
@test isa(ushc,HolidayCalendar)
@test isa(ukhc,HolidayCalendar)

include("easter_dates.jl")
include("easter-min-max.jl")

###############
# findweekday
###############
# weekday values:
# const Monday,Tuesday,Wednesday,Thursday,Friday,Saturday,Sunday = 1,2,3,4,5,6,7
# see query.jl on Dates module
# See also dayofweek(dt) function.
# function findweekday(weekday_target :: Int, yy :: Int, mm:: Int, occurrence :: Int, ascending :: Bool )
@test BusinessDays.findweekday(Dates.Monday, 2015, 07, 1, true) == Dates.Date(2015, 07, 06)
@test BusinessDays.findweekday(Dates.Monday, 2015, 07, 2, true) == Dates.Date(2015, 07, 13)
@test BusinessDays.findweekday(Dates.Monday, 2015, 07, 3, true) == Dates.Date(2015, 07, 20)
@test BusinessDays.findweekday(Dates.Monday, 2015, 07, 4, true) == Dates.Date(2015, 07, 27)
@test BusinessDays.findweekday(Dates.Monday, 2015, 07, 5, true) == Dates.Date(2015, 08, 03)

@test BusinessDays.findweekday(Dates.Monday, 2015, 07, 1, false) == Dates.Date(2015, 07, 27)
@test BusinessDays.findweekday(Dates.Monday, 2015, 07, 2, false) == Dates.Date(2015, 07, 20)
@test BusinessDays.findweekday(Dates.Monday, 2015, 07, 3, false) == Dates.Date(2015, 07, 13)
@test BusinessDays.findweekday(Dates.Monday, 2015, 07, 4, false) == Dates.Date(2015, 07, 06)
@test BusinessDays.findweekday(Dates.Monday, 2015, 07, 5, false) == Dates.Date(2015, 06, 29)

@test BusinessDays.findweekday(Dates.Friday, 2015, 07, 1, true) == Dates.Date(2015, 07, 03)
@test BusinessDays.findweekday(Dates.Friday, 2015, 07, 2, true) == Dates.Date(2015, 07, 10)
@test BusinessDays.findweekday(Dates.Friday, 2015, 07, 3, true) == Dates.Date(2015, 07, 17)
@test BusinessDays.findweekday(Dates.Friday, 2015, 07, 4, true) == Dates.Date(2015, 07, 24)
@test BusinessDays.findweekday(Dates.Friday, 2015, 07, 5, true) == Dates.Date(2015, 07, 31)
@test BusinessDays.findweekday(Dates.Friday, 2015, 07, 6, true) == Dates.Date(2015, 08, 07)

@test BusinessDays.findweekday(Dates.Friday, 2015, 07, 1, false) == Dates.Date(2015, 07, 31)
@test BusinessDays.findweekday(Dates.Friday, 2015, 07, 2, false) == Dates.Date(2015, 07, 24)
@test BusinessDays.findweekday(Dates.Friday, 2015, 07, 3, false) == Dates.Date(2015, 07, 17)
@test BusinessDays.findweekday(Dates.Friday, 2015, 07, 4, false) == Dates.Date(2015, 07, 10)
@test BusinessDays.findweekday(Dates.Friday, 2015, 07, 5, false) == Dates.Date(2015, 07, 03)
@test BusinessDays.findweekday(Dates.Friday, 2015, 07, 6, false) == Dates.Date(2015, 06, 26)

@test BusinessDays.findweekday(Dates.Wednesday, 2015, 07, 1, true) == Dates.Date(2015, 07, 01)
@test BusinessDays.findweekday(Dates.Wednesday, 2015, 07, 2, true) == Dates.Date(2015, 07, 08)
@test BusinessDays.findweekday(Dates.Wednesday, 2015, 07, 3, true) == Dates.Date(2015, 07, 15)
@test BusinessDays.findweekday(Dates.Wednesday, 2015, 07, 4, true) == Dates.Date(2015, 07, 22)
@test BusinessDays.findweekday(Dates.Wednesday, 2015, 07, 5, true) == Dates.Date(2015, 07, 29)
@test BusinessDays.findweekday(Dates.Wednesday, 2015, 07, 6, true) == Dates.Date(2015, 08, 05)

@test BusinessDays.findweekday(Dates.Wednesday, 2015, 07, 1, false) == Dates.Date(2015, 07, 29)
@test BusinessDays.findweekday(Dates.Wednesday, 2015, 07, 2, false) == Dates.Date(2015, 07, 22)
@test BusinessDays.findweekday(Dates.Wednesday, 2015, 07, 3, false) == Dates.Date(2015, 07, 15)
@test BusinessDays.findweekday(Dates.Wednesday, 2015, 07, 4, false) == Dates.Date(2015, 07, 08)
@test BusinessDays.findweekday(Dates.Wednesday, 2015, 07, 5, false) == Dates.Date(2015, 07, 01)
@test BusinessDays.findweekday(Dates.Wednesday, 2015, 07, 6, false) == Dates.Date(2015, 06, 24)

@test_throws AssertionError BusinessDays.findweekday(Dates.Wednesday, 2015, 07, -1, false)
@test_throws AssertionError BusinessDays.findweekday(Dates.Wednesday, 2015, 07, -1, true)

# Test this only on 64bit or higher systems
len = typemax(UInt32) + 1
if len > typemax(UInt32)
    d0 = Dates.Date(1950, 2, 1)
    d1 = d0 + Dates.Day(len)
    @test_throws AssertionError BusinessDays._create_bdays_cache_arrays(bhc, d0, d1)
end

# Create HolidayCalendar instances
hc_australiaasx = BusinessDays.AustraliaASX()
hc_australiaact = BusinessDays.Australia(:ACT)
hc_australiansw = BusinessDays.Australia(:NSW)
hc_australiant  = BusinessDays.Australia(:NT)
hc_australiaqld = BusinessDays.Australia(:QLD)
hc_australiasa  = BusinessDays.Australia(:SA)
hc_australiatas = BusinessDays.Australia(:TAS)
hc_australiawa  = BusinessDays.Australia(:WA)
hc_australiavic = BusinessDays.Australia(:VIC)
hc_brazil       = BusinessDays.Brazil()
hc_brazil_bmf   = BusinessDays.BrazilBMF()
hc_usa          = BusinessDays.USSettlement()
hc_uk           = BusinessDays.UKSettlement()
hc_usnyse       = BusinessDays.USNYSE()
hc_usgovbond    = BusinessDays.USGovernmentBond()
hc_canadatsx    = BusinessDays.CanadaTSX()
hc_canada       = BusinessDays.CanadaSettlement()

####################
# Calendar Tests
####################

usecache = false
include("calendar_tests.jl")

usecache = true
include("calendar_tests.jl")

####################
# Performance Tests
####################
include("perftests.jl")

BusinessDays.cleancache(hc_brazil)
BusinessDays.cleancache()

struct TestCalendar <: HolidayCalendar end
cc = TestCalendar()
@test_throws ErrorException isholiday(cc, Dates.Date(2015,1,1))
BusinessDays.isholiday(::TestCalendar, dt::Dates.Date) = dt == Dates.Date(2015,8,27)
@test isholiday(cc, Dates.Date(2015,8,26)) == false
@test isholiday(cc, Dates.Date(2015,8,27)) == true
BusinessDays.initcache(cc)
@test isholiday(cc, Dates.Date(2015,8,26)) == false
@test isholiday(cc, Dates.Date(2015,8,27)) == true
BusinessDays.cleancache(cc)
isholiday(:Brazil, Dates.Date(2016,2,1))
isholiday(:TestCalendar, Dates.Date(2016,2,1))
isholiday("TestCalendar", Dates.Date(2016,2,1))
isbday(:Brazil, Dates.Date(2016,2,1))
isbday(:TestCalendar, Dates.Date(2016,2,1))
isbday("TestCalendar", Dates.Date(2016,2,1))

sym_vec = [:Brazil, :UKSettlement]
BusinessDays.initcache(sym_vec)
BusinessDays.cleancache(sym_vec)

str_vec = ["Brazil", "UKSettlement", "Canada", "UnitedStates", "USNYSE", "USGovernmentBond", "CanadaTSX", "WeekendsOnly"]
BusinessDays.initcache(str_vec)
BusinessDays.cleancache(str_vec)

BusinessDays.initcache("UKSettlement", Dates.Date(2000,1,1), Dates.Date(2000,5,2))
BusinessDays.initcache("UKSettlement", Dates.Date(2000,1,1), Dates.Date(2000,5,2)) # repeating initcache should work
BusinessDays.initcache("UKSettlement", Dates.Date(2000,1,1), Dates.Date(2000,1,1)) # single date cache should work
BusinessDays.cleancache("UKSettlement")

# equality and hash function for Australia
@test BusinessDays.Australia(:ACT) == BusinessDays.Australia(:ACT)
@test BusinessDays.Australia(:ACT) != BusinessDays.Australia(:NSW)
@test hash(BusinessDays.Australia(:ACT)) == hash(BusinessDays.Australia(:ACT))
@test hash(BusinessDays.Australia(:ACT)) != hash(BusinessDays.Australia(:NSW))

BusinessDays.initcache(BusinessDays.Australia(:ACT))
@test haskey(BusinessDays.CACHE_DICT, BusinessDays.Australia(:ACT))
@test !haskey(BusinessDays.CACHE_DICT, BusinessDays.Australia(:NSW))
BusinessDays.cleancache(BusinessDays.Australia(:ACT))

include("customcalendar-example.jl")

#########################
# GenericHolidayCalendar
#########################

d0 = Dates.Date(1980,1,1)
d1 = Dates.Date(2050,1,1)
gen_brazil = GenericHolidayCalendar(listholidays(hc_brazil, d0, d1))
@test isbday(gen_brazil, Dates.Date(2014, 12, 31)) == true # wednesday
@test isbday(gen_brazil, Dates.Date(2015, 01, 01)) == false # new year
@test isbday(gen_brazil, Dates.Date(2015, 01, 02)) == true # friday

@test advancebdays(gen_brazil, Dates.Date(2015,9,1), [0, 1, 3, 4, 5]) == advancebdays(hc_brazil, Dates.Date(2015,9,1), [0, 1, 3, 4, 5])
@test advancebdays(gen_brazil, Dates.Date(2015,9,1), 0:5) == advancebdays(hc_brazil, Dates.Date(2015,9,1), 0:5)
@test listholidays(gen_brazil, Dates.Date(2016,1,1), Dates.Date(2016,5,30)) == listholidays(hc_brazil, Dates.Date(2016,1,1), Dates.Date(2016,5,30))

@test tobday(gen_brazil, Dates.Date(2013, 02, 08)) == tobday(hc_brazil, Dates.Date(2013, 02, 08))
@test tobday(gen_brazil, Dates.Date(2013, 02, 09)) == tobday(hc_brazil, Dates.Date(2013, 02, 09))
@test_throws AssertionError bdays(gen_brazil, Dates.Date(1900,2,1), Dates.Date(2000,2,1))
@test_throws AssertionError bdays(gen_brazil, Dates.Date(2000,2,1), Dates.Date(2100,2,1))

d0_test = Dates.Date(1980,1,2)
d1_test = Dates.Date(2049,12,28)
@test bdays(hc_brazil, d0_test, d1_test) == bdays(gen_brazil, d0_test, d1_test)
@test bdayscount(hc_brazil, d0_test, d1_test) == bdayscount(gen_brazil, d0_test, d1_test)
println("a million with GenericHolidayCalendar...")
@time for i in 1:1000000 bdays(gen_brazil, d0_test, d1_test) end
BusinessDays.cleancache(gen_brazil)

# Start all over, but without cache
gen_brazil = GenericHolidayCalendar(listholidays(hc_brazil, d0, d1), d0, d1, false)

@test isbday(gen_brazil, Dates.Date(2014, 12, 31)) == true # wednesday
@test isbday(gen_brazil, Dates.Date(2015, 01, 01)) == false # new year
@test isbday(gen_brazil, Dates.Date(2015, 01, 02)) == true # friday

@test advancebdays(gen_brazil, Dates.Date(2015,9,1), [0, 1, 3, 4, 5]) == advancebdays(hc_brazil, Dates.Date(2015,9,1), [0, 1, 3, 4, 5])
@test advancebdays(gen_brazil, Dates.Date(2015,9,1), 0:5) == advancebdays(hc_brazil, Dates.Date(2015,9,1), 0:5)
@test listholidays(gen_brazil, Dates.Date(2016,1,1), Dates.Date(2016,5,30)) == listholidays(hc_brazil, Dates.Date(2016,1,1), Dates.Date(2016,5,30))

@test tobday(gen_brazil, Dates.Date(2013, 02, 08)) == tobday(hc_brazil, Dates.Date(2013, 02, 08))
@test tobday(gen_brazil, Dates.Date(2013, 02, 09)) == tobday(hc_brazil, Dates.Date(2013, 02, 09))
@test_throws AssertionError bdays(gen_brazil, Dates.Date(1900,2,1), Dates.Date(2000,2,1))
@test_throws AssertionError bdays(gen_brazil, Dates.Date(2000,2,1), Dates.Date(2100,2,1))

@test BusinessDays.needs_cache_update(gen_brazil, d0, d1) == false
BusinessDays.initcache(gen_brazil)
@test BusinessDays.needs_cache_update(gen_brazil, d0, d1) == true
@test isbday(gen_brazil, Dates.Date(2014, 12, 31)) == true # wednesday
@test isbday(gen_brazil, Dates.Date(2015, 01, 01)) == false # new year
@test isbday(gen_brazil, Dates.Date(2015, 01, 02)) == true # friday

# does nothing, because cache is already there
BusinessDays.initcache(gen_brazil)

# A GenericHolidayCalendar is defined by its set of holidays, dtmin, dtmax
dtmin = Dates.Date(2018,1,15)
dtmax = Dates.Date(2018,1,19)
gen_1 = GenericHolidayCalendar(Set([Dates.Date(2018,1,16), Dates.Date(2018,1,18)]), dtmin, dtmax)
gen_2 = GenericHolidayCalendar(Set([Dates.Date(2018,1,16), Dates.Date(2018,1,18)]), dtmin, dtmax)
@test gen_1 == gen_2

# On a set, they are the same element
cal_set = Set([gen_1, gen_2])
@test length(cal_set) == 1

# On a dict, they represent the same key
cal_dict = Dict(gen_1 => "hey")
@test cal_dict[gen_2] == "hey"
