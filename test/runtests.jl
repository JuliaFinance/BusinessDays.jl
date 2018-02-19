
using Base.Dates
using BusinessDays
using Base.Test

bd = BusinessDays

# Issue #18
Dict(Any[])

# Types
bhc = bd.Brazil()
ushc = bd.USSettlement()
ukhc = bd.UKSettlement()
usnysehc = bd.USNYSE()
usgovbondhc = bd.USGovernmentBond()
targethc = bd.TARGET()
hc_composite_BR_USA = CompositeHolidayCalendar([bd.Brazil(), bd.USSettlement()])
all_calendars_vec = [bhc, ushc, ukhc, hc_composite_BR_USA, usnysehc, usgovbondhc]

# two different instances of the same HolidayCalendar subtype should be equal
@test bhc == bd.Brazil()
@test ushc == bd.USSettlement()
@test bhc != ushc
@test bhc != Type(bd.Brazil) # content of list is an instance, not a singleton
@test string(bhc) == "BusinessDays.BRSettlement"

# Check typing system
@test isa(bhc,HolidayCalendar)
@test isa(ushc,HolidayCalendar)
@test isa(ukhc,HolidayCalendar)

################
## Easter Dates
################

# easter dates from http://www.maa.mhn.de/StarDate/publ_holidays.html
@test_throws ErrorException bd.easter_date(Year(1100))
@test bd.easter_date(Year(1901)) == Date(1901, 04, 07)
@test bd.easter_date(Year(1902)) == Date(1902, 03, 30)
@test bd.easter_date(Year(1903)) == Date(1903, 04, 12)
@test bd.easter_date(Year(1904)) == Date(1904, 04, 03)
@test bd.easter_date(Year(1905)) == Date(1905, 04, 23)
@test bd.easter_date(Year(1906)) == Date(1906, 04, 15)
@test bd.easter_date(Year(1907)) == Date(1907, 03, 31)
@test bd.easter_date(Year(1908)) == Date(1908, 04, 19)
@test bd.easter_date(Year(1909)) == Date(1909, 04, 11)
@test bd.easter_date(Year(1910)) == Date(1910, 03, 27)
@test bd.easter_date(Year(1911)) == Date(1911, 04, 16)
@test bd.easter_date(Year(1912)) == Date(1912, 04, 07)
@test bd.easter_date(Year(1913)) == Date(1913, 03, 23)
@test bd.easter_date(Year(1914)) == Date(1914, 04, 12)
@test bd.easter_date(Year(1915)) == Date(1915, 04, 04)
@test bd.easter_date(Year(1916)) == Date(1916, 04, 23)
@test bd.easter_date(Year(1917)) == Date(1917, 04, 08)
@test bd.easter_date(Year(1918)) == Date(1918, 03, 31)
@test bd.easter_date(Year(1919)) == Date(1919, 04, 20)
@test bd.easter_date(Year(1920)) == Date(1920, 04, 04)
@test bd.easter_date(Year(1921)) == Date(1921, 03, 27)
@test bd.easter_date(Year(1922)) == Date(1922, 04, 16)
@test bd.easter_date(Year(1923)) == Date(1923, 04, 01)
@test bd.easter_date(Year(1924)) == Date(1924, 04, 20)
@test bd.easter_date(Year(1925)) == Date(1925, 04, 12)
@test bd.easter_date(Year(1926)) == Date(1926, 04, 04)
@test bd.easter_date(Year(1927)) == Date(1927, 04, 17)
@test bd.easter_date(Year(1928)) == Date(1928, 04, 08)
@test bd.easter_date(Year(1929)) == Date(1929, 03, 31)
@test bd.easter_date(Year(1930)) == Date(1930, 04, 20)
@test bd.easter_date(Year(1931)) == Date(1931, 04, 05)
@test bd.easter_date(Year(1932)) == Date(1932, 03, 27)
@test bd.easter_date(Year(1933)) == Date(1933, 04, 16)
@test bd.easter_date(Year(1934)) == Date(1934, 04, 01)
@test bd.easter_date(Year(1935)) == Date(1935, 04, 21)
@test bd.easter_date(Year(1936)) == Date(1936, 04, 12)
@test bd.easter_date(Year(1937)) == Date(1937, 03, 28)
@test bd.easter_date(Year(1938)) == Date(1938, 04, 17)
@test bd.easter_date(Year(1939)) == Date(1939, 04, 09)
@test bd.easter_date(Year(1940)) == Date(1940, 03, 24)
@test bd.easter_date(Year(1941)) == Date(1941, 04, 13)
@test bd.easter_date(Year(1942)) == Date(1942, 04, 05)
@test bd.easter_date(Year(1943)) == Date(1943, 04, 25)
@test bd.easter_date(Year(1944)) == Date(1944, 04, 09)
@test bd.easter_date(Year(1945)) == Date(1945, 04, 01)
@test bd.easter_date(Year(1946)) == Date(1946, 04, 21)
@test bd.easter_date(Year(1947)) == Date(1947, 04, 06)
@test bd.easter_date(Year(1948)) == Date(1948, 03, 28)
@test bd.easter_date(Year(1949)) == Date(1949, 04, 17)
@test bd.easter_date(Year(1950)) == Date(1950, 04, 09)
@test bd.easter_date(Year(1951)) == Date(1951, 03, 25)
@test bd.easter_date(Year(1952)) == Date(1952, 04, 13)
@test bd.easter_date(Year(1953)) == Date(1953, 04, 05)
@test bd.easter_date(Year(1954)) == Date(1954, 04, 18)
@test bd.easter_date(Year(1955)) == Date(1955, 04, 10)
@test bd.easter_date(Year(1956)) == Date(1956, 04, 01)
@test bd.easter_date(Year(1957)) == Date(1957, 04, 21)
@test bd.easter_date(Year(1958)) == Date(1958, 04, 06)
@test bd.easter_date(Year(1959)) == Date(1959, 03, 29)
@test bd.easter_date(Year(1960)) == Date(1960, 04, 17)
@test bd.easter_date(Year(1961)) == Date(1961, 04, 02)
@test bd.easter_date(Year(1962)) == Date(1962, 04, 22)
@test bd.easter_date(Year(1963)) == Date(1963, 04, 14)
@test bd.easter_date(Year(1964)) == Date(1964, 03, 29)
@test bd.easter_date(Year(1965)) == Date(1965, 04, 18)
@test bd.easter_date(Year(1966)) == Date(1966, 04, 10)
@test bd.easter_date(Year(1967)) == Date(1967, 03, 26)
@test bd.easter_date(Year(1968)) == Date(1968, 04, 14)
@test bd.easter_date(Year(1969)) == Date(1969, 04, 06)
@test bd.easter_date(Year(1970)) == Date(1970, 03, 29)
@test bd.easter_date(Year(1971)) == Date(1971, 04, 11)
@test bd.easter_date(Year(1972)) == Date(1972, 04, 02)
@test bd.easter_date(Year(1973)) == Date(1973, 04, 22)
@test bd.easter_date(Year(1974)) == Date(1974, 04, 14)
@test bd.easter_date(Year(1975)) == Date(1975, 03, 30)
@test bd.easter_date(Year(1976)) == Date(1976, 04, 18)
@test bd.easter_date(Year(1977)) == Date(1977, 04, 10)
@test bd.easter_date(Year(1978)) == Date(1978, 03, 26)
@test bd.easter_date(Year(1979)) == Date(1979, 04, 15)
@test bd.easter_date(Year(1980)) == Date(1980, 04, 06)
@test bd.easter_date(Year(1981)) == Date(1981, 04, 19)
@test bd.easter_date(Year(1982)) == Date(1982, 04, 11)
@test bd.easter_date(Year(1983)) == Date(1983, 04, 03)
@test bd.easter_date(Year(1984)) == Date(1984, 04, 22)
@test bd.easter_date(Year(1985)) == Date(1985, 04, 07)
@test bd.easter_date(Year(1986)) == Date(1986, 03, 30)
@test bd.easter_date(Year(1987)) == Date(1987, 04, 19)
@test bd.easter_date(Year(1988)) == Date(1988, 04, 03)
@test bd.easter_date(Year(1989)) == Date(1989, 03, 26)
@test bd.easter_date(Year(1990)) == Date(1990, 04, 15)
@test bd.easter_date(Year(1991)) == Date(1991, 03, 31)
@test bd.easter_date(Year(1992)) == Date(1992, 04, 19)
@test bd.easter_date(Year(1993)) == Date(1993, 04, 11)
@test bd.easter_date(Year(1994)) == Date(1994, 04, 03)
@test bd.easter_date(Year(1995)) == Date(1995, 04, 16)
@test bd.easter_date(Year(1996)) == Date(1996, 04, 07)
@test bd.easter_date(Year(1997)) == Date(1997, 03, 30)
@test bd.easter_date(Year(1998)) == Date(1998, 04, 12)
@test bd.easter_date(Year(1999)) == Date(1999, 04, 04)
@test bd.easter_date(Year(2000)) == Date(2000, 04, 23)
@test bd.easter_date(Year(2001)) == Date(2001, 04, 15)
@test bd.easter_date(Year(2002)) == Date(2002, 03, 31)
@test bd.easter_date(Year(2003)) == Date(2003, 04, 20)
@test bd.easter_date(Year(2004)) == Date(2004, 04, 11)
@test bd.easter_date(Year(2005)) == Date(2005, 03, 27)
@test bd.easter_date(Year(2006)) == Date(2006, 04, 16)
@test bd.easter_date(Year(2007)) == Date(2007, 04, 08)
@test bd.easter_date(Year(2008)) == Date(2008, 03, 23)
@test bd.easter_date(Year(2009)) == Date(2009, 04, 12)
@test bd.easter_date(Year(2010)) == Date(2010, 04, 04)
@test bd.easter_date(Year(2011)) == Date(2011, 04, 24)
@test bd.easter_date(Year(2012)) == Date(2012, 04, 08)
@test bd.easter_date(Year(2013)) == Date(2013, 03, 31)
@test bd.easter_date(Year(2014)) == Date(2014, 04, 20)
@test bd.easter_date(Year(2015)) == Date(2015, 04, 05)
@test bd.easter_date(Year(2016)) == Date(2016, 03, 27)
@test bd.easter_date(Year(2017)) == Date(2017, 04, 16)
@test bd.easter_date(Year(2018)) == Date(2018, 04, 01)
@test bd.easter_date(Year(2019)) == Date(2019, 04, 21)
@test bd.easter_date(Year(2020)) == Date(2020, 04, 12)
@test bd.easter_date(Year(2021)) == Date(2021, 04, 04)
@test bd.easter_date(Year(2022)) == Date(2022, 04, 17)
@test bd.easter_date(Year(2023)) == Date(2023, 04, 09)
@test bd.easter_date(Year(2024)) == Date(2024, 03, 31)
@test bd.easter_date(Year(2025)) == Date(2025, 04, 20)
@test bd.easter_date(Year(2026)) == Date(2026, 04, 05)
@test bd.easter_date(Year(2027)) == Date(2027, 03, 28)
@test bd.easter_date(Year(2028)) == Date(2028, 04, 16)
@test bd.easter_date(Year(2029)) == Date(2029, 04, 01)
@test bd.easter_date(Year(2030)) == Date(2030, 04, 21)
@test bd.easter_date(Year(2031)) == Date(2031, 04, 13)
@test bd.easter_date(Year(2032)) == Date(2032, 03, 28)
@test bd.easter_date(Year(2033)) == Date(2033, 04, 17)
@test bd.easter_date(Year(2034)) == Date(2034, 04, 09)
@test bd.easter_date(Year(2035)) == Date(2035, 03, 25)
@test bd.easter_date(Year(2036)) == Date(2036, 04, 13)
@test bd.easter_date(Year(2037)) == Date(2037, 04, 05)
@test bd.easter_date(Year(2038)) == Date(2038, 04, 25)
@test bd.easter_date(Year(2039)) == Date(2039, 04, 10)
@test bd.easter_date(Year(2040)) == Date(2040, 04, 01)
@test bd.easter_date(Year(2041)) == Date(2041, 04, 21)
@test bd.easter_date(Year(2042)) == Date(2042, 04, 06)
@test bd.easter_date(Year(2043)) == Date(2043, 03, 29)
@test bd.easter_date(Year(2044)) == Date(2044, 04, 17)
@test bd.easter_date(Year(2045)) == Date(2045, 04, 09)
@test bd.easter_date(Year(2046)) == Date(2046, 03, 25)
@test bd.easter_date(Year(2047)) == Date(2047, 04, 14)
@test bd.easter_date(Year(2048)) == Date(2048, 04, 05)
@test bd.easter_date(Year(2049)) == Date(2049, 04, 18)
@test bd.easter_date(Year(2050)) == Date(2050, 04, 10)
@test bd.easter_date(Year(2051)) == Date(2051, 04, 02)
@test bd.easter_date(Year(2052)) == Date(2052, 04, 21)
@test bd.easter_date(Year(2053)) == Date(2053, 04, 06)
@test bd.easter_date(Year(2054)) == Date(2054, 03, 29)
@test bd.easter_date(Year(2055)) == Date(2055, 04, 18)
@test bd.easter_date(Year(2056)) == Date(2056, 04, 02)
@test bd.easter_date(Year(2057)) == Date(2057, 04, 22)
@test bd.easter_date(Year(2058)) == Date(2058, 04, 14)
@test bd.easter_date(Year(2059)) == Date(2059, 03, 30)
@test bd.easter_date(Year(2060)) == Date(2060, 04, 18)
@test bd.easter_date(Year(2061)) == Date(2061, 04, 10)
@test bd.easter_date(Year(2062)) == Date(2062, 03, 26)
@test bd.easter_date(Year(2063)) == Date(2063, 04, 15)
@test bd.easter_date(Year(2064)) == Date(2064, 04, 06)
@test bd.easter_date(Year(2065)) == Date(2065, 03, 29)
@test bd.easter_date(Year(2066)) == Date(2066, 04, 11)
@test bd.easter_date(Year(2067)) == Date(2067, 04, 03)
@test bd.easter_date(Year(2068)) == Date(2068, 04, 22)
@test bd.easter_date(Year(2069)) == Date(2069, 04, 14)
@test bd.easter_date(Year(2070)) == Date(2070, 03, 30)
@test bd.easter_date(Year(2071)) == Date(2071, 04, 19)
@test bd.easter_date(Year(2072)) == Date(2072, 04, 10)
@test bd.easter_date(Year(2073)) == Date(2073, 03, 26)
@test bd.easter_date(Year(2074)) == Date(2074, 04, 15)
@test bd.easter_date(Year(2075)) == Date(2075, 04, 07)
@test bd.easter_date(Year(2076)) == Date(2076, 04, 19)
@test bd.easter_date(Year(2077)) == Date(2077, 04, 11)
@test bd.easter_date(Year(2078)) == Date(2078, 04, 03)

