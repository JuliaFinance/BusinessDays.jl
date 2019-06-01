
print("##########################\n")
print(" Using cache: $(usecache)\n")
print("##########################\n")

if usecache
    BusinessDays.initcache(all_calendars_vec)
end

################
# bdays.jl
################
#export
#   isweekend, isbday, tobday, advancebdays, bdays

dt_tuesday = Dates.Date(2015,06,23)
dt_wednesday = Dates.Date(2015, 06, 24)
dt_thursday = Dates.Date(2015, 06, 25)
dt_friday = Dates.Date(2015, 06, 26)
dt_saturday = Dates.Date(2015, 06, 27)
dt_sunday = Dates.Date(2015, 06, 28)
dt_monday = Dates.Date(2015, 06, 29)
dt_newyears = Dates.Date(2016,1,1)

# Bounds tests
if !usecache
    # this should work
    isbday(hc_brazil, Dates.Date(1600,2,1))
    isbday(hc_brazil, Dates.Date(3000,2,1))
    bdays(hc_brazil, Dates.Date(1600,2,1), Dates.Date(1600, 2, 5))
    bdays(hc_brazil, Dates.Date(3000,2,1), Dates.Date(3000, 2, 5))
    bdayscount(hc_brazil, Dates.Date(1600,2,1), Dates.Date(1600, 2, 5))
    bdayscount(hc_brazil, Dates.Date(3000,2,1), Dates.Date(3000, 2, 5))
else
    #this should not work
    @test_throws AssertionError isbday(hc_brazil, Dates.Date(1600,2,1))
    @test_throws AssertionError isbday(hc_brazil, Dates.Date(3000,2,1))
    @test_throws AssertionError bdays(hc_brazil, Dates.Date(1600,2,1), Dates.Date(1600, 2, 5))
    @test_throws AssertionError bdays(hc_brazil, Dates.Date(3000,2,1), Dates.Date(3000, 2, 5))
    @test_throws AssertionError bdayscount(hc_brazil, Dates.Date(1600,2,1), Dates.Date(1600, 2, 5))
    @test_throws AssertionError bdayscount(hc_brazil, Dates.Date(3000,2,1), Dates.Date(3000, 2, 5))
end

@test_throws ErrorException isbday(:UnknownCalendar, Dates.Date(2016,1,1))
@test_throws ErrorException isbday("UnknownCalendar", Dates.Date(2016,1,1))

@test isweekend(dt_tuesday) == false
@test isweekend(dt_wednesday) == false
@test isweekend(dt_thursday) == false
@test isweekend(dt_friday) == false
@test isweekend(dt_saturday) == true
@test isweekend(dt_sunday) == true
@test isweekend(dt_monday) == false

@test isweekday(dt_tuesday) == true
@test isweekday(dt_wednesday) == true
@test isweekday(dt_thursday) == true
@test isweekday(dt_friday) == true
@test isweekday(dt_saturday) == false
@test isweekday(dt_sunday) == false
@test isweekday(dt_monday) == true

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

@test isholiday(BusinessDays.NullHolidayCalendar(), Dates.Date(2016,9,25)) == false
@test isholiday(:NullHolidayCalendar, Dates.Date(2016,9,25)) == false
@test isholiday("NullHolidayCalendar", Dates.Date(2016,9,25)) == false
@test isbday(BusinessDays.NullHolidayCalendar(), Dates.Date(2016,9,25)) == true
@test isbday(:NullHolidayCalendar, Dates.Date(2016,9,25)) == true
@test isbday("NullHolidayCalendar", Dates.Date(2016,9,25)) == true
@test bdayscount(:NullHolidayCalendar, Dates.Date(2016,9,25), Dates.Date(2016,9,28)) == 3
@test bdays(:NullHolidayCalendar, Dates.Date(2016,9,25), Dates.Date(2016,9,28)) == Dates.Dates.Day(3)

@test isholiday(BusinessDays.WeekendsOnly(), Dates.Date(2016,9,25)) == false
@test isholiday(:WeekendsOnly, Dates.Date(2016,9,25)) == false
@test isholiday("WeekendsOnly", Dates.Date(2016,9,25)) == false
@test isbday(BusinessDays.WeekendsOnly(), Dates.Date(2016,9,25)) == false
@test isbday(:WeekendsOnly, Dates.Date(2016,9,25)) == false
@test isbday("WeekendsOnly", Dates.Date(2016,9,25)) == false
@test bdayscount(:WeekendsOnly, Dates.Date(2016,9,25), Dates.Date(2016,9,28)) == 2
@test bdays(:WeekendsOnly, Dates.Date(2016,9,25), Dates.Date(2016,9,28)) == Dates.Dates.Day(2)

# Brazil HolidayCalendar tests
@test isbday(hc_brazil, Dates.Date(2014, 12, 31)) == true # wednesday
@test isbday(hc_brazil, Dates.Date(2015, 01, 01)) == false # new year
@test isbday(hc_brazil, Dates.Date(2015, 01, 02)) == true # friday

@test isbday(hc_brazil, Dates.Date(2015, 04, 20)) == true # monday
@test isbday(hc_brazil, Dates.Date(2015, 04, 21)) == false # tiradentes
@test isbday(hc_brazil, Dates.Date(2015, 04, 22)) == true # wednesday

@test isbday(hc_brazil, Dates.Date(2015, 04, 30)) == true # thursday
@test isbday(hc_brazil, Dates.Date(2015, 05, 01)) == false # labor day
@test isbday(hc_brazil, Dates.Date(2015, 05, 02)) == false # saturday

@test isbday(hc_brazil, Dates.Date(2015, 09, 06)) == false # sunday
@test isbday(hc_brazil, Dates.Date(2015, 09, 07)) == false # independence day
@test isbday(hc_brazil, Dates.Date(2015, 09, 08)) == true # tuesday

@test isbday(hc_brazil, Dates.Date(2015, 10, 11)) == false # sunday
@test isbday(hc_brazil, Dates.Date(2015, 10, 12)) == false # Nossa Senhora Aparecida
@test isbday(hc_brazil, Dates.Date(2015, 10, 13)) == true # tuesday

@test isbday(hc_brazil, Dates.Date(2015, 11, 01)) == false # sunday
@test isbday(hc_brazil, Dates.Date(2015, 11, 02)) == false # Finados
@test isbday(hc_brazil, Dates.Date(2015, 11, 03)) == true # tuesday

@test isbday(hc_brazil, Dates.Date(2013, 11, 14)) == true # thursday
@test isbday(hc_brazil, Dates.Date(2013, 11, 15)) == false # Republic
@test isbday(hc_brazil, Dates.Date(2013, 11, 16)) == false # saturday

@test isbday(hc_brazil, Dates.Date(2013, 12, 24)) == true # tuesday
@test isbday(hc_brazil, Dates.Date(2013, 12, 25)) == false # Christmas
@test isbday(hc_brazil, Dates.Date(2013, 12, 26)) == true # thursday

@test isbday(hc_brazil, Dates.Date(2013, 02, 08)) == true # friday
@test isbday(hc_brazil, Dates.Date(2013, 02, 09)) == false # saturday
@test isbday(hc_brazil, Dates.Date(2013, 02, 10)) == false # sunday
@test isbday(hc_brazil, Dates.Date(2013, 02, 11)) == false # segunda carnaval
@test isbday(hc_brazil, Dates.Date(2013, 02, 12)) == false # terca carnaval
@test isbday(hc_brazil, Dates.Date(2013, 02, 13)) == true # wednesday

@test isbday(hc_brazil, Dates.Date(2013, 03, 28)) == true # thursday
@test isbday(hc_brazil, Dates.Date(2013, 03, 29)) == false # sexta-feira santa
@test isbday(hc_brazil, Dates.Date(2013, 03, 30)) == false # saturday

@test isbday(hc_brazil, Dates.Date(2013, 05, 29)) == true # wednesday
@test isbday(hc_brazil, Dates.Date(2013, 05, 30)) == false # Corpus Christi
@test isbday(hc_brazil, Dates.Date(2013, 05, 31)) == true # friday

