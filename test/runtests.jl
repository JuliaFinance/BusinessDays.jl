
using Base.Dates
using BusinessDays
using Base.Test

#sizeof(x[1]) = 31221
#sizeof(x[2]) = 249768

#--track-allocation=<setting>
#Profile.clear_malloc_data() 
#@profile (for i = 1:100; myfunc(); end)
#Profile.print(format=:flat)
#Profile.clear()


#@test hello("Julia") == "Hello, Julia"
#@test_approx_eq domath(2.0) 7.0

###########
# types.jl
###########
bhc = BrazilBanking()
#uhc = UnitedStates()

# two different instances of the same HolidayCalendar subtype should be equal
@test bhc == BrazilBanking()
#@test uhc == UnitedStates()
#@test bhc != uhc

# Check typing system
@test typeof(bhc) <: HolidayCalendar
#@test typeof(uhc) <: HolidayCalendar

# Same tests for result of holidaycalendarlist()
lst = holidaycalendarlist()

for hc in lst
	@test typeof(hc) <: HolidayCalendar
	@test hc != Type(BrazilBanking) # content of list is an instance, not a singleton
end

################
## easter.jl
################

# easter dates from http://www.maa.mhn.de/StarDate/publ_holidays.html
@test easter_date(Year(1901)) == Date(1901, 04, 07)
@test easter_date(Year(1902)) == Date(1902, 03, 30)
@test easter_date(Year(1903)) == Date(1903, 04, 12)
@test easter_date(Year(1904)) == Date(1904, 04, 03)
@test easter_date(Year(1905)) == Date(1905, 04, 23)
@test easter_date(Year(1906)) == Date(1906, 04, 15)
@test easter_date(Year(1907)) == Date(1907, 03, 31)
@test easter_date(Year(1908)) == Date(1908, 04, 19)
@test easter_date(Year(1909)) == Date(1909, 04, 11)
@test easter_date(Year(1910)) == Date(1910, 03, 27)
@test easter_date(Year(1911)) == Date(1911, 04, 16)
@test easter_date(Year(1912)) == Date(1912, 04, 07)
@test easter_date(Year(1913)) == Date(1913, 03, 23)
@test easter_date(Year(1914)) == Date(1914, 04, 12)
@test easter_date(Year(1915)) == Date(1915, 04, 04)
@test easter_date(Year(1916)) == Date(1916, 04, 23)
@test easter_date(Year(1917)) == Date(1917, 04, 08)
@test easter_date(Year(1918)) == Date(1918, 03, 31)
@test easter_date(Year(1919)) == Date(1919, 04, 20)
@test easter_date(Year(1920)) == Date(1920, 04, 04)
@test easter_date(Year(1921)) == Date(1921, 03, 27)
@test easter_date(Year(1922)) == Date(1922, 04, 16)
@test easter_date(Year(1923)) == Date(1923, 04, 01)
@test easter_date(Year(1924)) == Date(1924, 04, 20)
@test easter_date(Year(1925)) == Date(1925, 04, 12)
@test easter_date(Year(1926)) == Date(1926, 04, 04)
@test easter_date(Year(1927)) == Date(1927, 04, 17)
@test easter_date(Year(1928)) == Date(1928, 04, 08)
@test easter_date(Year(1929)) == Date(1929, 03, 31)
@test easter_date(Year(1930)) == Date(1930, 04, 20)
@test easter_date(Year(1931)) == Date(1931, 04, 05)
@test easter_date(Year(1932)) == Date(1932, 03, 27)
@test easter_date(Year(1933)) == Date(1933, 04, 16)
@test easter_date(Year(1934)) == Date(1934, 04, 01)
@test easter_date(Year(1935)) == Date(1935, 04, 21)
@test easter_date(Year(1936)) == Date(1936, 04, 12)
@test easter_date(Year(1937)) == Date(1937, 03, 28)
@test easter_date(Year(1938)) == Date(1938, 04, 17)
@test easter_date(Year(1939)) == Date(1939, 04, 09)
@test easter_date(Year(1940)) == Date(1940, 03, 24)
@test easter_date(Year(1941)) == Date(1941, 04, 13)
@test easter_date(Year(1942)) == Date(1942, 04, 05)
@test easter_date(Year(1943)) == Date(1943, 04, 25)
@test easter_date(Year(1944)) == Date(1944, 04, 09)
@test easter_date(Year(1945)) == Date(1945, 04, 01)
@test easter_date(Year(1946)) == Date(1946, 04, 21)
@test easter_date(Year(1947)) == Date(1947, 04, 06)
@test easter_date(Year(1948)) == Date(1948, 03, 28)
@test easter_date(Year(1949)) == Date(1949, 04, 17)
@test easter_date(Year(1950)) == Date(1950, 04, 09)
@test easter_date(Year(1951)) == Date(1951, 03, 25)
@test easter_date(Year(1952)) == Date(1952, 04, 13)
@test easter_date(Year(1953)) == Date(1953, 04, 05)
@test easter_date(Year(1954)) == Date(1954, 04, 18)
@test easter_date(Year(1955)) == Date(1955, 04, 10)
@test easter_date(Year(1956)) == Date(1956, 04, 01)
@test easter_date(Year(1957)) == Date(1957, 04, 21)
@test easter_date(Year(1958)) == Date(1958, 04, 06)
@test easter_date(Year(1959)) == Date(1959, 03, 29)
@test easter_date(Year(1960)) == Date(1960, 04, 17)
@test easter_date(Year(1961)) == Date(1961, 04, 02)
@test easter_date(Year(1962)) == Date(1962, 04, 22)
@test easter_date(Year(1963)) == Date(1963, 04, 14)
@test easter_date(Year(1964)) == Date(1964, 03, 29)
@test easter_date(Year(1965)) == Date(1965, 04, 18)
@test easter_date(Year(1966)) == Date(1966, 04, 10)
@test easter_date(Year(1967)) == Date(1967, 03, 26)
@test easter_date(Year(1968)) == Date(1968, 04, 14)
@test easter_date(Year(1969)) == Date(1969, 04, 06)
@test easter_date(Year(1970)) == Date(1970, 03, 29)
@test easter_date(Year(1971)) == Date(1971, 04, 11)
@test easter_date(Year(1972)) == Date(1972, 04, 02)
@test easter_date(Year(1973)) == Date(1973, 04, 22)
@test easter_date(Year(1974)) == Date(1974, 04, 14)
@test easter_date(Year(1975)) == Date(1975, 03, 30)
@test easter_date(Year(1976)) == Date(1976, 04, 18)
@test easter_date(Year(1977)) == Date(1977, 04, 10)
@test easter_date(Year(1978)) == Date(1978, 03, 26)
@test easter_date(Year(1979)) == Date(1979, 04, 15)
@test easter_date(Year(1980)) == Date(1980, 04, 06)
@test easter_date(Year(1981)) == Date(1981, 04, 19)
@test easter_date(Year(1982)) == Date(1982, 04, 11)
@test easter_date(Year(1983)) == Date(1983, 04, 03)
@test easter_date(Year(1984)) == Date(1984, 04, 22)
@test easter_date(Year(1985)) == Date(1985, 04, 07)
@test easter_date(Year(1986)) == Date(1986, 03, 30)
@test easter_date(Year(1987)) == Date(1987, 04, 19)
@test easter_date(Year(1988)) == Date(1988, 04, 03)
@test easter_date(Year(1989)) == Date(1989, 03, 26)
@test easter_date(Year(1990)) == Date(1990, 04, 15)
@test easter_date(Year(1991)) == Date(1991, 03, 31)
@test easter_date(Year(1992)) == Date(1992, 04, 19)
@test easter_date(Year(1993)) == Date(1993, 04, 11)
@test easter_date(Year(1994)) == Date(1994, 04, 03)
@test easter_date(Year(1995)) == Date(1995, 04, 16)
@test easter_date(Year(1996)) == Date(1996, 04, 07)
@test easter_date(Year(1997)) == Date(1997, 03, 30)
@test easter_date(Year(1998)) == Date(1998, 04, 12)
@test easter_date(Year(1999)) == Date(1999, 04, 04)
@test easter_date(Year(2000)) == Date(2000, 04, 23)
@test easter_date(Year(2001)) == Date(2001, 04, 15)
@test easter_date(Year(2002)) == Date(2002, 03, 31)
@test easter_date(Year(2003)) == Date(2003, 04, 20)
@test easter_date(Year(2004)) == Date(2004, 04, 11)
@test easter_date(Year(2005)) == Date(2005, 03, 27)
@test easter_date(Year(2006)) == Date(2006, 04, 16)
@test easter_date(Year(2007)) == Date(2007, 04, 08)
@test easter_date(Year(2008)) == Date(2008, 03, 23)
@test easter_date(Year(2009)) == Date(2009, 04, 12)
@test easter_date(Year(2010)) == Date(2010, 04, 04)
@test easter_date(Year(2011)) == Date(2011, 04, 24)
@test easter_date(Year(2012)) == Date(2012, 04, 08)
@test easter_date(Year(2013)) == Date(2013, 03, 31)
@test easter_date(Year(2014)) == Date(2014, 04, 20)
@test easter_date(Year(2015)) == Date(2015, 04, 05)
@test easter_date(Year(2016)) == Date(2016, 03, 27)
@test easter_date(Year(2017)) == Date(2017, 04, 16)
@test easter_date(Year(2018)) == Date(2018, 04, 01)
@test easter_date(Year(2019)) == Date(2019, 04, 21)
@test easter_date(Year(2020)) == Date(2020, 04, 12)
@test easter_date(Year(2021)) == Date(2021, 04, 04)
@test easter_date(Year(2022)) == Date(2022, 04, 17)
@test easter_date(Year(2023)) == Date(2023, 04, 09)
@test easter_date(Year(2024)) == Date(2024, 03, 31)
@test easter_date(Year(2025)) == Date(2025, 04, 20)
@test easter_date(Year(2026)) == Date(2026, 04, 05)
@test easter_date(Year(2027)) == Date(2027, 03, 28)
@test easter_date(Year(2028)) == Date(2028, 04, 16)
@test easter_date(Year(2029)) == Date(2029, 04, 01)
@test easter_date(Year(2030)) == Date(2030, 04, 21)
@test easter_date(Year(2031)) == Date(2031, 04, 13)
@test easter_date(Year(2032)) == Date(2032, 03, 28)
@test easter_date(Year(2033)) == Date(2033, 04, 17)
@test easter_date(Year(2034)) == Date(2034, 04, 09)
@test easter_date(Year(2035)) == Date(2035, 03, 25)
@test easter_date(Year(2036)) == Date(2036, 04, 13)
@test easter_date(Year(2037)) == Date(2037, 04, 05)
@test easter_date(Year(2038)) == Date(2038, 04, 25)
@test easter_date(Year(2039)) == Date(2039, 04, 10)
@test easter_date(Year(2040)) == Date(2040, 04, 01)
@test easter_date(Year(2041)) == Date(2041, 04, 21)
@test easter_date(Year(2042)) == Date(2042, 04, 06)
@test easter_date(Year(2043)) == Date(2043, 03, 29)
@test easter_date(Year(2044)) == Date(2044, 04, 17)
@test easter_date(Year(2045)) == Date(2045, 04, 09)
@test easter_date(Year(2046)) == Date(2046, 03, 25)
@test easter_date(Year(2047)) == Date(2047, 04, 14)
@test easter_date(Year(2048)) == Date(2048, 04, 05)
@test easter_date(Year(2049)) == Date(2049, 04, 18)
@test easter_date(Year(2050)) == Date(2050, 04, 10)
@test easter_date(Year(2051)) == Date(2051, 04, 02)
@test easter_date(Year(2052)) == Date(2052, 04, 21)
@test easter_date(Year(2053)) == Date(2053, 04, 06)
@test easter_date(Year(2054)) == Date(2054, 03, 29)
@test easter_date(Year(2055)) == Date(2055, 04, 18)
@test easter_date(Year(2056)) == Date(2056, 04, 02)
@test easter_date(Year(2057)) == Date(2057, 04, 22)
@test easter_date(Year(2058)) == Date(2058, 04, 14)
@test easter_date(Year(2059)) == Date(2059, 03, 30)
@test easter_date(Year(2060)) == Date(2060, 04, 18)
@test easter_date(Year(2061)) == Date(2061, 04, 10)
@test easter_date(Year(2062)) == Date(2062, 03, 26)
@test easter_date(Year(2063)) == Date(2063, 04, 15)
@test easter_date(Year(2064)) == Date(2064, 04, 06)
@test easter_date(Year(2065)) == Date(2065, 03, 29)
@test easter_date(Year(2066)) == Date(2066, 04, 11)
@test easter_date(Year(2067)) == Date(2067, 04, 03)
@test easter_date(Year(2068)) == Date(2068, 04, 22)
@test easter_date(Year(2069)) == Date(2069, 04, 14)
@test easter_date(Year(2070)) == Date(2070, 03, 30)
@test easter_date(Year(2071)) == Date(2071, 04, 19)
@test easter_date(Year(2072)) == Date(2072, 04, 10)
@test easter_date(Year(2073)) == Date(2073, 03, 26)
@test easter_date(Year(2074)) == Date(2074, 04, 15)
@test easter_date(Year(2075)) == Date(2075, 04, 07)
@test easter_date(Year(2076)) == Date(2076, 04, 19)
@test easter_date(Year(2077)) == Date(2077, 04, 11)
@test easter_date(Year(2078)) == Date(2078, 04, 03)