include("easter-min-max.jl")

###############
# findweekday
###############
# weekday values:
# const Monday,Tuesday,Wednesday,Thursday,Friday,Saturday,Sunday = 1,2,3,4,5,6,7
# see query.jl on Dates module
# See also dayofweek(dt) function.
# function findweekday(weekday_target :: Int, yy :: Int, mm:: Int, occurrence :: Int, ascending :: Bool )
@test bd.findweekday(Dates.Monday, 2015, 07, 1, true) == Date(2015, 07, 06)
@test bd.findweekday(Dates.Monday, 2015, 07, 2, true) == Date(2015, 07, 13)
@test bd.findweekday(Dates.Monday, 2015, 07, 3, true) == Date(2015, 07, 20)
@test bd.findweekday(Dates.Monday, 2015, 07, 4, true) == Date(2015, 07, 27)
@test bd.findweekday(Dates.Monday, 2015, 07, 5, true) == Date(2015, 08, 03)

@test bd.findweekday(Dates.Monday, 2015, 07, 1, false) == Date(2015, 07, 27)
@test bd.findweekday(Dates.Monday, 2015, 07, 2, false) == Date(2015, 07, 20)
@test bd.findweekday(Dates.Monday, 2015, 07, 3, false) == Date(2015, 07, 13)
@test bd.findweekday(Dates.Monday, 2015, 07, 4, false) == Date(2015, 07, 06)
@test bd.findweekday(Dates.Monday, 2015, 07, 5, false) == Date(2015, 06, 29)