# Symbol
@test isbday(:Brazil, Dates.Date(2013, 05, 29)) == true # wednesday
@test isbday(:Brazil, Dates.Date(2013, 05, 30)) == false # Corpus Christi
@test isbday(:Brazil, Dates.Date(2013, 05, 31)) == true # friday

# String
@test isbday("Brazil", Dates.Date(2013, 05, 29)) == true # wednesday
@test isbday("Brazil", Dates.Date(2013, 05, 30)) == false # Corpus Christi
@test isbday("Brazil", Dates.Date(2013, 05, 31)) == true # friday

# BrazilBMF holiday calendar tests
@test isbday(hc_brazil_bmf, Dates.Date(2017, 11, 19)) == false # sunday
@test isbday(hc_brazil_bmf, Dates.Date(2017, 11, 20)) == false # Conciência Negra (segunda)
@test isbday(hc_brazil_bmf, Dates.Date(2017, 11, 21)) == true # Terca

@test isbday(:BrazilBMF, Dates.Date(2013, 05, 29)) == true # wednesday
@test isbday(:BrazilBMF, Dates.Date(2013, 05, 30)) == false # Corpus Christi (National Holiday)
@test isbday(:BrazilBMF, Dates.Date(2013, 05, 31)) == true # friday

# USSettlement HolidayCaledar tests
# Federal Holidays listed on https://www.opm.gov/policy-data-oversight/snow-dismissal-procedures/federal-holidays/#url=2015
@test isbday(hc_usa, Dates.Date(2014, 12, 31)) == true
@test isbday(hc_usa, Dates.Date(2015, 01, 01)) == false # New Year's Day - Thursday
@test isbday(hc_usa, Dates.Date(2015, 01, 02)) == true

@test isbday(hc_usa, Dates.Date(2015, 01, 18)) == false
@test isbday(hc_usa, Dates.Date(2015, 01, 19)) == false # Birthday of Martin Luther King, Jr. - Monday
@test isbday(hc_usa, Dates.Date(2015, 01, 20)) == true

@test isbday(hc_usa, Dates.Date(1982,01,18)) == true # not a holiday for Martin Luther King

@test isbday(hc_usa, Dates.Date(2015, 02, 15)) == false
@test isbday(hc_usa, Dates.Date(2015, 02, 16)) == false # Washington’s Birthday - Monday
@test isbday(hc_usa, Dates.Date(2015, 02, 17)) == true

@test isbday(hc_usa, Dates.Date(2015, 05, 24)) == false
@test isbday(hc_usa, Dates.Date(2015, 05, 25)) == false # Memorial Day - Monday
@test isbday(hc_usa, Dates.Date(2015, 05, 26)) == true

@test isbday(hc_usa, Dates.Date(2015, 07, 02)) == true
@test isbday(hc_usa, Dates.Date(2015, 07, 03)) == false # Independence Day - Friday
@test isbday(hc_usa, Dates.Date(2015, 07, 04)) == false

@test isbday(hc_usa, Dates.Date(2015, 09, 06)) == false
@test isbday(hc_usa, Dates.Date(2015, 09, 07)) == false # Labor Day - Monday
@test isbday(hc_usa, Dates.Date(2015, 09, 08)) == true

@test isbday(hc_usa, Dates.Date(2015, 10, 11)) == false
@test isbday(hc_usa, Dates.Date(2015, 10, 12)) == false # Columbus Day - Monday
@test isbday(hc_usa, Dates.Date(2015, 10, 13)) == true

@test isbday(hc_usa, Dates.Date(2015, 11, 10)) == true
@test isbday(hc_usa, Dates.Date(2015, 11, 11)) == false # Veterans Day - Wednesday
@test isbday(hc_usa, Dates.Date(2015, 11, 12)) == true

@test isbday(hc_usa, Dates.Date(2015, 11, 25)) == true
@test isbday(hc_usa, Dates.Date(2015, 11, 26)) == false # Thanksgiving Day - Thursday
@test isbday(hc_usa, Dates.Date(2015, 11, 27)) == true

@test isbday(hc_usa, Dates.Date(2015, 12, 24)) == true
@test isbday(hc_usa, Dates.Date(2015, 12, 25)) == false # Christmas - Friday
@test isbday(hc_usa, Dates.Date(2015, 12, 26)) == false

@test isbday(hc_usa, Dates.Date(2010, 12, 31)) == false # new years day observed
@test isbday(hc_usa, Dates.Date(2004, 12, 31)) == false # new years day observed

@test isbday(hc_usa, Dates.Date(2013, 03, 28)) == true # thursday
@test isbday(hc_usa, Dates.Date(2013, 03, 29)) == true # good friday
@test isbday(hc_usa, Dates.Date(2013, 03, 30)) == false # saturday

# Symbol
@test isbday(:USSettlement, Dates.Date(2015, 12, 24)) == true
@test isbday(:USSettlement, Dates.Date(2015, 12, 25)) == false # Christmas - Friday
@test isbday(:USSettlement, Dates.Date(2015, 12, 26)) == false

# String
@test isbday("USSettlement", Dates.Date(2015, 12, 24)) == true
@test isbday("USSettlement", Dates.Date(2015, 12, 25)) == false # Christmas - Friday
@test isbday("USSettlement", Dates.Date(2015, 12, 26)) == false

## USNYSE HolidayCalendar tests

@test isbday(hc_usnyse, Dates.Date(2014, 12, 31)) == true
@test isbday(hc_usnyse, Dates.Date(2015, 01, 01)) == false # New Year's Day - Thursday
@test isbday(hc_usnyse, Dates.Date(2015, 01, 02)) == true

@test isbday(hc_usnyse, Dates.Date(2015, 01, 18)) == false
@test isbday(hc_usnyse, Dates.Date(2015, 01, 19)) == false # Birthday of Martin Luther King, Jr. - Monday
@test isbday(hc_usnyse, Dates.Date(2015, 01, 20)) == true

@test isbday(hc_usnyse, Dates.Date(2015, 02, 15)) == false
@test isbday(hc_usnyse, Dates.Date(2015, 02, 16)) == false # Washington’s Birthday - Monday
@test isbday(hc_usnyse, Dates.Date(2015, 02, 17)) == true

@test isbday(hc_usnyse, Dates.Date(2015, 05, 24)) == false
@test isbday(hc_usnyse, Dates.Date(2015, 05, 25)) == false # Memorial Day - Monday
@test isbday(hc_usnyse, Dates.Date(2015, 05, 26)) == true

@test isbday(hc_usnyse, Dates.Date(2015, 07, 02)) == true
@test isbday(hc_usnyse, Dates.Date(2015, 07, 03)) == false # Independence Day - Friday
@test isbday(hc_usnyse, Dates.Date(2015, 07, 04)) == false

@test isbday(hc_usnyse, Dates.Date(2015, 09, 06)) == false
@test isbday(hc_usnyse, Dates.Date(2015, 09, 07)) == false # Labor Day - Monday
@test isbday(hc_usnyse, Dates.Date(2015, 09, 08)) == true

@test isbday(hc_usnyse, Dates.Date(2015, 10, 11)) == false
@test isbday(hc_usnyse, Dates.Date(2015, 10, 12)) == true # Columbus Day - Monday
@test isbday(hc_usnyse, Dates.Date(2015, 10, 13)) == true

@test isbday(hc_usnyse, Dates.Date(2015, 11, 10)) == true
@test isbday(hc_usnyse, Dates.Date(2015, 11, 11)) == true # Veterans Day - Wednesday
@test isbday(hc_usnyse, Dates.Date(2015, 11, 12)) == true

@test isbday(hc_usnyse, Dates.Date(2015, 11, 25)) == true
@test isbday(hc_usnyse, Dates.Date(2015, 11, 26)) == false # Thanksgiving Day - Thursday
@test isbday(hc_usnyse, Dates.Date(2015, 11, 27)) == true

@test isbday(hc_usnyse, Dates.Date(2015, 12, 24)) == true
@test isbday(hc_usnyse, Dates.Date(2015, 12, 25)) == false # Christmas - Friday
@test isbday(hc_usnyse, Dates.Date(2015, 12, 26)) == false

