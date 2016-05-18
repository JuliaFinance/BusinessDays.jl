
using Base.Dates
using BusinessDays
using Base.Test

bd = BusinessDays

###########
# types.jl
###########
bhc = bd.Brazil()
ushc = bd.USSettlement()
ukhc = bd.UKSettlement()
usnysehc = bd.USNYSE()
usgovbondhc = bd.USGovernmentBond()
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
## easter.jl
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

###################################
# isholiday.jl auxiliary functions
###################################
# weekday values:
# const Monday,Tuesday,Wednesday,Thursday,Friday,Saturday,Sunday = 1,2,3,4,5,6,7
# see query.jl on Dates module
# See also dayofweek(dt) function.
# this should go to Base.Dates
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

@test_throws ErrorException bd.findweekday(Dates.Wednesday, 2015, 07, -1, false)
@test_throws ErrorException bd.findweekday(Dates.Wednesday, 2015, 07, -1, true)

len = typemax(UInt32) + 1
d0 = Date(1950, 2, 1)
d1 = d0 + Day(len)
@test_throws ErrorException bd._createbdayscache(bhc, d0, d1)

# Create HolidayCalendar instances
hc_brazil = bd.Brazil()
hc_usa = bd.USSettlement()
hc_uk = bd.UKSettlement()
hc_usnyse = bd.USNYSE()
hc_usgovbond = bd.USGovernmentBond()