################
# bdayscache.jl
################
for usecache in [false, true]

	print("########################\n")
	print("Using cache: $(usecache)\n")
	print("########################\n")

	if usecache
		BusinessDays.initcache()
	end

	################
	# bdays.jl
	################
	#export
	#	isweekend, isbday, tobday, advancebdays, bdays

	dt_friday = Date(2015, 06, 26)
	dt_saturday = Date(2015, 06, 27)
	dt_sunday = Date(2015, 06, 28)
	dt_monday = Date(2015, 06, 29)

	hc_brazil = BrazilBanking()

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

	@test tobday(hc_brazil, Date(2013, 02, 08)) == Date(2013, 02, 08) # regular friday
	@test tobday(hc_brazil, Date(2013, 02, 09)) == Date(2013, 02, 13) # after carnaval

	@test advancebdays(hc_brazil, Date(2013, 02, 06), 0) == Date(2013, 02, 06) # regular wednesday
	@test advancebdays(hc_brazil, Date(2013, 02, 06), 1) == Date(2013, 02, 07) # regular thursday
	@test advancebdays(hc_brazil, Date(2013, 02, 06), 2) == Date(2013, 02, 08) # regular friday
	@test advancebdays(hc_brazil, Date(2013, 02, 06), 3) == Date(2013, 02, 13) # after carnaval wednesday
	@test advancebdays(hc_brazil, Date(2013, 02, 06), 4) == Date(2013, 02, 14) # after carnaval thursday

	@test bdays(hc_brazil, Date(2013, 02, 06), Date(2013, 02, 06)) == Day(0)
	@test bdays(hc_brazil, Date(2013, 02, 06), Date(2013, 02, 07)) == Day(1)
	@test bdays(hc_brazil, Date(2013, 02, 07), Date(2013, 02, 06)).value == 1
	@test bdays(hc_brazil, Date(2013, 02, 06), Date(2013, 02, 08)).value == 2
	@test bdays(hc_brazil, Date(2013, 02, 06), Date(2013, 02, 09)).value == 3
	@test bdays(hc_brazil, Date(2013, 02, 06), Date(2013, 02, 10)).value == 3
	@test bdays(hc_brazil, Date(2013, 02, 06), Date(2013, 02, 11)).value == 3
	@test bdays(hc_brazil, Date(2013, 02, 06), Date(2013, 02, 12)).value == 3
	@test bdays(hc_brazil, Date(2013, 02, 06), Date(2013, 02, 13)).value == 3
	@test bdays(hc_brazil, Date(2013, 02, 06), Date(2013, 02, 14)).value == 4

	d0 = Date(2015, 06, 29) ; d2 = Date(2100, 12, 20)
	@test bdays(BrazilBanking(), d0, d2).value == 21471

	tobday(BrazilBanking(), d0)
	tobday(BrazilBanking(), d2)

	@time bdays(BrazilBanking(), d0, d2)
	# no cache 7.579 milliseconds (106 k allocations: 3609 KB)
	# cached 721 nanoseconds  (4 allocations: 64 bytes)

	@time for i in 1:100 bdays(BrazilBanking(), d0, d2) end
	# no cache
	# 680.280 milliseconds (10607 k allocations: 352 MB, 2.84% gc time), commit 147fa0b
	# cached
	# 55.766 microseconds (400 allocations: 6400 bytes)

	dInicio = Date(1900, 01, 01) ; dFim = Date(2100, 12, 20)

	@time x = BusinessDays._createbdayscache(BrazilBanking(), dInicio, dFim)
	# no cache
	# 15.370 milliseconds (322 k allocations: 9982 KB, 7.23% gc time)
	# cached
	# 11.830 milliseconds (146 k allocations: 2644 KB)

	if usecache
		print("\n a million... \n")
		@time for i in 1:1000000 bdays(BrazilBanking(), d0, d2) end
	end

end