@test isbday(hc_usnyse, Dates.Date(2010, 12, 31)) == true # Friday before new years
@test isbday(hc_usnyse, Dates.Date(2004, 12, 31)) == true # Friday before new years

@test isbday(hc_usnyse, Dates.Date(2013, 03, 28)) == true # thursday
@test isbday(hc_usnyse, Dates.Date(2013, 03, 29)) == false # good friday
@test isbday(hc_usnyse, Dates.Date(2013, 03, 30)) == false # saturday

# Symbol
@test isbday(:USNYSE, Dates.Date(2015, 12, 24)) == true
@test isbday(:USNYSE, Dates.Date(2015, 12, 25)) == false # Christmas - Friday
@test isbday(:USNYSE, Dates.Date(2015, 12, 26)) == false

# String
@test isbday("USNYSE", Dates.Date(2015, 12, 24)) == true
@test isbday("USNYSE", Dates.Date(2015, 12, 25)) == false # Christmas - Friday
@test isbday("USNYSE", Dates.Date(2015, 12, 26)) == false

## USGovernmentBond HolidayCalendar tests
@test isbday(hc_usgovbond, Dates.Date(2014, 12, 31)) == true
@test isbday(hc_usgovbond, Dates.Date(2015, 01, 01)) == false # New Year's Day - Thursday
@test isbday(hc_usgovbond, Dates.Date(2015, 01, 02)) == true

@test isbday(hc_usgovbond, Dates.Date(2015, 01, 18)) == false
@test isbday(hc_usgovbond, Dates.Date(2015, 01, 19)) == false # Birthday of Martin Luther King, Jr. - Monday
@test isbday(hc_usgovbond, Dates.Date(2015, 01, 20)) == true

@test isbday(hc_usgovbond, Dates.Date(2015, 02, 15)) == false
@test isbday(hc_usgovbond, Dates.Date(2015, 02, 16)) == false # Washington’s Birthday - Monday
@test isbday(hc_usgovbond, Dates.Date(2015, 02, 17)) == true

@test isbday(hc_usgovbond, Dates.Date(2015, 05, 24)) == false
@test isbday(hc_usgovbond, Dates.Date(2015, 05, 25)) == false # Memorial Day - Monday
@test isbday(hc_usgovbond, Dates.Date(2015, 05, 26)) == true

@test isbday(hc_usgovbond, Dates.Date(2015, 07, 02)) == true
@test isbday(hc_usgovbond, Dates.Date(2015, 07, 03)) == false # Independence Day - Friday
@test isbday(hc_usgovbond, Dates.Date(2015, 07, 04)) == false

@test isbday(hc_usgovbond, Dates.Date(2015, 09, 06)) == false
@test isbday(hc_usgovbond, Dates.Date(2015, 09, 07)) == false # Labor Day - Monday
@test isbday(hc_usgovbond, Dates.Date(2015, 09, 08)) == true

@test isbday(hc_usgovbond, Dates.Date(2015, 10, 11)) == false
@test isbday(hc_usgovbond, Dates.Date(2015, 10, 12)) == false # Columbus Day - Monday
@test isbday(hc_usgovbond, Dates.Date(2015, 10, 13)) == true

@test isbday(hc_usgovbond, Dates.Date(2015, 11, 10)) == true
@test isbday(hc_usgovbond, Dates.Date(2015, 11, 11)) == false # Veterans Day - Wednesday
@test isbday(hc_usgovbond, Dates.Date(2015, 11, 12)) == true

@test isbday(hc_usgovbond, Dates.Date(2015, 11, 25)) == true
@test isbday(hc_usgovbond, Dates.Date(2015, 11, 26)) == false # Thanksgiving Day - Thursday
@test isbday(hc_usgovbond, Dates.Date(2015, 11, 27)) == true

@test isbday(hc_usgovbond, Dates.Date(2015, 12, 24)) == true
@test isbday(hc_usgovbond, Dates.Date(2015, 12, 25)) == false # Christmas - Friday
@test isbday(hc_usgovbond, Dates.Date(2015, 12, 26)) == false

@test isbday(hc_usgovbond, Dates.Date(2010, 12, 31)) == true # Friday before new years
@test isbday(hc_usgovbond, Dates.Date(2004, 12, 31)) == true # Friday before new years

@test isbday(hc_usgovbond, Dates.Date(2013, 03, 28)) == true # thursday
@test isbday(hc_usgovbond, Dates.Date(2013, 03, 29)) == false # good friday
@test isbday(hc_usgovbond, Dates.Date(2013, 03, 30)) == false # saturday

# Symbol
@test isbday(:USGovernmentBond, Dates.Date(2015, 12, 24)) == true
@test isbday(:USGovernmentBond, Dates.Date(2015, 12, 25)) == false # Christmas - Friday
@test isbday(:USGovernmentBond, Dates.Date(2015, 12, 26)) == false

# String
@test isbday("USGovernmentBond", Dates.Date(2015, 12, 24)) == true
@test isbday("USGovernmentBond", Dates.Date(2015, 12, 25)) == false # Christmas - Friday
@test isbday("USGovernmentBond", Dates.Date(2015, 12, 26)) == false

# TARGET HolidayCalendar tests
@test isbday(targethc, Dates.Date(2017, 12, 24)) == false # Sunday
@test isbday(targethc, Dates.Date(2017, 12, 25)) == false # Christmas - Monday
@test isbday(targethc, Dates.Date(2017, 12, 26)) == false # Day of Goodwill - Tuesday
@test isbday(targethc, Dates.Date(2017, 12, 27)) == true  # Wednesday

@test isbday(targethc, Dates.Date(2017, 04, 16)) == false # Easter Sunday
@test isbday(targethc, Dates.Date(2017, 04, 17)) == false # Easter Monday
@test isbday(targethc, Dates.Date(2017, 04, 18)) == true # Tuesday

@test isbday(targethc, Dates.Date(2001, 12, 31)) == false # End of year
@test isbday(targethc, Dates.Date(2002, 12, 31)) == true # End of year

@test isbday(targethc, Dates.Date(2016, 1, 1)) == false # New Year's Day
@test isbday(targethc, Dates.Date(2017, 5, 1)) == false # Labour Day
@test isbday(targethc, Dates.Date(1998, 5, 1)) == true # Labour Day before 2000

# Symbol
@test isbday(:TARGET, Dates.Date(2017, 04, 16)) == false # Easter Sunday
@test isbday(:TARGET, Dates.Date(2017, 04, 17)) == false # Easter Monday
@test isbday(:TARGET, Dates.Date(2017, 04, 18)) == true # Tuesday

# String
@test isbday("TARGET", Dates.Date(2017, 04, 16)) == false # Easter Sunday
@test isbday("TARGET", Dates.Date(2017, 04, 17)) == false # Easter Monday
@test isbday("TARGET", Dates.Date(2017, 04, 18)) == true # Tuesday

# TARGET synonyms
@test isbday("TARGET2", Dates.Date(2017, 04, 18)) == isbday("TARGET", Dates.Date(2017, 04, 18))
@test isbday("EuroZone", Dates.Date(2017, 04, 18)) == isbday("TARGET", Dates.Date(2017, 04, 18))

## UKSettlement HolidayCalendar tests
@test isbday(hc_uk, Dates.Date(2014, 12, 31)) == true
@test isbday(hc_uk, Dates.Date(2015, 01, 01)) == false # New Year's Day Thursday
@test isbday(hc_uk, Dates.Date(2015, 01, 02)) == true

@test isbday(hc_uk, Dates.Date(2015, 08, 30)) == false
@test isbday(hc_uk, Dates.Date(2015, 08, 31)) == false # Monday   Summer bank holiday
@test isbday(hc_uk, Dates.Date(2015, 09, 01)) == true

@test isbday(hc_uk, Dates.Date(2015, 12, 24)) == true
@test isbday(hc_uk, Dates.Date(2015, 12, 25)) == false # 25 December  Friday  Christmas Day
@test isbday(hc_uk, Dates.Date(2015, 12, 26)) == false
@test isbday(hc_uk, Dates.Date(2015, 12, 27)) == false
@test isbday(hc_uk, Dates.Date(2015, 12, 28)) == false # Monday   Boxing Day (substitute day)
@test isbday(hc_uk, Dates.Date(2015, 12, 29)) == true