################
# bdayscache.jl
################
for usecache in [false, true]

    print("##########################\n")
    print(" Using cache: $(usecache)\n")
    print("##########################\n")

    if usecache
        bd.initcache(all_calendars_vec)
    end

    ################
    # bdays.jl
    ################
    #export
    #   isweekend, isbday, tobday, advancebdays, bdays

    dt_friday = Date(2015, 06, 26)
    dt_saturday = Date(2015, 06, 27)
    dt_sunday = Date(2015, 06, 28)
    dt_monday = Date(2015, 06, 29)
    dt_newyears = Date(2016,1,1)

    # Bounds tests
    if !usecache
        # this should work
        isbday(hc_brazil, Date(1600,2,1))
        isbday(hc_brazil, Date(3000,2,1))
        bdays(hc_brazil, Date(1600,2,1), Date(1600, 2, 5))
        bdays(hc_brazil, Date(3000,2,1), Date(3000, 2, 5))
    else
        #this should not work
        @test_throws ErrorException isbday(hc_brazil, Date(1600,2,1))
        @test_throws ErrorException isbday(hc_brazil, Date(3000,2,1))
        @test_throws ErrorException bdays(hc_brazil, Date(1600,2,1), Date(1600, 2, 5))
        @test_throws ErrorException bdays(hc_brazil, Date(3000,2,1), Date(3000, 2, 5))
    end

    @test_throws ErrorException isbday(:UnknownCalendar, Date(2016,1,1))
    @test_throws ErrorException isbday("UnknownCalendar", Date(2016,1,1))

    @test isweekend(dt_friday) == false
    @test isweekend(dt_saturday) == true
    @test isweekend(dt_sunday) == true
    @test isweekend(dt_monday) == false

    @test isbday(hc_brazil, dt_friday) == true
    @test isbday(hc_brazil, dt_saturday) == false
    @test isbday(hc_brazil, dt_sunday) == false
    @test isbday(hc_brazil, dt_monday) == true

    @test isholiday(hc_brazil, dt_friday) == false
    @test isholiday(hc_brazil, dt_saturday) == false
    @test isholiday(hc_brazil, dt_sunday) == false
    @test isholiday(hc_brazil, dt_monday) == false
    @test isholiday(hc_brazil, dt_newyears) == true

    # Symbol
    @test isholiday(:Brazil, dt_friday) == false
    @test isholiday(:Brazil, dt_saturday) == false
    @test isholiday(:Brazil, dt_sunday) == false
    @test isholiday(:Brazil, dt_monday) == false
    @test isholiday(:Brazil, dt_newyears) == true

    # String
    @test isholiday("Brazil", dt_friday) == false
    @test isholiday("Brazil", dt_saturday) == false
    @test isholiday("Brazil", dt_sunday) == false
    @test isholiday("Brazil", dt_monday) == false
    @test isholiday("Brazil", dt_newyears) == true

    @test isholiday(bd.NullHolidayCalendar(), Date(2000,10,1)) == false

    # Brazil HolidayCalendar tests
    @test isbday(hc_brazil, Date(2014, 12, 31)) == true # wednesday
    @test isbday(hc_brazil, Date(2015, 01, 01)) == false # new year
    @test isbday(hc_brazil, Date(2015, 01, 02)) == true # friday

    @test isbday(hc_brazil, Date(2015, 04, 20)) == true # monday
    @test isbday(hc_brazil, Date(2015, 04, 21)) == false # tiradentes
    @test isbday(hc_brazil, Date(2015, 04, 22)) == true # wednesday

    @test isbday(hc_brazil, Date(2015, 04, 30)) == true # thursday
    @test isbday(hc_brazil, Date(2015, 05, 01)) == false # labor day
    @test isbday(hc_brazil, Date(2015, 05, 02)) == false # saturday

    @test isbday(hc_brazil, Date(2015, 09, 06)) == false # sunday
    @test isbday(hc_brazil, Date(2015, 09, 07)) == false # independence day
    @test isbday(hc_brazil, Date(2015, 09, 08)) == true # tuesday

    @test isbday(hc_brazil, Date(2015, 10, 11)) == false # sunday
    @test isbday(hc_brazil, Date(2015, 10, 12)) == false # Nossa Senhora Aparecida
    @test isbday(hc_brazil, Date(2015, 10, 13)) == true # tuesday

    @test isbday(hc_brazil, Date(2015, 11, 01)) == false # sunday
    @test isbday(hc_brazil, Date(2015, 11, 02)) == false # Finados
    @test isbday(hc_brazil, Date(2015, 11, 03)) == true # tuesday

    @test isbday(hc_brazil, Date(2013, 11, 14)) == true # thursday
    @test isbday(hc_brazil, Date(2013, 11, 15)) == false # Republic
    @test isbday(hc_brazil, Date(2013, 11, 16)) == false # saturday

    @test isbday(hc_brazil, Date(2013, 12, 24)) == true # tuesday
    @test isbday(hc_brazil, Date(2013, 12, 25)) == false # Christmas
    @test isbday(hc_brazil, Date(2013, 12, 26)) == true # thursday

    @test isbday(hc_brazil, Date(2013, 02, 08)) == true # friday
    @test isbday(hc_brazil, Date(2013, 02, 09)) == false # saturday
    @test isbday(hc_brazil, Date(2013, 02, 10)) == false # sunday
    @test isbday(hc_brazil, Date(2013, 02, 11)) == false # segunda carnaval
    @test isbday(hc_brazil, Date(2013, 02, 12)) == false # terca carnaval
    @test isbday(hc_brazil, Date(2013, 02, 13)) == true # wednesday

    @test isbday(hc_brazil, Date(2013, 03, 28)) == true # thursday
    @test isbday(hc_brazil, Date(2013, 03, 29)) == false # sexta-feira santa
    @test isbday(hc_brazil, Date(2013, 03, 30)) == false # saturday

    @test isbday(hc_brazil, Date(2013, 05, 29)) == true # wednesday
    @test isbday(hc_brazil, Date(2013, 05, 30)) == false # Corpus Christi
    @test isbday(hc_brazil, Date(2013, 05, 31)) == true # friday

    # Symbol
    @test isbday(:Brazil, Date(2013, 05, 29)) == true # wednesday
    @test isbday(:Brazil, Date(2013, 05, 30)) == false # Corpus Christi
    @test isbday(:Brazil, Date(2013, 05, 31)) == true # friday

    # String
    @test isbday("Brazil", Date(2013, 05, 29)) == true # wednesday
    @test isbday("Brazil", Date(2013, 05, 30)) == false # Corpus Christi
    @test isbday("Brazil", Date(2013, 05, 31)) == true # friday

    # USSettlement HolidayCaledar tests
    # Federal Holidays listed on https://www.opm.gov/policy-data-oversight/snow-dismissal-procedures/federal-holidays/#url=2015
    @test isbday(hc_usa, Date(2014, 12, 31)) == true
    @test isbday(hc_usa, Date(2015, 01, 01)) == false # New Year's Day - Thursday
    @test isbday(hc_usa, Date(2015, 01, 02)) == true

    @test isbday(hc_usa, Date(2015, 01, 18)) == false
    @test isbday(hc_usa, Date(2015, 01, 19)) == false # Birthday of Martin Luther King, Jr. - Monday
    @test isbday(hc_usa, Date(2015, 01, 20)) == true

    @test isbday(hc_usa, Date(1982,01,18)) == true # not a holiday for Martin Luther King

    @test isbday(hc_usa, Date(2015, 02, 15)) == false
    @test isbday(hc_usa, Date(2015, 02, 16)) == false # Washington’s Birthday - Monday
    @test isbday(hc_usa, Date(2015, 02, 17)) == true

    @test isbday(hc_usa, Date(2015, 05, 24)) == false
    @test isbday(hc_usa, Date(2015, 05, 25)) == false # Memorial Day - Monday
    @test isbday(hc_usa, Date(2015, 05, 26)) == true

    @test isbday(hc_usa, Date(2015, 07, 02)) == true
    @test isbday(hc_usa, Date(2015, 07, 03)) == false # Independence Day - Friday
    @test isbday(hc_usa, Date(2015, 07, 04)) == false

    @test isbday(hc_usa, Date(2015, 09, 06)) == false
    @test isbday(hc_usa, Date(2015, 09, 07)) == false # Labor Day - Monday
    @test isbday(hc_usa, Date(2015, 09, 08)) == true

    @test isbday(hc_usa, Date(2015, 10, 11)) == false
    @test isbday(hc_usa, Date(2015, 10, 12)) == false # Columbus Day - Monday
    @test isbday(hc_usa, Date(2015, 10, 13)) == true

    @test isbday(hc_usa, Date(2015, 11, 10)) == true
    @test isbday(hc_usa, Date(2015, 11, 11)) == false # Veterans Day - Wednesday
    @test isbday(hc_usa, Date(2015, 11, 12)) == true

    @test isbday(hc_usa, Date(2015, 11, 25)) == true
    @test isbday(hc_usa, Date(2015, 11, 26)) == false # Thanksgiving Day - Thursday
    @test isbday(hc_usa, Date(2015, 11, 27)) == true

    @test isbday(hc_usa, Date(2015, 12, 24)) == true
    @test isbday(hc_usa, Date(2015, 12, 25)) == false # Christmas - Friday
    @test isbday(hc_usa, Date(2015, 12, 26)) == false

    @test isbday(hc_usa, Date(2010, 12, 31)) == false # new years day observed
    @test isbday(hc_usa, Date(2004, 12, 31)) == false # new years day observed

    @test isbday(hc_usa, Date(2013, 03, 28)) == true # thursday
    @test isbday(hc_usa, Date(2013, 03, 29)) == true # good friday
    @test isbday(hc_usa, Date(2013, 03, 30)) == false # saturday

    # Symbol
    @test isbday(:USSettlement, Date(2015, 12, 24)) == true
    @test isbday(:USSettlement, Date(2015, 12, 25)) == false # Christmas - Friday
    @test isbday(:USSettlement, Date(2015, 12, 26)) == false

    # String
    @test isbday("USSettlement", Date(2015, 12, 24)) == true
    @test isbday("USSettlement", Date(2015, 12, 25)) == false # Christmas - Friday
    @test isbday("USSettlement", Date(2015, 12, 26)) == false

    ## USNYSE HolidayCalendar tests

    @test isbday(hc_usnyse, Date(2014, 12, 31)) == true
    @test isbday(hc_usnyse, Date(2015, 01, 01)) == false # New Year's Day - Thursday
    @test isbday(hc_usnyse, Date(2015, 01, 02)) == true

    @test isbday(hc_usnyse, Date(2015, 01, 18)) == false
    @test isbday(hc_usnyse, Date(2015, 01, 19)) == false # Birthday of Martin Luther King, Jr. - Monday
    @test isbday(hc_usnyse, Date(2015, 01, 20)) == true

    @test isbday(hc_usnyse, Date(2015, 02, 15)) == false
    @test isbday(hc_usnyse, Date(2015, 02, 16)) == false # Washington’s Birthday - Monday
    @test isbday(hc_usnyse, Date(2015, 02, 17)) == true

    @test isbday(hc_usnyse, Date(2015, 05, 24)) == false
    @test isbday(hc_usnyse, Date(2015, 05, 25)) == false # Memorial Day - Monday
    @test isbday(hc_usnyse, Date(2015, 05, 26)) == true

    @test isbday(hc_usnyse, Date(2015, 07, 02)) == true
    @test isbday(hc_usnyse, Date(2015, 07, 03)) == false # Independence Day - Friday
    @test isbday(hc_usnyse, Date(2015, 07, 04)) == false

    @test isbday(hc_usnyse, Date(2015, 09, 06)) == false
    @test isbday(hc_usnyse, Date(2015, 09, 07)) == false # Labor Day - Monday
    @test isbday(hc_usnyse, Date(2015, 09, 08)) == true

    @test isbday(hc_usnyse, Date(2015, 10, 11)) == false
    @test isbday(hc_usnyse, Date(2015, 10, 12)) == true # Columbus Day - Monday
    @test isbday(hc_usnyse, Date(2015, 10, 13)) == true

    @test isbday(hc_usnyse, Date(2015, 11, 10)) == true
    @test isbday(hc_usnyse, Date(2015, 11, 11)) == true # Veterans Day - Wednesday
    @test isbday(hc_usnyse, Date(2015, 11, 12)) == true

    @test isbday(hc_usnyse, Date(2015, 11, 25)) == true
    @test isbday(hc_usnyse, Date(2015, 11, 26)) == false # Thanksgiving Day - Thursday
    @test isbday(hc_usnyse, Date(2015, 11, 27)) == true

    @test isbday(hc_usnyse, Date(2015, 12, 24)) == true
    @test isbday(hc_usnyse, Date(2015, 12, 25)) == false # Christmas - Friday
    @test isbday(hc_usnyse, Date(2015, 12, 26)) == false

    @test isbday(hc_usnyse, Date(2010, 12, 31)) == true # Friday before new years
    @test isbday(hc_usnyse, Date(2004, 12, 31)) == true # Friday before new years

    @test isbday(hc_usnyse, Date(2013, 03, 28)) == true # thursday
    @test isbday(hc_usnyse, Date(2013, 03, 29)) == false # good friday
    @test isbday(hc_usnyse, Date(2013, 03, 30)) == false # saturday

    # Symbol
    @test isbday(:USNYSE, Date(2015, 12, 24)) == true
    @test isbday(:USNYSE, Date(2015, 12, 25)) == false # Christmas - Friday
    @test isbday(:USNYSE, Date(2015, 12, 26)) == false

    # String
    @test isbday("USNYSE", Date(2015, 12, 24)) == true
    @test isbday("USNYSE", Date(2015, 12, 25)) == false # Christmas - Friday
    @test isbday("USNYSE", Date(2015, 12, 26)) == false

    ## USGovernmentBond HolidayCalendar tests
    @test isbday(hc_usgovbond, Date(2014, 12, 31)) == true
    @test isbday(hc_usgovbond, Date(2015, 01, 01)) == false # New Year's Day - Thursday
    @test isbday(hc_usgovbond, Date(2015, 01, 02)) == true

    @test isbday(hc_usgovbond, Date(2015, 01, 18)) == false
    @test isbday(hc_usgovbond, Date(2015, 01, 19)) == false # Birthday of Martin Luther King, Jr. - Monday
    @test isbday(hc_usgovbond, Date(2015, 01, 20)) == true

    @test isbday(hc_usgovbond, Date(2015, 02, 15)) == false
    @test isbday(hc_usgovbond, Date(2015, 02, 16)) == false # Washington’s Birthday - Monday
    @test isbday(hc_usgovbond, Date(2015, 02, 17)) == true

    @test isbday(hc_usgovbond, Date(2015, 05, 24)) == false
    @test isbday(hc_usgovbond, Date(2015, 05, 25)) == false # Memorial Day - Monday
    @test isbday(hc_usgovbond, Date(2015, 05, 26)) == true

    @test isbday(hc_usgovbond, Date(2015, 07, 02)) == true
    @test isbday(hc_usgovbond, Date(2015, 07, 03)) == false # Independence Day - Friday
    @test isbday(hc_usgovbond, Date(2015, 07, 04)) == false

    @test isbday(hc_usgovbond, Date(2015, 09, 06)) == false
    @test isbday(hc_usgovbond, Date(2015, 09, 07)) == false # Labor Day - Monday
    @test isbday(hc_usgovbond, Date(2015, 09, 08)) == true

    @test isbday(hc_usgovbond, Date(2015, 10, 11)) == false
    @test isbday(hc_usgovbond, Date(2015, 10, 12)) == false # Columbus Day - Monday
    @test isbday(hc_usgovbond, Date(2015, 10, 13)) == true

    @test isbday(hc_usgovbond, Date(2015, 11, 10)) == true
    @test isbday(hc_usgovbond, Date(2015, 11, 11)) == false # Veterans Day - Wednesday
    @test isbday(hc_usgovbond, Date(2015, 11, 12)) == true

    @test isbday(hc_usgovbond, Date(2015, 11, 25)) == true
    @test isbday(hc_usgovbond, Date(2015, 11, 26)) == false # Thanksgiving Day - Thursday
    @test isbday(hc_usgovbond, Date(2015, 11, 27)) == true

    @test isbday(hc_usgovbond, Date(2015, 12, 24)) == true
    @test isbday(hc_usgovbond, Date(2015, 12, 25)) == false # Christmas - Friday
    @test isbday(hc_usgovbond, Date(2015, 12, 26)) == false

    @test isbday(hc_usgovbond, Date(2010, 12, 31)) == true # Friday before new years
    @test isbday(hc_usgovbond, Date(2004, 12, 31)) == true # Friday before new years

    @test isbday(hc_usgovbond, Date(2013, 03, 28)) == true # thursday
    @test isbday(hc_usgovbond, Date(2013, 03, 29)) == false # good friday
    @test isbday(hc_usgovbond, Date(2013, 03, 30)) == false # saturday

    # Symbol
    @test isbday(:USGovernmentBond, Date(2015, 12, 24)) == true
    @test isbday(:USGovernmentBond, Date(2015, 12, 25)) == false # Christmas - Friday
    @test isbday(:USGovernmentBond, Date(2015, 12, 26)) == false

    # String
    @test isbday("USGovernmentBond", Date(2015, 12, 24)) == true
    @test isbday("USGovernmentBond", Date(2015, 12, 25)) == false # Christmas - Friday
    @test isbday("USGovernmentBond", Date(2015, 12, 26)) == false

    ## UKSettlement HolidayCalendar tests
    @test isbday(hc_uk, Date(2014, 12, 31)) == true
    @test isbday(hc_uk, Date(2015, 01, 01)) == false # New Year's Day Thursday
    @test isbday(hc_uk, Date(2015, 01, 02)) == true

    @test isbday(hc_uk, Date(2015, 08, 30)) == false 
    @test isbday(hc_uk, Date(2015, 08, 31)) == false # Monday   Summer bank holiday
    @test isbday(hc_uk, Date(2015, 09, 01)) == true

    @test isbday(hc_uk, Date(2015, 12, 24)) == true
    @test isbday(hc_uk, Date(2015, 12, 25)) == false # 25 December  Friday  Christmas Day
    @test isbday(hc_uk, Date(2015, 12, 26)) == false
    @test isbday(hc_uk, Date(2015, 12, 27)) == false
    @test isbday(hc_uk, Date(2015, 12, 28)) == false # Monday   Boxing Day (substitute day)
    @test isbday(hc_uk, Date(2015, 12, 29)) == true

    @test isbday(hc_uk, Date(2016, 03, 24)) == true 
    @test isbday(hc_uk, Date(2016, 03, 25)) == false # 25 March Friday  Good Friday
    @test isbday(hc_uk, Date(2016, 03, 26)) == false
    @test isbday(hc_uk, Date(2016, 03, 27)) == false
    @test isbday(hc_uk, Date(2016, 03, 28)) == false # 28 March Monday  Easter Monday
    @test isbday(hc_uk, Date(2016, 03, 29)) == true

    @test isbday(hc_uk, Date(2016, 05, 01)) == false
    @test isbday(hc_uk, Date(2016, 05, 02)) == false # 2 May    Monday  Early May bank holiday
    @test isbday(hc_uk, Date(2016, 05, 03)) == true

    @test isbday(hc_uk, Date(2016, 05, 29)) == false
    @test isbday(hc_uk, Date(2016, 05, 30)) == false # 30 May   Monday  Spring bank holiday
    @test isbday(hc_uk, Date(2016, 05, 31)) == true

    @test isbday(hc_uk, Date(2016, 08, 28)) == false
    @test isbday(hc_uk, Date(2016, 08, 29)) == false # 29 August    Monday  Summer bank holiday
    @test isbday(hc_uk, Date(2016, 08, 30)) == true

    @test isbday(hc_uk, Date(2016, 12, 23)) == true
    @test isbday(hc_uk, Date(2016, 12, 24)) == false
    @test isbday(hc_uk, Date(2016, 12, 25)) == false
    @test isbday(hc_uk, Date(2016, 12, 26)) == false # 26 December  Monday  Boxing Day
    @test isbday(hc_uk, Date(2016, 12, 27)) == false # 27 December  Tuesday Christmas Day (substitute day)
    @test isbday(hc_uk, Date(2016, 12, 28)) == true

    # 2012 UK Holidays
    @test isbday(hc_uk, Date(2011, 12, 30)) == true
    @test isbday(hc_uk, Date(2011, 12, 31)) == false
    @test isbday(hc_uk, Date(2012, 01, 01)) == false
    @test isbday(hc_uk, Date(2012, 01, 02)) == false # 2 January    Monday  New Year’s Day (substitute day)
    @test isbday(hc_uk, Date(2012, 01, 03)) == true

    @test isbday(hc_uk, Date(2012, 04, 05)) == true
    @test isbday(hc_uk, Date(2012, 04, 06)) == false # 6 April  Friday  Good Friday
    @test isbday(hc_uk, Date(2012, 04, 07)) == false
    @test isbday(hc_uk, Date(2012, 04, 08)) == false
    @test isbday(hc_uk, Date(2012, 04, 09)) == false # 9 April  Monday  Easter Monday
    @test isbday(hc_uk, Date(2012, 04, 10)) == true

    @test isbday(hc_uk, Date(2012, 05, 06)) == false
    @test isbday(hc_uk, Date(2012, 05, 07)) == false # 7 May    Monday  Early May bank holiday
    @test isbday(hc_uk, Date(2012, 05, 08)) == true

    @test isbday(hc_uk, Date(2012, 06, 01)) == true
    @test isbday(hc_uk, Date(2012, 06, 02)) == false
    @test isbday(hc_uk, Date(2012, 06, 03)) == false
    @test isbday(hc_uk, Date(2012, 06, 04)) == false # 4 June   Monday  Spring bank holiday (substitute day)
    @test isbday(hc_uk, Date(2012, 06, 05)) == false # 5 June   Tuesday Queen’s Diamond Jubilee (extra bank holiday)
    @test isbday(hc_uk, Date(2012, 06, 06)) == true

    @test isbday(hc_uk, Date(2011, 04, 29)) == false # wedding

    @test isbday(hc_uk, Date(2012, 08, 26)) == false
    @test isbday(hc_uk, Date(2012, 08, 27)) == false # 27 August    Monday  Summer bank holiday
    @test isbday(hc_uk, Date(2012, 08, 28)) == true

    @test isbday(hc_uk, Date(2012, 12, 24)) == true
    @test isbday(hc_uk, Date(2012, 12, 25)) == false # 25 December  Tuesday Christmas Day
    @test isbday(hc_uk, Date(2012, 12, 26)) == false # 26 December  Wednesday   Boxing Day
    @test isbday(hc_uk, Date(2012, 12, 27)) == true

    # 1999 UK holidays
    @test isbday(hc_uk, Date(1999, 12, 26)) == false # Sunday
    @test isbday(hc_uk, Date(1999, 12, 27)) == false # Christmas observed
    @test isbday(hc_uk, Date(1999, 12, 28)) == false # Boxing observed
    @test isbday(hc_uk, Date(1999, 12, 29)) == true
    @test isbday(hc_uk, Date(1999, 12, 30)) == true
    @test isbday(hc_uk, Date(1999, 12, 31)) == false

    @test tobday(hc_brazil, Date(2013, 02, 08)) == Date(2013, 02, 08) # regular friday
    @test tobday(hc_brazil, Date(2013, 02, 09)) == Date(2013, 02, 13) # after carnaval
    @test tobday(hc_brazil, Date(2013, 02, 09); forward = true) == Date(2013, 02, 13) # after carnaval
    @test tobday(hc_brazil, Date(2013, 02, 13); forward = false) == Date(2013, 02, 13) # after carnaval
    @test tobday(hc_brazil, Date(2013, 02, 12); forward = false) == Date(2013, 02, 08) # before carnaval

    @test tobday(:Brazil, Date(2013, 02, 08)) == Date(2013, 02, 08) # regular friday
    @test tobday(:Brazil, Date(2013, 02, 09)) == Date(2013, 02, 13) # after carnaval
    @test tobday(:Brazil, Date(2013, 02, 09); forward = true) == Date(2013, 02, 13) # after carnaval
    @test tobday(:Brazil, Date(2013, 02, 13); forward = false) == Date(2013, 02, 13) # after carnaval
    @test tobday(:Brazil, Date(2013, 02, 12); forward = false) == Date(2013, 02, 08) # before carnaval

    @test tobday("Brazil", Date(2013, 02, 08)) == Date(2013, 02, 08) # regular friday
    @test tobday("Brazil", Date(2013, 02, 09)) == Date(2013, 02, 13) # after carnaval
    @test tobday("Brazil", Date(2013, 02, 09); forward = true) == Date(2013, 02, 13) # after carnaval
    @test tobday("Brazil", Date(2013, 02, 13); forward = false) == Date(2013, 02, 13) # after carnaval
    @test tobday("Brazil", Date(2013, 02, 12); forward = false) == Date(2013, 02, 08) # before carnaval

    @test advancebdays(hc_brazil, Date(2013, 02, 06), 0) == Date(2013, 02, 06) # regular wednesday
    @test advancebdays(hc_brazil, Date(2013, 02, 06), 1) == Date(2013, 02, 07) # regular thursday
    @test advancebdays(hc_brazil, Date(2013, 02, 06), 2) == Date(2013, 02, 08) # regular friday
    @test advancebdays(hc_brazil, Date(2013, 02, 06), 3) == Date(2013, 02, 13) # after carnaval wednesday
    @test advancebdays(hc_brazil, Date(2013, 02, 06), 4) == Date(2013, 02, 14) # after carnaval thursday

    @test advancebdays(:Brazil, Date(2013, 02, 06), 0) == Date(2013, 02, 06) # regular wednesday
    @test advancebdays(:Brazil, Date(2013, 02, 06), 1) == Date(2013, 02, 07) # regular thursday
    @test advancebdays(:Brazil, Date(2013, 02, 06), 2) == Date(2013, 02, 08) # regular friday
    @test advancebdays(:Brazil, Date(2013, 02, 06), 3) == Date(2013, 02, 13) # after carnaval wednesday
    @test advancebdays(:Brazil, Date(2013, 02, 06), 4) == Date(2013, 02, 14) # after carnaval thursday

    @test advancebdays("Brazil", Date(2013, 02, 06), 0) == Date(2013, 02, 06) # regular wednesday
    @test advancebdays("Brazil", Date(2013, 02, 06), 1) == Date(2013, 02, 07) # regular thursday
    @test advancebdays("Brazil", Date(2013, 02, 06), 2) == Date(2013, 02, 08) # regular friday
    @test advancebdays("Brazil", Date(2013, 02, 06), 3) == Date(2013, 02, 13) # after carnaval wednesday
    @test advancebdays("Brazil", Date(2013, 02, 06), 4) == Date(2013, 02, 14) # after carnaval thursday

    @test bdays(hc_brazil, Date(2013, 02, 06), Date(2013, 02, 06)) == Day(0)
    @test bdays(hc_brazil, Date(2013, 02, 06), Date(2013, 02, 07)) == Day(1)
    @test bdays(hc_brazil, Date(2013, 02, 07), Date(2013, 02, 06)).value == -1
    @test bdays(hc_brazil, Date(2013, 02, 06), Date(2013, 02, 08)).value == 2
    @test bdays(hc_brazil, Date(2013, 02, 08), Date(2013, 02, 06)).value == -2
    @test bdays(hc_brazil, Date(2013, 02, 06), Date(2013, 02, 09)).value == 3
    @test bdays(hc_brazil, Date(2013, 02, 06), Date(2013, 02, 10)).value == 3
    @test bdays(hc_brazil, Date(2013, 02, 06), Date(2013, 02, 11)).value == 3
    @test bdays(hc_brazil, Date(2013, 02, 06), Date(2013, 02, 12)).value == 3
    @test bdays(hc_brazil, Date(2013, 02, 06), Date(2013, 02, 13)).value == 3
    @test bdays(hc_brazil, Date(2013, 02, 06), Date(2013, 02, 14)).value == 4
    @test bdays(hc_brazil, Date(2013, 02, 14), Date(2013, 02, 06)).value == -4

    # dates are treated per value
    d0 = Date(2013, 02, 06)
    d1 = Date(2013, 02, 14)
    @test bdays(hc_brazil, d0, d1).value == 4
    @test d0 == Date(2013, 02, 06) # d0 is changed inside bdays function, but outer-scope value remains the same
    @test d1 == Date(2013, 02, 14)

    d0 = Date(2015, 06, 29) ; d2 = Date(2100, 12, 20)
    @test bdays(hc_brazil, d0, d2).value == 21471

    # Tests for Composite Calendar
    @test isholiday(hc_composite_BR_USA, Date(2012,9,3)) # US Labor Day
    @test isholiday(hc_composite_BR_USA, Date(2012,9,7)) # BR Independence Day
    @test bdays(hc_composite_BR_USA, Date(2012,8,31), Date(2012,9,10)) == Day(4) # 3/sep labor day US, 7/sep Indep day BR

    println("Timing composite calendar bdays calculation")
    @time bdays(hc_composite_BR_USA, Date(2012,8,31), Date(2012,9,10))

    println("Timing single bdays calculation")
    @time bdays(hc_brazil, d0, d2)
    
    println("Timing 100 bdays calculations")
    @time for i in 1:100 bdays(hc_brazil, d0, d2) end
    
    dInicio = Date(1950, 01, 01) ; dFim = Date(2100, 12, 20)

    if !usecache
        println("Timing cache creation")
        @time x = bd._createbdayscache(hc_brazil, dInicio, dFim)
    end
    
    if usecache
        println("a million...")
        @time for i in 1:1000000 bdays(hc_brazil, d0, d2) end
    end

    # Vector functions
    d0 = Date(2000,01,04)
    d1 = Date(2020,01,04)

    d1vec = convert(Vector{Date}, d0:d1)
    d0vec = fill(d0, length(d1vec))

    r = bdays(hc_brazil, d0vec, d1vec)
    b = isbday(hc_brazil, d0vec)
    b2 = isbday(:Brazil, d0vec)
    b3 = isbday("Brazil", d0vec)
    @test tobday([hc_brazil, hc_usa], [Date(2015,11,11), Date(2015,11,11)]) == [Date(2015,11,11), Date(2015,11,12)]
    @test tobday([:Brazil, :USSettlement], [Date(2015,11,11), Date(2015,11,11)]) == [Date(2015,11,11), Date(2015,11,12)]
    @test tobday(["Brazil", "USSettlement"], [Date(2015,11,11), Date(2015,11,11)]) == [Date(2015,11,11), Date(2015,11,12)]

    # Vector with different sizes
    @test_throws ErrorException bdays(hc_brazil, fill(d0, length(d1vec)+1), d1vec)
    @test_throws ErrorException bdays([hc_brazil, hc_usa], [Date(2015,11,11)], [Date(2015,11,11),Date(2015,11,11)])
    @test_throws ErrorException tobday([hc_brazil, hc_usa], fill(d0, 3))
    @test_throws ErrorException isbday( [hc_brazil, hc_usa, hc_uk], [Date(2015,01,01), Date(2015,01,01)])

    println("Timing vectorized functions (vector length $(length(d0vec)))")
    @time bdays(hc_brazil, d0vec, d1vec)
    @time bdays(:Brazil, d0vec, d1vec)
    @time bdays("Brazil", d0vec, d1vec)
    @time isbday(hc_brazil, d0vec)
    @time isbday(:Brazil, d0vec)
    @time isbday("Brazil", d0vec)

    d2001 = convert(Array{Date,1}, Date(2001,01,01):Date(2001,01,15))

    @test isweekend(d2001) == [ false, false, false, false, false, true, true, false, false, false, false, false, true, true, false]
    @test tobday(hc_brazil, d2001; forward=true) == [ Date(2001,01,02), Date(2001,01,02), Date(2001,01,03), Date(2001,01,04), Date(2001,01,05), Date(2001,01,08), Date(2001,01,08), Date(2001,01,08), Date(2001,01,09), Date(2001,01,10), Date(2001,01,11), Date(2001,01,12), Date(2001,01,15), Date(2001,01,15), Date(2001,01,15)]
    @test tobday(hc_brazil, d2001; forward=false) == [ Date(2000,12,29), Date(2001,01,02), Date(2001,01,03), Date(2001,01,04), Date(2001,01,05), Date(2001,01,05), Date(2001,01,05), Date(2001,01,08), Date(2001,01,09), Date(2001,01,10), Date(2001,01,11), Date(2001,01,12), Date(2001,01,12), Date(2001,01,12), Date(2001,01,15)]

    @test tobday(:Brazil, d2001; forward=true) == [ Date(2001,01,02), Date(2001,01,02), Date(2001,01,03), Date(2001,01,04), Date(2001,01,05), Date(2001,01,08), Date(2001,01,08), Date(2001,01,08), Date(2001,01,09), Date(2001,01,10), Date(2001,01,11), Date(2001,01,12), Date(2001,01,15), Date(2001,01,15), Date(2001,01,15)]
    @test tobday("Brazil", d2001; forward=false) == [ Date(2000,12,29), Date(2001,01,02), Date(2001,01,03), Date(2001,01,04), Date(2001,01,05), Date(2001,01,05), Date(2001,01,05), Date(2001,01,08), Date(2001,01,09), Date(2001,01,10), Date(2001,01,11), Date(2001,01,12), Date(2001,01,12), Date(2001,01,12), Date(2001,01,15)]

    @test bdays([hc_brazil, hc_usa], [Date(2012,8,31), Date(2012,8,31)], [Date(2012,9,10), Date(2012,9,10)]) == [Day(5), Day(5)] # 1/sep labor day US, 7/sep Indep day BR
    @test isbday([hc_brazil, hc_usa], [Date(2012, 09, 07), Date(2012, 09, 03)]) == [false, false] # 1/sep labor day US, 7/sep Indep day BR
    @test advancebdays(hc_brazil, Date(2015,9,1), [0, 1, 3, 4, 5]) == [Date(2015,9,1),Date(2015,9,2),Date(2015,9,4),Date(2015,9,8),Date(2015,9,9)]
    @test advancebdays(hc_brazil, Date(2015,9,1), 0:5) == [Date(2015,9,1),Date(2015,9,2),Date(2015,9,3),Date(2015,9,4),Date(2015,9,8),Date(2015,9,9)]
    @test listholidays(hc_brazil, Date(2016,1,1), Date(2016,5,30)) == [Date(2016,1,1),Date(2016,2,8),Date(2016,2,9),Date(2016,3,25),Date(2016,4,21),Date(2016,5,1),Date(2016,5,26)]

    @test bdays([:Brazil, :USSettlement], [Date(2012,8,31), Date(2012,8,31)], [Date(2012,9,10), Date(2012,9,10)]) == [Day(5), Day(5)] # 1/sep labor day US, 7/sep Indep day BR
    @test isbday([:Brazil, :USSettlement], [Date(2012, 09, 07), Date(2012, 09, 03)]) == [false, false] # 1/sep labor day US, 7/sep Indep day BR
    @test advancebdays(:Brazil, Date(2015,9,1), [0, 1, 3, 4, 5]) == [Date(2015,9,1),Date(2015,9,2),Date(2015,9,4),Date(2015,9,8),Date(2015,9,9)]
    @test advancebdays(:Brazil, Date(2015,9,1), 0:5) == [Date(2015,9,1),Date(2015,9,2),Date(2015,9,3),Date(2015,9,4),Date(2015,9,8),Date(2015,9,9)]
    @test listholidays(:Brazil, Date(2016,1,1), Date(2016,5,30)) == [Date(2016,1,1),Date(2016,2,8),Date(2016,2,9),Date(2016,3,25),Date(2016,4,21),Date(2016,5,1),Date(2016,5,26)]

    @test bdays(["Brazil", "USSettlement"], [Date(2012,8,31), Date(2012,8,31)], [Date(2012,9,10), Date(2012,9,10)]) == [Day(5), Day(5)] # 1/sep labor day US, 7/sep Indep day BR
    @test isbday(["Brazil", "USSettlement"], [Date(2012, 09, 07), Date(2012, 09, 03)]) == [false, false] # 1/sep labor day US, 7/sep Indep day BR
    @test advancebdays("Brazil", Date(2015,9,1), [0, 1, 3, 4, 5]) == [Date(2015,9,1),Date(2015,9,2),Date(2015,9,4),Date(2015,9,8),Date(2015,9,9)]
    @test advancebdays("Brazil", Date(2015,9,1), 0:5) == [Date(2015,9,1),Date(2015,9,2),Date(2015,9,3),Date(2015,9,4),Date(2015,9,8),Date(2015,9,9)]
    @test listholidays("Brazil", Date(2016,1,1), Date(2016,5,30)) == [Date(2016,1,1),Date(2016,2,8),Date(2016,2,9),Date(2016,3,25),Date(2016,4,21),Date(2016,5,1),Date(2016,5,26)]

    @test listbdays("Brazil", Date(2016,5,18), Date(2016,5,23)) == [Date(2016,5,18),Date(2016,5,19),Date(2016,5,20),Date(2016,5,23)]
    @test listbdays("Brazil", Date(2016,5,18), Date(2016,5,18)) == [Date(2016,5,18)]
    @test isempty(listbdays("Brazil", Date(2016,5,21), Date(2016,5,21)))
    @test isempty(listbdays("Brazil", Date(2016,5,21), Date(2016,5,22)))
    @test listbdays("Brazil", Date(2016,5,21), Date(2016,5,23)) == [Date(2016,5,23)]