@test bd.findweekday(Dates.Friday, 2015, 07, 1, true) == Date(2015, 07, 03)
@test bd.findweekday(Dates.Friday, 2015, 07, 2, true) == Date(2015, 07, 10)
@test bd.findweekday(Dates.Friday, 2015, 07, 3, true) == Date(2015, 07, 17)
@test bd.findweekday(Dates.Friday, 2015, 07, 4, true) == Date(2015, 07, 24)
@test bd.findweekday(Dates.Friday, 2015, 07, 5, true) == Date(2015, 07, 31)
@test bd.findweekday(Dates.Friday, 2015, 07, 6, true) == Date(2015, 08, 07)

@test bd.findweekday(Dates.Friday, 2015, 07, 1, false) == Date(2015, 07, 31)
@test bd.findweekday(Dates.Friday, 2015, 07, 2, false) == Date(2015, 07, 24)
@test bd.findweekday(Dates.Friday, 2015, 07, 3, false) == Date(2015, 07, 17)
@test bd.findweekday(Dates.Friday, 2015, 07, 4, false) == Date(2015, 07, 10)
@test bd.findweekday(Dates.Friday, 2015, 07, 5, false) == Date(2015, 07, 03)
@test bd.findweekday(Dates.Friday, 2015, 07, 6, false) == Date(2015, 06, 26)