@test isbday(hc_uk, Dates.Date(2016, 03, 24)) == true
@test isbday(hc_uk, Dates.Date(2016, 03, 25)) == false # 25 March Friday  Good Friday
@test isbday(hc_uk, Dates.Date(2016, 03, 26)) == false
@test isbday(hc_uk, Dates.Date(2016, 03, 27)) == false
@test isbday(hc_uk, Dates.Date(2016, 03, 28)) == false # 28 March Monday  Easter Monday
@test isbday(hc_uk, Dates.Date(2016, 03, 29)) == true

@test isbday(hc_uk, Dates.Date(2016, 05, 01)) == false
@test isbday(hc_uk, Dates.Date(2016, 05, 02)) == false # 2 May    Monday  Early May bank holiday
@test isbday(hc_uk, Dates.Date(2016, 05, 03)) == true

@test isbday(hc_uk, Dates.Date(2016, 05, 29)) == false
@test isbday(hc_uk, Dates.Date(2016, 05, 30)) == false # 30 May   Monday  Spring bank holiday
@test isbday(hc_uk, Dates.Date(2016, 05, 31)) == true

@test isbday(hc_uk, Dates.Date(2016, 08, 28)) == false
@test isbday(hc_uk, Dates.Date(2016, 08, 29)) == false # 29 August    Monday  Summer bank holiday
@test isbday(hc_uk, Dates.Date(2016, 08, 30)) == true

@test isbday(hc_uk, Dates.Date(2016, 12, 23)) == true
@test isbday(hc_uk, Dates.Date(2016, 12, 24)) == false
@test isbday(hc_uk, Dates.Date(2016, 12, 25)) == false
@test isbday(hc_uk, Dates.Date(2016, 12, 26)) == false # 26 December  Monday  Boxing Day
@test isbday(hc_uk, Dates.Date(2016, 12, 27)) == false # 27 December  Tuesday Christmas Day (substitute day)
@test isbday(hc_uk, Dates.Date(2016, 12, 28)) == true

# 2012 UK Holidays
@test isbday(hc_uk, Dates.Date(2011, 12, 30)) == true
@test isbday(hc_uk, Dates.Date(2011, 12, 31)) == false
@test isbday(hc_uk, Dates.Date(2012, 01, 01)) == false
@test isbday(hc_uk, Dates.Date(2012, 01, 02)) == false # 2 January    Monday  New Year’s Day (substitute day)
@test isbday(hc_uk, Dates.Date(2012, 01, 03)) == true

@test isbday(hc_uk, Dates.Date(2012, 04, 05)) == true
@test isbday(hc_uk, Dates.Date(2012, 04, 06)) == false # 6 April  Friday  Good Friday
@test isbday(hc_uk, Dates.Date(2012, 04, 07)) == false
@test isbday(hc_uk, Dates.Date(2012, 04, 08)) == false
@test isbday(hc_uk, Dates.Date(2012, 04, 09)) == false # 9 April  Monday  Easter Monday
@test isbday(hc_uk, Dates.Date(2012, 04, 10)) == true

@test isbday(hc_uk, Dates.Date(2012, 05, 06)) == false
@test isbday(hc_uk, Dates.Date(2012, 05, 07)) == false # 7 May    Monday  Early May bank holiday
@test isbday(hc_uk, Dates.Date(2012, 05, 08)) == true

@test isbday(hc_uk, Dates.Date(2012, 06, 01)) == true
@test isbday(hc_uk, Dates.Date(2012, 06, 02)) == false
@test isbday(hc_uk, Dates.Date(2012, 06, 03)) == false
@test isbday(hc_uk, Dates.Date(2012, 06, 04)) == false # 4 June   Monday  Spring bank holiday (substitute day)
@test isbday(hc_uk, Dates.Date(2012, 06, 05)) == false # 5 June   Tuesday Queen’s Diamond Jubilee (extra bank holiday)
@test isbday(hc_uk, Dates.Date(2012, 06, 06)) == true

@test isbday(hc_uk, Dates.Date(2011, 04, 29)) == false # wedding

@test isbday(hc_uk, Dates.Date(2012, 08, 26)) == false
@test isbday(hc_uk, Dates.Date(2012, 08, 27)) == false # 27 August    Monday  Summer bank holiday
@test isbday(hc_uk, Dates.Date(2012, 08, 28)) == true

@test isbday(hc_uk, Dates.Date(2012, 12, 24)) == true
@test isbday(hc_uk, Dates.Date(2012, 12, 25)) == false # 25 December  Tuesday Christmas Day
@test isbday(hc_uk, Dates.Date(2012, 12, 26)) == false # 26 December  Wednesday   Boxing Day
@test isbday(hc_uk, Dates.Date(2012, 12, 27)) == true

# 1999 UK holidays
@test isbday(hc_uk, Dates.Date(1999, 12, 26)) == false # Sunday
@test isbday(hc_uk, Dates.Date(1999, 12, 27)) == false # Christmas observed
@test isbday(hc_uk, Dates.Date(1999, 12, 28)) == false # Boxing observed
@test isbday(hc_uk, Dates.Date(1999, 12, 29)) == true
@test isbday(hc_uk, Dates.Date(1999, 12, 30)) == true
@test isbday(hc_uk, Dates.Date(1999, 12, 31)) == false

@test tobday(hc_brazil, Dates.Date(2013, 02, 08)) == Dates.Date(2013, 02, 08) # regular friday
@test tobday(hc_brazil, Dates.Date(2013, 02, 09)) == Dates.Date(2013, 02, 13) # after carnaval
@test tobday(hc_brazil, Dates.Date(2013, 02, 09); forward = true) == Dates.Date(2013, 02, 13) # after carnaval
@test tobday(hc_brazil, Dates.Date(2013, 02, 13); forward = false) == Dates.Date(2013, 02, 13) # after carnaval
@test tobday(hc_brazil, Dates.Date(2013, 02, 12); forward = false) == Dates.Date(2013, 02, 08) # before carnaval

@test tobday(:Brazil, Dates.Date(2013, 02, 08)) == Dates.Date(2013, 02, 08) # regular friday
@test tobday(:Brazil, Dates.Date(2013, 02, 09)) == Dates.Date(2013, 02, 13) # after carnaval
@test tobday(:Brazil, Dates.Date(2013, 02, 09); forward = true) == Dates.Date(2013, 02, 13) # after carnaval
@test tobday(:Brazil, Dates.Date(2013, 02, 13); forward = false) == Dates.Date(2013, 02, 13) # after carnaval
@test tobday(:Brazil, Dates.Date(2013, 02, 12); forward = false) == Dates.Date(2013, 02, 08) # before carnaval

@test tobday("Brazil", Dates.Date(2013, 02, 08)) == Dates.Date(2013, 02, 08) # regular friday
@test tobday("Brazil", Dates.Date(2013, 02, 09)) == Dates.Date(2013, 02, 13) # after carnaval
@test tobday("Brazil", Dates.Date(2013, 02, 09); forward = true) == Dates.Date(2013, 02, 13) # after carnaval
@test tobday("Brazil", Dates.Date(2013, 02, 13); forward = false) == Dates.Date(2013, 02, 13) # after carnaval
@test tobday("Brazil", Dates.Date(2013, 02, 12); forward = false) == Dates.Date(2013, 02, 08) # before carnaval

@test advancebdays(hc_brazil, Dates.Date(2013, 02, 06), 0) == Dates.Date(2013, 02, 06) # regular wednesday
@test advancebdays(hc_brazil, Dates.Date(2013, 02, 06), 1) == Dates.Date(2013, 02, 07) # regular thursday
@test advancebdays(hc_brazil, Dates.Date(2013, 02, 07), -1) == Dates.Date(2013, 02, 06) # regular thursday
@test advancebdays(hc_brazil, Dates.Date(2013, 02, 06), 2) == Dates.Date(2013, 02, 08) # regular friday
@test advancebdays(hc_brazil, Dates.Date(2013, 02, 06), 3) == Dates.Date(2013, 02, 13) # after carnaval wednesday
@test advancebdays(hc_brazil, Dates.Date(2013, 02, 06), 4) == Dates.Date(2013, 02, 14) # after carnaval thursday
@test advancebdays(hc_brazil, Dates.Date(2013, 02, 14), -4) == Dates.Date(2013, 02, 06) # after carnaval thursday