end

include("perftests.jl")

bd.cleancache(hc_brazil)
bd.cleancache()

type CustomCalendar <: HolidayCalendar end
cc = CustomCalendar()
@test_throws ErrorException isholiday(cc, Date(2015,1,1))
import BusinessDays.isholiday
isholiday(::CustomCalendar, dt::Date) = dt == Date(2015,8,27)
@test isholiday(cc, Date(2015,8,26)) == false
@test isholiday(cc, Date(2015,8,27)) == true
bd.initcache(cc)
@test isholiday(cc, Date(2015,8,26)) == false
@test isholiday(cc, Date(2015,8,27)) == true
bd.cleancache(cc)

sym_vec = [:Brazil, :UKSettlement]
bd.initcache(sym_vec)
bd.cleancache(sym_vec)

str_vec = ["Brazil", "UKSettlement"]
bd.initcache(str_vec)
bd.cleancache(str_vec)

bd.initcache("UKSettlement", Date(2000,1,1), Date(2000,5,2))
bd.cleancache("UKSettlement")

#=
INFO: Testing BusinessDays
easter minimum month is 3 on date 2100-03-28 
easter maximum month is 4 on date 2099-04-12
##########################
 Using cache: false
##########################
Timing composite calendar bdays calculation
  0.000022 seconds (30 allocations: 1.219 KB)