@test bd.findweekday(Dates.Wednesday, 2015, 07, 1, true) == Date(2015, 07, 01)
@test bd.findweekday(Dates.Wednesday, 2015, 07, 2, true) == Date(2015, 07, 08)
@test bd.findweekday(Dates.Wednesday, 2015, 07, 3, true) == Date(2015, 07, 15)
@test bd.findweekday(Dates.Wednesday, 2015, 07, 4, true) == Date(2015, 07, 22)
@test bd.findweekday(Dates.Wednesday, 2015, 07, 5, true) == Date(2015, 07, 29)
@test bd.findweekday(Dates.Wednesday, 2015, 07, 6, true) == Date(2015, 08, 05)

@test bd.findweekday(Dates.Wednesday, 2015, 07, 1, false) == Date(2015, 07, 29)
@test bd.findweekday(Dates.Wednesday, 2015, 07, 2, false) == Date(2015, 07, 22)
@test bd.findweekday(Dates.Wednesday, 2015, 07, 3, false) == Date(2015, 07, 15)
@test bd.findweekday(Dates.Wednesday, 2015, 07, 4, false) == Date(2015, 07, 08)
@test bd.findweekday(Dates.Wednesday, 2015, 07, 5, false) == Date(2015, 07, 01)
@test bd.findweekday(Dates.Wednesday, 2015, 07, 6, false) == Date(2015, 06, 24)