@test advancebdays(:Brazil, Dates.Date(2013, 02, 06), 0) == Dates.Date(2013, 02, 06) # regular wednesday
@test advancebdays(:Brazil, Dates.Date(2013, 02, 06), 1) == Dates.Date(2013, 02, 07) # regular thursday
@test advancebdays(:Brazil, Dates.Date(2013, 02, 06), 2) == Dates.Date(2013, 02, 08) # regular friday
@test advancebdays(:Brazil, Dates.Date(2013, 02, 06), 3) == Dates.Date(2013, 02, 13) # after carnaval wednesday
@test advancebdays(:Brazil, Dates.Date(2013, 02, 06), 4) == Dates.Date(2013, 02, 14) # after carnaval thursday

@test advancebdays("Brazil", Dates.Date(2013, 02, 06), 0) == Dates.Date(2013, 02, 06) # regular wednesday
@test advancebdays("Brazil", Dates.Date(2013, 02, 06), 1) == Dates.Date(2013, 02, 07) # regular thursday
@test advancebdays("Brazil", Dates.Date(2013, 02, 06), 2) == Dates.Date(2013, 02, 08) # regular friday
@test advancebdays("Brazil", Dates.Date(2013, 02, 06), 3) == Dates.Date(2013, 02, 13) # after carnaval wednesday
@test advancebdays("Brazil", Dates.Date(2013, 02, 06), 4) == Dates.Date(2013, 02, 14) # after carnaval thursday

@test bdays(hc_brazil, Dates.Date(2013, 02, 06), Dates.Date(2013, 02, 06)) == Dates.Dates.Day(0)
@test bdays(hc_brazil, Dates.Date(2013, 02, 06), Dates.Date(2013, 02, 07)) == Dates.Dates.Day(1)
@test bdays(hc_brazil, Dates.Date(2013, 02, 07), Dates.Date(2013, 02, 06)).value == -1
@test bdays(hc_brazil, Dates.Date(2013, 02, 06), Dates.Date(2013, 02, 08)).value == 2
@test bdays(hc_brazil, Dates.Date(2013, 02, 08), Dates.Date(2013, 02, 06)).value == -2
@test bdays(hc_brazil, Dates.Date(2013, 02, 06), Dates.Date(2013, 02, 09)).value == 3
@test bdays(hc_brazil, Dates.Date(2013, 02, 06), Dates.Date(2013, 02, 10)).value == 3
@test bdays(hc_brazil, Dates.Date(2013, 02, 06), Dates.Date(2013, 02, 11)).value == 3
@test bdays(hc_brazil, Dates.Date(2013, 02, 06), Dates.Date(2013, 02, 12)).value == 3
@test bdays(hc_brazil, Dates.Date(2013, 02, 06), Dates.Date(2013, 02, 13)).value == 3
@test bdays(hc_brazil, Dates.Date(2013, 02, 06), Dates.Date(2013, 02, 14)).value == 4
@test bdays(hc_brazil, Dates.Date(2013, 02, 14), Dates.Date(2013, 02, 06)).value == -4

@test bdayscount(hc_brazil, Dates.Date(2013, 02, 06), Dates.Date(2013, 02, 06)) == 0
@test bdayscount(hc_brazil, Dates.Date(2013, 02, 06), Dates.Date(2013, 02, 07)) == 1
@test bdayscount(hc_brazil, Dates.Date(2013, 02, 07), Dates.Date(2013, 02, 06)) == -1
@test bdayscount(hc_brazil, Dates.Date(2013, 02, 06), Dates.Date(2013, 02, 08)) == 2
@test bdayscount(hc_brazil, Dates.Date(2013, 02, 08), Dates.Date(2013, 02, 06)) == -2
@test bdayscount(hc_brazil, Dates.Date(2013, 02, 06), Dates.Date(2013, 02, 09)) == 3
@test bdayscount(hc_brazil, Dates.Date(2013, 02, 06), Dates.Date(2013, 02, 10)) == 3
@test bdayscount(hc_brazil, Dates.Date(2013, 02, 06), Dates.Date(2013, 02, 11)) == 3
@test bdayscount(hc_brazil, Dates.Date(2013, 02, 06), Dates.Date(2013, 02, 12)) == 3
@test bdayscount(hc_brazil, Dates.Date(2013, 02, 06), Dates.Date(2013, 02, 13)) == 3
@test bdayscount(hc_brazil, Dates.Date(2013, 02, 06), Dates.Date(2013, 02, 14)) == 4
@test bdayscount(hc_brazil, Dates.Date(2013, 02, 14), Dates.Date(2013, 02, 06)) == -4

# Canada

tsxdates16 = [
    Dates.Date(2016, 1, 1),
    Dates.Date(2016, 2, 15),
    Dates.Date(2016, 3, 25),
    Dates.Date(2016, 5, 23),
    Dates.Date(2016, 7, 1),
    Dates.Date(2016, 8, 1),
    Dates.Date(2016, 9, 5),
    Dates.Date(2016, 10, 10),
    Dates.Date(2016, 12, 26),
    Dates.Date(2016, 12, 27)
]

alldates16itr = Dates.Date(2016,1,1):Dates.Day(1):Dates.Date(2016, 12,31)
for i in alldates16itr
    if i ∈ tsxdates16
        @test isholiday(hc_canadatsx, i) == true
    else
        @test isholiday(hc_canadatsx, i) == false
    end
end

tsxdates17 = [
    Dates.Date(2017, 1, 2),
    Dates.Date(2017, 2, 20),
    Dates.Date(2017, 4, 14),
    Dates.Date(2017, 5, 22),
    Dates.Date(2017, 7, 3),
    Dates.Date(2017, 8, 7),
    Dates.Date(2017, 9, 4),
    Dates.Date(2017, 10, 9),
    Dates.Date(2017, 12, 25),
    Dates.Date(2017, 12, 26)
]

alldates17itr = Dates.Date(2017,1,1):Dates.Day(1):Dates.Date(2017, 12,31)
for i in alldates17itr
    if i ∈ tsxdates17
        @test isholiday(hc_canadatsx, i) == true
    else
        @test isholiday(hc_canadatsx, i) == false
    end
end

canadaDates16 = [
    Dates.Date(2016, 1, 1),
    Dates.Date(2016, 2, 15),
    Dates.Date(2016, 3, 25),
    Dates.Date(2016, 5, 23),
    Dates.Date(2016, 7, 1),
    Dates.Date(2016, 8, 1),
    Dates.Date(2016, 9, 5),
    Dates.Date(2016, 10, 10),
    Dates.Date(2016, 11, 11),
    Dates.Date(2016, 12, 26),
    Dates.Date(2016, 12, 27)
]

for i in alldates16itr
    if i ∈ canadaDates16
        @test isholiday(hc_canada, i) == true
    else
        @test isholiday(hc_canada, i) == false
    end
end

# Issue #8
@test isbday(hc_canada, Dates.Date(2011,1,3)) == true
@test isbday(hc_canadatsx, Dates.Date(2008, 2, 18)) == false

# Australian Stock Exchange (ASX)
christmasday = Dates.Date(2018,12, 25)
boxingday    = Dates.Date(2018,12, 26)
asxdates18 = Set([
    Dates.Date(2018, 1,  1),  # New year's day
    Dates.Date(2018, 1, 26),  # Australia Day
    Dates.Date(2018, 3, 30),  # Good Friday
    Dates.Date(2018, 4,  2),  # Easter Monday
    Dates.Date(2018, 4, 25),  # ANZAC Day
    Dates.Date(2018, 6, 11),  # Queen's Birthday holiday
    christmasday,
    boxingday
])
for dt in Dates.Date(2018,1,1):Dates.Day(1):Dates.Date(2018,12,31)
    if in(dt, asxdates18)
        dt != boxingday && @test isholiday(hc_australiaasx, dt-Dates.Day(1)) == false
        @test isholiday(hc_australiaasx, dt) == true
        dt != christmasday && @test isholiday(hc_australiaasx, dt+Dates.Day(1)) == false
    else
        @test isholiday(hc_australiaasx, dt) == false
    end