Timing single bdays calculation
  0.016914 seconds (31.22 k allocations: 2.382 MB, 30.99% gc time)
Timing 100 bdays calculations
  0.610497 seconds (3.12 M allocations: 238.206 MB, 1.74% gc time)
Timing cache creation
  0.010609 seconds (55.15 k allocations: 4.470 MB, 7.17% gc time)
Timing vectorized functions (vector length 7306)
  4.731765 seconds (26.71 M allocations: 1.990 GB, 1.70% gc time)
  4.709852 seconds (26.71 M allocations: 1.990 GB, 1.69% gc time)
  4.703030 seconds (26.71 M allocations: 1.990 GB, 1.62% gc time)
  0.001923 seconds (7.31 k allocations: 578.000 KB)
  0.001742 seconds (7.31 k allocations: 578.000 KB)
  0.001734 seconds (7.31 k allocations: 578.000 KB)
##########################
 Using cache: true
##########################
Timing composite calendar bdays calculation
  0.000006 seconds (7 allocations: 112 bytes)
Timing single bdays calculation
  0.000004 seconds (5 allocations: 80 bytes)
Timing 100 bdays calculations
  0.000066 seconds (500 allocations: 7.813 KB)
a million...
  0.589832 seconds (5.00 M allocations: 76.294 MB, 2.34% gc time)