@test_throws AssertionError bd.findweekday(Dates.Wednesday, 2015, 07, -1, false)
@test_throws AssertionError bd.findweekday(Dates.Wednesday, 2015, 07, -1, true)

# Test this only on 64bit or higher systems
len = typemax(UInt32) + 1
if len > typemax(UInt32)
    d0 = Date(1950, 2, 1)
    d1 = d0 + Day(len)
    @test_throws AssertionError bd._create_bdays_cache_arrays(bhc, d0, d1)
end

# Create HolidayCalendar instances
hc_australiaasx = bd.AustraliaASX()
hc_australiaact = bd.Australia(:ACT)
hc_australiansw = bd.Australia(:NSW)
hc_australiant  = bd.Australia(:NT)
hc_australiaqld = bd.Australia(:QLD)
hc_australiasa  = bd.Australia(:SA)
hc_australiatas = bd.Australia(:TAS)
hc_australiawa  = bd.Australia(:WA)
hc_australiavic = bd.Australia(:VIC)
hc_brazil       = bd.Brazil()
hc_brazil_bmf   = bd.BrazilBMF()
hc_usa          = bd.USSettlement()
hc_uk           = bd.UKSettlement()
hc_usnyse       = bd.USNYSE()
hc_usgovbond    = bd.USGovernmentBond()
hc_canadatsx    = bd.CanadaTSX()
hc_canada       = bd.CanadaSettlement()

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