end

# Australian states and territories
@test_throws MethodError BusinessDays.Australia()         # State/territory not specified
@test_throws AssertionError BusinessDays.Australia(:XXX)  # Invalid state/territory

# The Australian Capital Territory (ACT)
actdates18 = Set([
    Dates.Date(2018,  1,  1),  # New year's day
    Dates.Date(2018,  1, 26),  # Australia Day
    Dates.Date(2018,  3, 12),  # Canberra Day
    Dates.Date(2018,  3, 30),  # Good Friday
    Dates.Date(2018,  3, 31),  # Easter Saturday
    Dates.Date(2018,  4,  1),  # Easter Sunday
    Dates.Date(2018,  4,  2),  # Easter Monday
    Dates.Date(2018,  4, 25),  # ANZAC Day
    Dates.Date(2018,  5, 28),  # Reconciliation Day
    Dates.Date(2018,  6, 11),  # Queen's Birthday holiday
    Dates.Date(2018, 10,  1),  # Labour Day
    christmasday,
    boxingday
])
for dt in Dates.Date(2018,1,1):Dates.Day(1):Dates.Date(2018,12,31)
    if in(dt, actdates18)
        @test isholiday(hc_australiaact, dt) == true
    else
        @test isholiday(hc_australiaact, dt) == false
    end
end

# The state of New South Wales (NSW), Australia
nswdates18 = Set([
    Dates.Date(2018,  1,  1),  # New year's day
    Dates.Date(2018,  1, 26),  # Australia Day
    Dates.Date(2018,  3, 30),  # Good Friday
    Dates.Date(2018,  3, 31),  # Easter Saturday
    Dates.Date(2018,  4,  1),  # Easter Sunday
    Dates.Date(2018,  4,  2),  # Easter Monday
    Dates.Date(2018,  4, 25),  # ANZAC Day
    Dates.Date(2018,  6, 11),  # Queen's Birthday holiday
    Dates.Date(2018,  8,  6),  # Bank Holiday
    Dates.Date(2018, 10,  1),  # Labour Day
    christmasday,
    boxingday
])
for dt in Dates.Date(2018,1,1):Dates.Day(1):Dates.Date(2018,12,31)
    if in(dt, nswdates18)
        @test isholiday(hc_australiansw, dt) == true
    else
        @test isholiday(hc_australiansw, dt) == false
    end
end

# The Northern Territory (NT), Australia
ntdates18 = Set([
    Dates.Date(2018,  1,  1),  # New year's day
    Dates.Date(2018,  1, 26),  # Australia Day
    Dates.Date(2018,  3, 30),  # Good Friday
    Dates.Date(2018,  3, 31),  # Easter Saturday
    Dates.Date(2018,  4,  2),  # Easter Monday
    Dates.Date(2018,  4, 25),  # ANZAC Day
    Dates.Date(2018,  5,  7),  # May Day
    Dates.Date(2018,  6, 11),  # Queen's Birthday holiday
    Dates.Date(2018,  8,  6),  # Picnic Day
    christmasday,
    boxingday
])
for dt in Dates.Date(2018,1,1):Dates.Day(1):Dates.Date(2018,12,31)
    if in(dt, ntdates18)
        @test isholiday(hc_australiant, dt) == true
    else
        @test isholiday(hc_australiant, dt) == false
    end
end

# The state of Queensland (QLD), Australia
qlddates18 = Set([
    Dates.Date(2018,  1,  1),  # New year's day
    Dates.Date(2018,  1, 26),  # Australia Day
    Dates.Date(2018,  3, 30),  # Good Friday
    Dates.Date(2018,  3, 31),  # Easter Saturday
    Dates.Date(2018,  4,  1),  # Easter Sunday
    Dates.Date(2018,  4,  2),  # Easter Monday
    Dates.Date(2018,  4, 25),  # ANZAC Day
    Dates.Date(2018,  5,  7),  # Labour Day
    Dates.Date(2018,  8, 15),  # Royal Brisbane Show (brisbane area only)
    Dates.Date(2018, 10,  1),  # Queen's Birthday holiday
    christmasday,
    boxingday
])
for dt in Dates.Date(2018,1,1):Dates.Day(1):Dates.Date(2018,12,31)
    if in(dt, qlddates18)
        @test isholiday(hc_australiaqld, dt) == true
    else
        @test isholiday(hc_australiaqld, dt) == false
    end
end
@test isholiday(hc_australiaqld, Dates.Date(2013, 6, 10)) == true

# The state of South Australia (SA)
sadates18 = Set([
    Dates.Date(2018,  1,  1),  # New year's day
    Dates.Date(2018,  1, 26),  # Australia Day
    Dates.Date(2018,  3, 12),  # March public Holiday
    Dates.Date(2018,  3, 30),  # Good Friday
    Dates.Date(2018,  3, 31),  # Easter Saturday
    Dates.Date(2018,  4,  2),  # Easter Monday
    Dates.Date(2018,  4, 25),  # ANZAC Day
    Dates.Date(2018,  6, 11),  # Queen's Birthday holiday
    Dates.Date(2018, 10,  1),  # Labour Day
    christmasday,
    boxingday
])
for dt in Dates.Date(2018,1,1):Dates.Day(1):Dates.Date(2018,12,31)
    if in(dt, sadates18)
        @test isholiday(hc_australiasa, dt) == true
    else
        @test isholiday(hc_australiasa, dt) == false
    end
end

# The state of Tasmania (TAS), Australia
tasdates18 = Set([
    Dates.Date(2018,  1,  1),  # New year's day
    Dates.Date(2018,  1, 26),  # Australia Day
    Dates.Date(2018,  2, 12),  # Royal Hobart Regatta
    Dates.Date(2018,  3, 12),  # Labour Day
    Dates.Date(2018,  3, 30),  # Good Friday
    Dates.Date(2018,  4,  2),  # Easter Monday
    Dates.Date(2018,  4, 25),  # ANZAC Day
    Dates.Date(2018,  6, 11),  # Queen's Birthday holiday
    Dates.Date(2018, 11,  5),  # Recreation Day
    christmasday,
    boxingday
])
for dt in Dates.Date(2018,1,1):Dates.Day(1):Dates.Date(2018,12,31)
    if in(dt, tasdates18)
        @test isholiday(hc_australiatas, dt) == true
    else
        @test isholiday(hc_australiatas, dt) == false
    end
end

# The state of Western Australia (WA)
wadates18 = Set([
    Dates.Date(2018,  1,  1),  # New year's day
    Dates.Date(2018,  1, 26),  # Australia Day
    Dates.Date(2018,  3,  5),  # Labour Day
    Dates.Date(2018,  3, 30),  # Good Friday
    Dates.Date(2018,  4,  2),  # Easter Monday
    Dates.Date(2018,  4, 25),  # ANZAC Day
    Dates.Date(2018,  6,  4),  # Western Australia Day
    Dates.Date(2018,  9, 24),  # Queen's Birthday holiday
    christmasday,
    boxingday
])
for dt in Dates.Date(2018,1,1):Dates.Day(1):Dates.Date(2018,12,31)
    if in(dt, wadates18)
        @test isholiday(hc_australiawa, dt) == true
    else
        @test isholiday(hc_australiawa, dt) == false
    end
end
@test isholiday(hc_australiawa, Dates.Date(2011, 10, 28)) == true
@test isholiday(hc_australiawa, Dates.Date(2012, 10,  1)) == true

