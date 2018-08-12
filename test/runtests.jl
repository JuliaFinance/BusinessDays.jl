
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

################
## Easter Dates
################

# easter dates from http://www.maa.mhn.de/StarDate/publ_holidays.html
@test_throws ErrorException BusinessDays.easter_date(Dates.Year(1100))
@test BusinessDays.easter_date(Dates.Year(1901)) == Dates.Date(1901, 04, 07)
@test BusinessDays.easter_date(Dates.Year(1902)) == Dates.Date(1902, 03, 30)
@test BusinessDays.easter_date(Dates.Year(1903)) == Dates.Date(1903, 04, 12)
@test BusinessDays.easter_date(Dates.Year(1904)) == Dates.Date(1904, 04, 03)
@test BusinessDays.easter_date(Dates.Year(1905)) == Dates.Date(1905, 04, 23)
@test BusinessDays.easter_date(Dates.Year(1906)) == Dates.Date(1906, 04, 15)
@test BusinessDays.easter_date(Dates.Year(1907)) == Dates.Date(1907, 03, 31)
@test BusinessDays.easter_date(Dates.Year(1908)) == Dates.Date(1908, 04, 19)
@test BusinessDays.easter_date(Dates.Year(1909)) == Dates.Date(1909, 04, 11)
@test BusinessDays.easter_date(Dates.Year(1910)) == Dates.Date(1910, 03, 27)
@test BusinessDays.easter_date(Dates.Year(1911)) == Dates.Date(1911, 04, 16)
@test BusinessDays.easter_date(Dates.Year(1912)) == Dates.Date(1912, 04, 07)
@test BusinessDays.easter_date(Dates.Year(1913)) == Dates.Date(1913, 03, 23)
@test BusinessDays.easter_date(Dates.Year(1914)) == Dates.Date(1914, 04, 12)
@test BusinessDays.easter_date(Dates.Year(1915)) == Dates.Date(1915, 04, 04)
@test BusinessDays.easter_date(Dates.Year(1916)) == Dates.Date(1916, 04, 23)
@test BusinessDays.easter_date(Dates.Year(1917)) == Dates.Date(1917, 04, 08)
@test BusinessDays.easter_date(Dates.Year(1918)) == Dates.Date(1918, 03, 31)
@test BusinessDays.easter_date(Dates.Year(1919)) == Dates.Date(1919, 04, 20)
@test BusinessDays.easter_date(Dates.Year(1920)) == Dates.Date(1920, 04, 04)
@test BusinessDays.easter_date(Dates.Year(1921)) == Dates.Date(1921, 03, 27)
@test BusinessDays.easter_date(Dates.Year(1922)) == Dates.Date(1922, 04, 16)
@test BusinessDays.easter_date(Dates.Year(1923)) == Dates.Date(1923, 04, 01)
@test BusinessDays.easter_date(Dates.Year(1924)) == Dates.Date(1924, 04, 20)
@test BusinessDays.easter_date(Dates.Year(1925)) == Dates.Date(1925, 04, 12)
@test BusinessDays.easter_date(Dates.Year(1926)) == Dates.Date(1926, 04, 04)
@test BusinessDays.easter_date(Dates.Year(1927)) == Dates.Date(1927, 04, 17)
@test BusinessDays.easter_date(Dates.Year(1928)) == Dates.Date(1928, 04, 08)
@test BusinessDays.easter_date(Dates.Year(1929)) == Dates.Date(1929, 03, 31)
@test BusinessDays.easter_date(Dates.Year(1930)) == Dates.Date(1930, 04, 20)
@test BusinessDays.easter_date(Dates.Year(1931)) == Dates.Date(1931, 04, 05)
@test BusinessDays.easter_date(Dates.Year(1932)) == Dates.Date(1932, 03, 27)
@test BusinessDays.easter_date(Dates.Year(1933)) == Dates.Date(1933, 04, 16)
@test BusinessDays.easter_date(Dates.Year(1934)) == Dates.Date(1934, 04, 01)
@test BusinessDays.easter_date(Dates.Year(1935)) == Dates.Date(1935, 04, 21)
@test BusinessDays.easter_date(Dates.Year(1936)) == Dates.Date(1936, 04, 12)
@test BusinessDays.easter_date(Dates.Year(1937)) == Dates.Date(1937, 03, 28)
@test BusinessDays.easter_date(Dates.Year(1938)) == Dates.Date(1938, 04, 17)
@test BusinessDays.easter_date(Dates.Year(1939)) == Dates.Date(1939, 04, 09)
@test BusinessDays.easter_date(Dates.Year(1940)) == Dates.Date(1940, 03, 24)
@test BusinessDays.easter_date(Dates.Year(1941)) == Dates.Date(1941, 04, 13)
@test BusinessDays.easter_date(Dates.Year(1942)) == Dates.Date(1942, 04, 05)
@test BusinessDays.easter_date(Dates.Year(1943)) == Dates.Date(1943, 04, 25)
@test BusinessDays.easter_date(Dates.Year(1944)) == Dates.Date(1944, 04, 09)
@test BusinessDays.easter_date(Dates.Year(1945)) == Dates.Date(1945, 04, 01)
@test BusinessDays.easter_date(Dates.Year(1946)) == Dates.Date(1946, 04, 21)
@test BusinessDays.easter_date(Dates.Year(1947)) == Dates.Date(1947, 04, 06)
@test BusinessDays.easter_date(Dates.Year(1948)) == Dates.Date(1948, 03, 28)
@test BusinessDays.easter_date(Dates.Year(1949)) == Dates.Date(1949, 04, 17)
@test BusinessDays.easter_date(Dates.Year(1950)) == Dates.Date(1950, 04, 09)
@test BusinessDays.easter_date(Dates.Year(1951)) == Dates.Date(1951, 03, 25)
@test BusinessDays.easter_date(Dates.Year(1952)) == Dates.Date(1952, 04, 13)
@test BusinessDays.easter_date(Dates.Year(1953)) == Dates.Date(1953, 04, 05)
@test BusinessDays.easter_date(Dates.Year(1954)) == Dates.Date(1954, 04, 18)
@test BusinessDays.easter_date(Dates.Year(1955)) == Dates.Date(1955, 04, 10)
@test BusinessDays.easter_date(Dates.Year(1956)) == Dates.Date(1956, 04, 01)
@test BusinessDays.easter_date(Dates.Year(1957)) == Dates.Date(1957, 04, 21)
@test BusinessDays.easter_date(Dates.Year(1958)) == Dates.Date(1958, 04, 06)
@test BusinessDays.easter_date(Dates.Year(1959)) == Dates.Date(1959, 03, 29)
@test BusinessDays.easter_date(Dates.Year(1960)) == Dates.Date(1960, 04, 17)
@test BusinessDays.easter_date(Dates.Year(1961)) == Dates.Date(1961, 04, 02)
@test BusinessDays.easter_date(Dates.Year(1962)) == Dates.Date(1962, 04, 22)
@test BusinessDays.easter_date(Dates.Year(1963)) == Dates.Date(1963, 04, 14)
@test BusinessDays.easter_date(Dates.Year(1964)) == Dates.Date(1964, 03, 29)
@test BusinessDays.easter_date(Dates.Year(1965)) == Dates.Date(1965, 04, 18)
@test BusinessDays.easter_date(Dates.Year(1966)) == Dates.Date(1966, 04, 10)
@test BusinessDays.easter_date(Dates.Year(1967)) == Dates.Date(1967, 03, 26)
@test BusinessDays.easter_date(Dates.Year(1968)) == Dates.Date(1968, 04, 14)
@test BusinessDays.easter_date(Dates.Year(1969)) == Dates.Date(1969, 04, 06)
@test BusinessDays.easter_date(Dates.Year(1970)) == Dates.Date(1970, 03, 29)
@test BusinessDays.easter_date(Dates.Year(1971)) == Dates.Date(1971, 04, 11)
@test BusinessDays.easter_date(Dates.Year(1972)) == Dates.Date(1972, 04, 02)
@test BusinessDays.easter_date(Dates.Year(1973)) == Dates.Date(1973, 04, 22)
@test BusinessDays.easter_date(Dates.Year(1974)) == Dates.Date(1974, 04, 14)
@test BusinessDays.easter_date(Dates.Year(1975)) == Dates.Date(1975, 03, 30)
@test BusinessDays.easter_date(Dates.Year(1976)) == Dates.Date(1976, 04, 18)
@test BusinessDays.easter_date(Dates.Year(1977)) == Dates.Date(1977, 04, 10)
@test BusinessDays.easter_date(Dates.Year(1978)) == Dates.Date(1978, 03, 26)
@test BusinessDays.easter_date(Dates.Year(1979)) == Dates.Date(1979, 04, 15)
@test BusinessDays.easter_date(Dates.Year(1980)) == Dates.Date(1980, 04, 06)
@test BusinessDays.easter_date(Dates.Year(1981)) == Dates.Date(1981, 04, 19)
@test BusinessDays.easter_date(Dates.Year(1982)) == Dates.Date(1982, 04, 11)
@test BusinessDays.easter_date(Dates.Year(1983)) == Dates.Date(1983, 04, 03)
@test BusinessDays.easter_date(Dates.Year(1984)) == Dates.Date(1984, 04, 22)
@test BusinessDays.easter_date(Dates.Year(1985)) == Dates.Date(1985, 04, 07)
@test BusinessDays.easter_date(Dates.Year(1986)) == Dates.Date(1986, 03, 30)
@test BusinessDays.easter_date(Dates.Year(1987)) == Dates.Date(1987, 04, 19)
@test BusinessDays.easter_date(Dates.Year(1988)) == Dates.Date(1988, 04, 03)
@test BusinessDays.easter_date(Dates.Year(1989)) == Dates.Date(1989, 03, 26)
@test BusinessDays.easter_date(Dates.Year(1990)) == Dates.Date(1990, 04, 15)
@test BusinessDays.easter_date(Dates.Year(1991)) == Dates.Date(1991, 03, 31)
@test BusinessDays.easter_date(Dates.Year(1992)) == Dates.Date(1992, 04, 19)
@test BusinessDays.easter_date(Dates.Year(1993)) == Dates.Date(1993, 04, 11)
@test BusinessDays.easter_date(Dates.Year(1994)) == Dates.Date(1994, 04, 03)
@test BusinessDays.easter_date(Dates.Year(1995)) == Dates.Date(1995, 04, 16)
@test BusinessDays.easter_date(Dates.Year(1996)) == Dates.Date(1996, 04, 07)
@test BusinessDays.easter_date(Dates.Year(1997)) == Dates.Date(1997, 03, 30)
@test BusinessDays.easter_date(Dates.Year(1998)) == Dates.Date(1998, 04, 12)
@test BusinessDays.easter_date(Dates.Year(1999)) == Dates.Date(1999, 04, 04)
@test BusinessDays.easter_date(Dates.Year(2000)) == Dates.Date(2000, 04, 23)
@test BusinessDays.easter_date(Dates.Year(2001)) == Dates.Date(2001, 04, 15)
@test BusinessDays.easter_date(Dates.Year(2002)) == Dates.Date(2002, 03, 31)
@test BusinessDays.easter_date(Dates.Year(2003)) == Dates.Date(2003, 04, 20)
@test BusinessDays.easter_date(Dates.Year(2004)) == Dates.Date(2004, 04, 11)
@test BusinessDays.easter_date(Dates.Year(2005)) == Dates.Date(2005, 03, 27)
@test BusinessDays.easter_date(Dates.Year(2006)) == Dates.Date(2006, 04, 16)
@test BusinessDays.easter_date(Dates.Year(2007)) == Dates.Date(2007, 04, 08)
@test BusinessDays.easter_date(Dates.Year(2008)) == Dates.Date(2008, 03, 23)
@test BusinessDays.easter_date(Dates.Year(2009)) == Dates.Date(2009, 04, 12)
@test BusinessDays.easter_date(Dates.Year(2010)) == Dates.Date(2010, 04, 04)
@test BusinessDays.easter_date(Dates.Year(2011)) == Dates.Date(2011, 04, 24)
@test BusinessDays.easter_date(Dates.Year(2012)) == Dates.Date(2012, 04, 08)
@test BusinessDays.easter_date(Dates.Year(2013)) == Dates.Date(2013, 03, 31)
@test BusinessDays.easter_date(Dates.Year(2014)) == Dates.Date(2014, 04, 20)
@test BusinessDays.easter_date(Dates.Year(2015)) == Dates.Date(2015, 04, 05)
@test BusinessDays.easter_date(Dates.Year(2016)) == Dates.Date(2016, 03, 27)
@test BusinessDays.easter_date(Dates.Year(2017)) == Dates.Date(2017, 04, 16)
@test BusinessDays.easter_date(Dates.Year(2018)) == Dates.Date(2018, 04, 01)
@test BusinessDays.easter_date(Dates.Year(2019)) == Dates.Date(2019, 04, 21)
@test BusinessDays.easter_date(Dates.Year(2020)) == Dates.Date(2020, 04, 12)
@test BusinessDays.easter_date(Dates.Year(2021)) == Dates.Date(2021, 04, 04)
@test BusinessDays.easter_date(Dates.Year(2022)) == Dates.Date(2022, 04, 17)
@test BusinessDays.easter_date(Dates.Year(2023)) == Dates.Date(2023, 04, 09)
@test BusinessDays.easter_date(Dates.Year(2024)) == Dates.Date(2024, 03, 31)
@test BusinessDays.easter_date(Dates.Year(2025)) == Dates.Date(2025, 04, 20)
@test BusinessDays.easter_date(Dates.Year(2026)) == Dates.Date(2026, 04, 05)
@test BusinessDays.easter_date(Dates.Year(2027)) == Dates.Date(2027, 03, 28)
@test BusinessDays.easter_date(Dates.Year(2028)) == Dates.Date(2028, 04, 16)
@test BusinessDays.easter_date(Dates.Year(2029)) == Dates.Date(2029, 04, 01)
@test BusinessDays.easter_date(Dates.Year(2030)) == Dates.Date(2030, 04, 21)
@test BusinessDays.easter_date(Dates.Year(2031)) == Dates.Date(2031, 04, 13)
@test BusinessDays.easter_date(Dates.Year(2032)) == Dates.Date(2032, 03, 28)
@test BusinessDays.easter_date(Dates.Year(2033)) == Dates.Date(2033, 04, 17)
@test BusinessDays.easter_date(Dates.Year(2034)) == Dates.Date(2034, 04, 09)
@test BusinessDays.easter_date(Dates.Year(2035)) == Dates.Date(2035, 03, 25)
@test BusinessDays.easter_date(Dates.Year(2036)) == Dates.Date(2036, 04, 13)
@test BusinessDays.easter_date(Dates.Year(2037)) == Dates.Date(2037, 04, 05)
@test BusinessDays.easter_date(Dates.Year(2038)) == Dates.Date(2038, 04, 25)
@test BusinessDays.easter_date(Dates.Year(2039)) == Dates.Date(2039, 04, 10)
@test BusinessDays.easter_date(Dates.Year(2040)) == Dates.Date(2040, 04, 01)
@test BusinessDays.easter_date(Dates.Year(2041)) == Dates.Date(2041, 04, 21)
@test BusinessDays.easter_date(Dates.Year(2042)) == Dates.Date(2042, 04, 06)
@test BusinessDays.easter_date(Dates.Year(2043)) == Dates.Date(2043, 03, 29)
@test BusinessDays.easter_date(Dates.Year(2044)) == Dates.Date(2044, 04, 17)
@test BusinessDays.easter_date(Dates.Year(2045)) == Dates.Date(2045, 04, 09)
@test BusinessDays.easter_date(Dates.Year(2046)) == Dates.Date(2046, 03, 25)
@test BusinessDays.easter_date(Dates.Year(2047)) == Dates.Date(2047, 04, 14)
@test BusinessDays.easter_date(Dates.Year(2048)) == Dates.Date(2048, 04, 05)
@test BusinessDays.easter_date(Dates.Year(2049)) == Dates.Date(2049, 04, 18)
@test BusinessDays.easter_date(Dates.Year(2050)) == Dates.Date(2050, 04, 10)
@test BusinessDays.easter_date(Dates.Year(2051)) == Dates.Date(2051, 04, 02)
@test BusinessDays.easter_date(Dates.Year(2052)) == Dates.Date(2052, 04, 21)
@test BusinessDays.easter_date(Dates.Year(2053)) == Dates.Date(2053, 04, 06)
@test BusinessDays.easter_date(Dates.Year(2054)) == Dates.Date(2054, 03, 29)
@test BusinessDays.easter_date(Dates.Year(2055)) == Dates.Date(2055, 04, 18)
@test BusinessDays.easter_date(Dates.Year(2056)) == Dates.Date(2056, 04, 02)
@test BusinessDays.easter_date(Dates.Year(2057)) == Dates.Date(2057, 04, 22)
@test BusinessDays.easter_date(Dates.Year(2058)) == Dates.Date(2058, 04, 14)
@test BusinessDays.easter_date(Dates.Year(2059)) == Dates.Date(2059, 03, 30)
@test BusinessDays.easter_date(Dates.Year(2060)) == Dates.Date(2060, 04, 18)
@test BusinessDays.easter_date(Dates.Year(2061)) == Dates.Date(2061, 04, 10)
@test BusinessDays.easter_date(Dates.Year(2062)) == Dates.Date(2062, 03, 26)
@test BusinessDays.easter_date(Dates.Year(2063)) == Dates.Date(2063, 04, 15)
@test BusinessDays.easter_date(Dates.Year(2064)) == Dates.Date(2064, 04, 06)
@test BusinessDays.easter_date(Dates.Year(2065)) == Dates.Date(2065, 03, 29)
@test BusinessDays.easter_date(Dates.Year(2066)) == Dates.Date(2066, 04, 11)
@test BusinessDays.easter_date(Dates.Year(2067)) == Dates.Date(2067, 04, 03)
@test BusinessDays.easter_date(Dates.Year(2068)) == Dates.Date(2068, 04, 22)
@test BusinessDays.easter_date(Dates.Year(2069)) == Dates.Date(2069, 04, 14)
@test BusinessDays.easter_date(Dates.Year(2070)) == Dates.Date(2070, 03, 30)
@test BusinessDays.easter_date(Dates.Year(2071)) == Dates.Date(2071, 04, 19)
@test BusinessDays.easter_date(Dates.Year(2072)) == Dates.Date(2072, 04, 10)
@test BusinessDays.easter_date(Dates.Year(2073)) == Dates.Date(2073, 03, 26)
@test BusinessDays.easter_date(Dates.Year(2074)) == Dates.Date(2074, 04, 15)
@test BusinessDays.easter_date(Dates.Year(2075)) == Dates.Date(2075, 04, 07)
@test BusinessDays.easter_date(Dates.Year(2076)) == Dates.Date(2076, 04, 19)
@test BusinessDays.easter_date(Dates.Year(2077)) == Dates.Date(2077, 04, 11)
@test BusinessDays.easter_date(Dates.Year(2078)) == Dates.Date(2078, 04, 03)

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