bd.cleancache(hc_brazil)
bd.cleancache()

struct TestCalendar <: HolidayCalendar end
cc = TestCalendar()
@test_throws ErrorException isholiday(cc, Date(2015,1,1))
import BusinessDays.isholiday
isholiday(::TestCalendar, dt::Date) = dt == Date(2015,8,27)
@test isholiday(cc, Date(2015,8,26)) == false
@test isholiday(cc, Date(2015,8,27)) == true
bd.initcache(cc)
@test isholiday(cc, Date(2015,8,26)) == false
@test isholiday(cc, Date(2015,8,27)) == true
bd.cleancache(cc)
isholiday(:Brazil, Date(2016,2,1))
isholiday(:TestCalendar, Date(2016,2,1))
isholiday("TestCalendar", Date(2016,2,1))
isbday(:Brazil, Date(2016,2,1))
isbday(:TestCalendar, Date(2016,2,1))
isbday("TestCalendar", Date(2016,2,1))

sym_vec = [:Brazil, :UKSettlement]
bd.initcache(sym_vec)
bd.cleancache(sym_vec)

str_vec = ["Brazil", "UKSettlement", "Canada", "UnitedStates", "USNYSE", "USGovernmentBond", "CanadaTSX", "WeekendsOnly"]
bd.initcache(str_vec)
bd.cleancache(str_vec)

bd.initcache("UKSettlement", Date(2000,1,1), Date(2000,5,2))
bd.initcache("UKSettlement", Date(2000,1,1), Date(2000,5,2)) # repeating initcache should work
bd.initcache("UKSettlement", Date(2000,1,1), Date(2000,1,1)) # single date cache should work
bd.cleancache("UKSettlement")

# equality and hash function for Australia
@test bd.Australia(:ACT) == bd.Australia(:ACT)
@test bd.Australia(:ACT) != bd.Australia(:NSW)
@test hash(bd.Australia(:ACT)) == hash(bd.Australia(:ACT))
@test hash(bd.Australia(:ACT)) != hash(bd.Australia(:NSW))

bd.initcache(bd.Australia(:ACT))
@test haskey(bd.CACHE_DICT, bd.Australia(:ACT))
@test !haskey(bd.CACHE_DICT, bd.Australia(:NSW))
bd.cleancache(bd.Australia(:ACT))

include("customcalendar-example.jl")

#########################
# GenericHolidayCalendar
#########################

d0 = Date(1980,1,1)
d1 = Date(2050,1,1)
gen_brazil = GenericHolidayCalendar(listholidays(hc_brazil, d0, d1))
@test isbday(gen_brazil, Date(2014, 12, 31)) == true # wednesday
@test isbday(gen_brazil, Date(2015, 01, 01)) == false # new year
@test isbday(gen_brazil, Date(2015, 01, 02)) == true # friday