# The state of Victoria (VIC), Australia
vicdates18 = Set([
    Dates.Date(2018,  1,  1),  # New year's day
    Dates.Date(2018,  1, 26),  # Australia Day
    Dates.Date(2018,  3, 12),  # Labour Day
    Dates.Date(2018,  3, 30),  # Good Friday
    Dates.Date(2018,  3, 31),  # Easter Saturday
    Dates.Date(2018,  4,  1),  # Easter Sunday
    Dates.Date(2018,  4,  2),  # Easter Monday
    Dates.Date(2018,  4, 25),  # ANZAC Day
    Dates.Date(2018,  6, 11),  # Queen's Birthday holiday
    Dates.Date(2018,  9, 28),  # AFL Grand Final Eve holiday
    Dates.Date(2018, 11,  6),  # Melbourne Cup holiday
    christmasday,
    boxingday
])
for dt in Dates.Date(2018,1,1):Dates.Day(1):Dates.Date(2018,12,31)
    if in(dt, vicdates18)
        @test isholiday(hc_australiavic, dt) == true
    else
        @test isholiday(hc_australiavic, dt) == false
    end
end

# dates are treated per value
d0 = Dates.Date(2013, 02, 06)
d1 = Dates.Date(2013, 02, 14)
@test bdays(hc_brazil, d0, d1).value == 4
@test bdayscount(hc_brazil, d0, d1) == 4
@test d0 == Dates.Date(2013, 02, 06) # d0 is changed inside bdays function, but outer-scope value remains the same
@test d1 == Dates.Date(2013, 02, 14)

d0 = Dates.Date(2015, 06, 29) ; d2 = Dates.Date(2100, 12, 20)
@test bdays(hc_brazil, d0, d2).value == 21471
@test bdayscount(hc_brazil, d0, d2) == 21471

# Tests for Composite Calendar
@test isholiday(hc_composite_BR_USA, Dates.Date(2012,9,3)) # US Labor Day
@test isholiday(hc_composite_BR_USA, Dates.Date(2012,9,7)) # BR Independence Day
@test bdayscount(hc_composite_BR_USA, Dates.Date(2012,8,31), Dates.Date(2012,9,10)) == 4 # 3/sep labor day US, 7/sep Indep day BR
@test bdays(hc_composite_BR_USA, Dates.Date(2012,8,31), Dates.Date(2012,9,10)) == Dates.Day(4) # 3/sep labor day US, 7/sep Indep day BR

println("Timing composite calendar bdays calculation")
@time bdays(hc_composite_BR_USA, Dates.Date(2012,8,31), Dates.Date(2012,9,10))

println("Timing single bdays calculation")
@time bdays(hc_brazil, d0, d2)

println("Timing 100 bdays calculations")
@time for i in 1:100 bdays(hc_brazil, d0, d2) end

dInicio = Dates.Date(1950, 01, 01) ; dFim = Dates.Date(2100, 12, 20)

if !usecache
    println("Timing cache creation")
    @time x = BusinessDays._create_bdays_cache_arrays(hc_brazil, dInicio, dFim)
end

if usecache
    println("a million...")
    @time for i in 1:1000000 bdays(hc_brazil, d0, d2) end
end

# Vector functions
d0 = Dates.Date(2000,01,04)
d1 = Dates.Date(2020,01,04)

d1vec = collect(d0:Dates.Day(1):d1)
d0vec = fill(d0, length(d1vec))

r = bdays(hc_brazil, d0vec, d1vec)
b = isbday(hc_brazil, d0vec)
b2 = isbday(:Brazil, d0vec)
b3 = isbday("Brazil", d0vec)
@test tobday([hc_brazil, hc_usa], [Dates.Date(2015,11,11), Dates.Date(2015,11,11)]) == [Dates.Date(2015,11,11), Dates.Date(2015,11,12)]
@test tobday([:Brazil, :USSettlement], [Dates.Date(2015,11,11), Dates.Date(2015,11,11)]) == [Dates.Date(2015,11,11), Dates.Date(2015,11,12)]
@test tobday(["Brazil", "USSettlement"], [Dates.Date(2015,11,11), Dates.Date(2015,11,11)]) == [Dates.Date(2015,11,11), Dates.Date(2015,11,12)]

# Vector with different sizes
@test_throws AssertionError bdays(hc_brazil, fill(d0, length(d1vec)+1), d1vec)
@test_throws AssertionError bdays([hc_brazil, hc_usa], [Dates.Date(2015,11,11)], [Dates.Date(2015,11,11),Dates.Date(2015,11,11)])
@test_throws AssertionError tobday([hc_brazil, hc_usa], fill(d0, 3))
@test_throws AssertionError isbday( [hc_brazil, hc_usa, hc_uk], [Dates.Date(2015,01,01), Dates.Date(2015,01,01)])

println("Timing vectorized functions (vector length $(length(d0vec)))")
@time bdays(hc_brazil, d0vec, d1vec)
@time bdays(:Brazil, d0vec, d1vec)
@time bdays("Brazil", d0vec, d1vec)
@time isbday(hc_brazil, d0vec)
@time isbday(:Brazil, d0vec)
@time isbday("Brazil", d0vec)

d2001 = collect(Dates.Date(2001,01,01):Dates.Day(1):Dates.Date(2001,01,15))

@test isweekend(d2001) == [ false, false, false, false, false, true, true, false, false, false, false, false, true, true, false]
@test tobday(hc_brazil, d2001; forward=true) == [ Dates.Date(2001,01,02), Dates.Date(2001,01,02), Dates.Date(2001,01,03), Dates.Date(2001,01,04), Dates.Date(2001,01,05), Dates.Date(2001,01,08), Dates.Date(2001,01,08), Dates.Date(2001,01,08), Dates.Date(2001,01,09), Dates.Date(2001,01,10), Dates.Date(2001,01,11), Dates.Date(2001,01,12), Dates.Date(2001,01,15), Dates.Date(2001,01,15), Dates.Date(2001,01,15)]
@test tobday(hc_brazil, d2001; forward=false) == [ Dates.Date(2000,12,29), Dates.Date(2001,01,02), Dates.Date(2001,01,03), Dates.Date(2001,01,04), Dates.Date(2001,01,05), Dates.Date(2001,01,05), Dates.Date(2001,01,05), Dates.Date(2001,01,08), Dates.Date(2001,01,09), Dates.Date(2001,01,10), Dates.Date(2001,01,11), Dates.Date(2001,01,12), Dates.Date(2001,01,12), Dates.Date(2001,01,12), Dates.Date(2001,01,15)]

@test tobday(:Brazil, d2001; forward=true) == [ Dates.Date(2001,01,02), Dates.Date(2001,01,02), Dates.Date(2001,01,03), Dates.Date(2001,01,04), Dates.Date(2001,01,05), Dates.Date(2001,01,08), Dates.Date(2001,01,08), Dates.Date(2001,01,08), Dates.Date(2001,01,09), Dates.Date(2001,01,10), Dates.Date(2001,01,11), Dates.Date(2001,01,12), Dates.Date(2001,01,15), Dates.Date(2001,01,15), Dates.Date(2001,01,15)]
@test tobday("Brazil", d2001; forward=false) == [ Dates.Date(2000,12,29), Dates.Date(2001,01,02), Dates.Date(2001,01,03), Dates.Date(2001,01,04), Dates.Date(2001,01,05), Dates.Date(2001,01,05), Dates.Date(2001,01,05), Dates.Date(2001,01,08), Dates.Date(2001,01,09), Dates.Date(2001,01,10), Dates.Date(2001,01,11), Dates.Date(2001,01,12), Dates.Date(2001,01,12), Dates.Date(2001,01,12), Dates.Date(2001,01,15)]