Timing vectorized functions (vector length 7306)
  0.004112 seconds (29.23 k allocations: 513.766 KB)
  0.004052 seconds (29.23 k allocations: 513.766 KB)
  0.004037 seconds (29.23 k allocations: 513.766 KB)
  0.001003 seconds (1 allocation: 7.219 KB)
  0.000980 seconds (1 allocation: 7.219 KB)
  0.000979 seconds (1 allocation: 7.219 KB)
Perftests
  0.017908 seconds (1.48 k allocations: 374.630 KB)
  0.000005 seconds (9 allocations: 240 bytes)
  0.575191 seconds (5.00 M allocations: 76.294 MB, 1.38% gc time)
  1.226357 seconds (8.00 M allocations: 122.070 MB, 1.37% gc time)
  1.547292 seconds (8.00 M allocations: 122.070 MB, 1.36% gc time)
type
  0.000568 seconds (5.00 k allocations: 78.125 KB)
  0.000487 seconds (4.00 k allocations: 70.547 KB)
  0.000581 seconds (7.01 k allocations: 125.313 KB)
sym
  0.001273 seconds (8.00 k allocations: 125.000 KB)
  0.000504 seconds (4.00 k allocations: 70.547 KB)
  0.001064 seconds (7.01 k allocations: 125.313 KB)
str
  0.002078 seconds (8.00 k allocations: 125.000 KB)
  0.000630 seconds (4.00 k allocations: 70.547 KB)
  0.001645 seconds (7.01 k allocations: 125.313 KB)
initcache type
  0.013472 seconds (62.46 k allocations: 5.062 MB)
initcache sym
  0.028815 seconds (62.46 k allocations: 5.062 MB)
initcache str
  0.025278 seconds (62.46 k allocations: 5.062 MB)
INFO: BusinessDays tests passed
=#