@test advancebdays(gen_brazil, Date(2015,9,1), [0, 1, 3, 4, 5]) == advancebdays(hc_brazil, Date(2015,9,1), [0, 1, 3, 4, 5])
@test advancebdays(gen_brazil, Date(2015,9,1), 0:5) == advancebdays(hc_brazil, Date(2015,9,1), 0:5)
@test listholidays(gen_brazil, Date(2016,1,1), Date(2016,5,30)) == listholidays(hc_brazil, Date(2016,1,1), Date(2016,5,30))

@test tobday(gen_brazil, Date(2013, 02, 08)) == tobday(hc_brazil, Date(2013, 02, 08))
@test tobday(gen_brazil, Date(2013, 02, 09)) == tobday(hc_brazil, Date(2013, 02, 09))
@test_throws AssertionError bdays(gen_brazil, Date(1900,2,1), Date(2000,2,1))
@test_throws AssertionError bdays(gen_brazil, Date(2000,2,1), Date(2100,2,1))

d0_test = Date(1980,1,2)
d1_test = Date(2049,12,28)
@test bdays(hc_brazil, d0_test, d1_test) == bdays(gen_brazil, d0_test, d1_test)
println("a million with GenericHolidayCalendar...")
@time for i in 1:1000000 bdays(gen_brazil, d0_test, d1_test) end
bd.cleancache(gen_brazil)

# Start all over, but without cache
gen_brazil = GenericHolidayCalendar(listholidays(hc_brazil, d0, d1), d0, d1, false)

@test isbday(gen_brazil, Date(2014, 12, 31)) == true # wednesday
@test isbday(gen_brazil, Date(2015, 01, 01)) == false # new year
@test isbday(gen_brazil, Date(2015, 01, 02)) == true # friday

@test advancebdays(gen_brazil, Date(2015,9,1), [0, 1, 3, 4, 5]) == advancebdays(hc_brazil, Date(2015,9,1), [0, 1, 3, 4, 5])
@test advancebdays(gen_brazil, Date(2015,9,1), 0:5) == advancebdays(hc_brazil, Date(2015,9,1), 0:5)
@test listholidays(gen_brazil, Date(2016,1,1), Date(2016,5,30)) == listholidays(hc_brazil, Date(2016,1,1), Date(2016,5,30))

@test tobday(gen_brazil, Date(2013, 02, 08)) == tobday(hc_brazil, Date(2013, 02, 08))
@test tobday(gen_brazil, Date(2013, 02, 09)) == tobday(hc_brazil, Date(2013, 02, 09))
@test_throws AssertionError bdays(gen_brazil, Date(1900,2,1), Date(2000,2,1))
@test_throws AssertionError bdays(gen_brazil, Date(2000,2,1), Date(2100,2,1))

@test bd.needs_cache_update(gen_brazil, d0, d1) == false
bd.initcache(gen_brazil)
@test bd.needs_cache_update(gen_brazil, d0, d1) == true
@test isbday(gen_brazil, Date(2014, 12, 31)) == true # wednesday
@test isbday(gen_brazil, Date(2015, 01, 01)) == false # new year
@test isbday(gen_brazil, Date(2015, 01, 02)) == true # friday

# does nothing, because cache is already there
bd.initcache(gen_brazil)

# A GenericHolidayCalendar is defined by its set of holidays, dtmin, dtmax
dtmin = Date(2018,1,15)
dtmax = Date(2018,1,19)
gen_1 = GenericHolidayCalendar(Set([Date(2018,1,16), Date(2018,1,18)]), dtmin, dtmax)
gen_2 = GenericHolidayCalendar(Set([Date(2018,1,16), Date(2018,1,18)]), dtmin, dtmax)
@test gen_1 == gen_2

# On a set, they are the same element
cal_set = Set([gen_1, gen_2])
@test length(cal_set) == 1

# On a dict, they represent the same key
cal_dict = Dict(gen_1 => "hey")
@test cal_dict[gen_2] == "hey"

# Tests precompile script
if VERSION < v"0.6.99"
	include(joinpath("..", "contrib", "userimg.jl"))
end