@test bdays([hc_brazil, hc_usa], [Dates.Date(2012,8,31), Dates.Date(2012,8,31)], [Dates.Date(2012,9,10), Dates.Date(2012,9,10)]) == [Dates.Day(5), Dates.Day(5)] # 1/sep labor day US, 7/sep Indep day BR
@test bdayscount([hc_brazil, hc_usa], [Dates.Date(2012,8,31), Dates.Date(2012,8,31)], [Dates.Date(2012,9,10), Dates.Date(2012,9,10)]) == [5, 5] # 1/sep labor day US, 7/sep Indep day BR
@test isbday([hc_brazil, hc_usa], [Dates.Date(2012, 09, 07), Dates.Date(2012, 09, 03)]) == [false, false] # 1/sep labor day US, 7/sep Indep day BR
@test advancebdays(hc_brazil, Dates.Date(2015,9,1), [0, 1, 3, 4, 5]) == [Dates.Date(2015,9,1),Dates.Date(2015,9,2),Dates.Date(2015,9,4),Dates.Date(2015,9,8),Dates.Date(2015,9,9)]
@test advancebdays(hc_brazil, Dates.Date(2015,9,1), 0:1:5) == [Dates.Date(2015,9,1),Dates.Date(2015,9,2),Dates.Date(2015,9,3),Dates.Date(2015,9,4),Dates.Date(2015,9,8),Dates.Date(2015,9,9)]
@test listholidays(hc_brazil, Dates.Date(2016,1,1), Dates.Date(2016,5,30)) == [Dates.Date(2016,1,1),Dates.Date(2016,2,8),Dates.Date(2016,2,9),Dates.Date(2016,3,25),Dates.Date(2016,4,21),Dates.Date(2016,5,1),Dates.Date(2016,5,26)]

@test bdays([:Brazil, :USSettlement], [Dates.Date(2012,8,31), Dates.Date(2012,8,31)], [Dates.Date(2012,9,10), Dates.Date(2012,9,10)]) == [Dates.Day(5), Dates.Day(5)] # 1/sep labor day US, 7/sep Indep day BR
@test bdayscount([:Brazil, :USSettlement], [Dates.Date(2012,8,31), Dates.Date(2012,8,31)], [Dates.Date(2012,9,10), Dates.Date(2012,9,10)]) == [5, 5] # 1/sep labor day US, 7/sep Indep day BR
@test isbday([:Brazil, :USSettlement], [Dates.Date(2012, 09, 07), Dates.Date(2012, 09, 03)]) == [false, false] # 1/sep labor day US, 7/sep Indep day BR
@test advancebdays(:Brazil, Dates.Date(2015,9,1), [0, 1, 3, 4, 5]) == [Dates.Date(2015,9,1),Dates.Date(2015,9,2),Dates.Date(2015,9,4),Dates.Date(2015,9,8),Dates.Date(2015,9,9)]
@test advancebdays(:Brazil, Dates.Date(2015,9,1), 0:5) == [Dates.Date(2015,9,1),Dates.Date(2015,9,2),Dates.Date(2015,9,3),Dates.Date(2015,9,4),Dates.Date(2015,9,8),Dates.Date(2015,9,9)]
@test listholidays(:Brazil, Dates.Date(2016,1,1), Dates.Date(2016,5,30)) == [Dates.Date(2016,1,1),Dates.Date(2016,2,8),Dates.Date(2016,2,9),Dates.Date(2016,3,25),Dates.Date(2016,4,21),Dates.Date(2016,5,1),Dates.Date(2016,5,26)]

@test bdays(["Brazil", "USSettlement"], [Dates.Date(2012,8,31), Dates.Date(2012,8,31)], [Dates.Date(2012,9,10), Dates.Date(2012,9,10)]) == [Dates.Day(5), Dates.Day(5)] # 1/sep labor day US, 7/sep Indep day BR
@test bdayscount(["Brazil", "USSettlement"], [Dates.Date(2012,8,31), Dates.Date(2012,8,31)], [Dates.Date(2012,9,10), Dates.Date(2012,9,10)]) == [5, 5] # 1/sep labor day US, 7/sep Indep day BR
@test isbday(["Brazil", "USSettlement"], [Dates.Date(2012, 09, 07), Dates.Date(2012, 09, 03)]) == [false, false] # 1/sep labor day US, 7/sep Indep day BR
@test advancebdays("Brazil", Dates.Date(2015,9,1), [0, 1, 3, 4, 5]) == [Dates.Date(2015,9,1),Dates.Date(2015,9,2),Dates.Date(2015,9,4),Dates.Date(2015,9,8),Dates.Date(2015,9,9)]
@test advancebdays("Brazil", Dates.Date(2015,9,1), 0:5) == [Dates.Date(2015,9,1),Dates.Date(2015,9,2),Dates.Date(2015,9,3),Dates.Date(2015,9,4),Dates.Date(2015,9,8),Dates.Date(2015,9,9)]
@test listholidays("Brazil", Dates.Date(2016,1,1), Dates.Date(2016,5,30)) == [Dates.Date(2016,1,1),Dates.Date(2016,2,8),Dates.Date(2016,2,9),Dates.Date(2016,3,25),Dates.Date(2016,4,21),Dates.Date(2016,5,1),Dates.Date(2016,5,26)]

@test listbdays("Brazil", Dates.Date(2016,5,18), Dates.Date(2016,5,23)) == [Dates.Date(2016,5,18),Dates.Date(2016,5,19),Dates.Date(2016,5,20),Dates.Date(2016,5,23)]
@test listbdays("Brazil", Dates.Date(2016,5,18), Dates.Date(2016,5,18)) == [Dates.Date(2016,5,18)]
@test isempty(listbdays("Brazil", Dates.Date(2016,5,21), Dates.Date(2016,5,21)))
@test isempty(listbdays("Brazil", Dates.Date(2016,5,21), Dates.Date(2016,5,22)))
@test listbdays("Brazil", Dates.Date(2016,5,21), Dates.Date(2016,5,23)) == [Dates.Date(2016,5,23)]

@test bdays(:Brazil, Dates.Date(2016,11,1), [Dates.Date(2016,11,3), Dates.Date(2016,11,7), Dates.Date(2016,11,4)]) == [Dates.Day(1), Dates.Day(3), Dates.Day(2)]
@test bdayscount(:Brazil, Dates.Date(2016,11,1), [Dates.Date(2016,11,3), Dates.Date(2016,11,7), Dates.Date(2016,11,4)]) == [1, 3, 2]

@test bdays(:Brazil, [Dates.Date(2018,3,28), Dates.Date(2018,3,28), Dates.Date(2018,3,28), Dates.Date(2018,3,28)], [Dates.Date(2018,3,28), Dates.Date(2018,3,29), Dates.Date(2018,3,30), Dates.Date(2018,4,2)]) == [Dates.Day(0), Dates.Day(1), Dates.Day(2), Dates.Day(2)]
@test bdayscount(:Brazil, [Dates.Date(2018,3,28), Dates.Date(2018,3,28), Dates.Date(2018,3,28), Dates.Date(2018,3,28)], [Dates.Date(2018,3,28), Dates.Date(2018,3,29), Dates.Date(2018,3,30), Dates.Date(2018,4,2)]) == [0, 1, 2, 2]

# first/last businessdayofmonth
@test firstbdayofmonth(:Brazil, Dates.Date(2017,12,10)) == Dates.Date(2017,12,1)
@test firstbdayofmonth(:Brazil, Dates.Date(2018,1,10)) == Dates.Date(2018,1,2)
@test lastbdayofmonth(:Brazil, Dates.Date(2017,12,10)) == Dates.Date(2017,12,29)

@test firstbdayofmonth(:Brazil, 2017, 12) == Dates.Date(2017,12,1)
@test firstbdayofmonth(:Brazil, 2018, 1) == Dates.Date(2018,1,2)
@test lastbdayofmonth(:Brazil, 2017, 12) == Dates.Date(2017,12,29)

@test firstbdayofmonth(:Brazil, Dates.Year(2017), Dates.Month(12)) == Dates.Date(2017,12,1)
@test firstbdayofmonth(:Brazil, Dates.Year(2018), Dates.Month(1)) == Dates.Date(2018,1,2)
@test lastbdayofmonth(:Brazil, Dates.Year(2017), Dates.Month(12)) == Dates.Date(2017,12,29)

# list holidays for all available calendars
for c in [:BRSettlement, :BrazilExchange, :USNYSE, :USGovernmentBond, :USSettlement, :CanadaTSX, :CanadaSettlement, :EuroZone, :UKSettlement, :AustraliaASX]
    listholidays(c, Dates.Date(1990,1,1), Dates.Date(2100,1,1))
end
