
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

dt_tuesday = Date(2015,06,23)
dt_wednesday = Date(2015, 06, 24)
dt_thursday = Date(2015, 06, 25)
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
    @test_throws AssertionError isbday(hc_brazil, Date(1600,2,1))
    @test_throws AssertionError isbday(hc_brazil, Date(3000,2,1))
    @test_throws AssertionError bdays(hc_brazil, Date(1600,2,1), Date(1600, 2, 5))
    @test_throws AssertionError bdays(hc_brazil, Date(3000,2,1), Date(3000, 2, 5))
end

@test_throws ErrorException isbday(:UnknownCalendar, Date(2016,1,1))
@test_throws ErrorException isbday("UnknownCalendar", Date(2016,1,1))

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

@test isholiday(bd.NullHolidayCalendar(), Date(2016,9,25)) == false
@test isholiday(:NullHolidayCalendar, Date(2016,9,25)) == false
@test isholiday("NullHolidayCalendar", Date(2016,9,25)) == false
@test isbday(bd.NullHolidayCalendar(), Date(2016,9,25)) == true
@test isbday(:NullHolidayCalendar, Date(2016,9,25)) == true
@test isbday("NullHolidayCalendar", Date(2016,9,25)) == true
@test bdays(:NullHolidayCalendar, Date(2016,9,25), Date(2016,9,28)) == Day(3)

@test isholiday(bd.WeekendsOnly(), Date(2016,9,25)) == false
@test isholiday(:WeekendsOnly, Date(2016,9,25)) == false
@test isholiday("WeekendsOnly", Date(2016,9,25)) == false
@test isbday(bd.WeekendsOnly(), Date(2016,9,25)) == false
@test isbday(:WeekendsOnly, Date(2016,9,25)) == false
@test isbday("WeekendsOnly", Date(2016,9,25)) == false
@test bdays(:WeekendsOnly, Date(2016,9,25), Date(2016,9,28)) == Day(2)


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

# BrazilBMF holiday calendar tests
@test isbday(hc_brazil_bmf, Date(2017, 11, 19)) == false # sunday
@test isbday(hc_brazil_bmf, Date(2017, 11, 20)) == false # Conciência Negra (segunda)
@test isbday(hc_brazil_bmf, Date(2017, 11, 21)) == true # Terca

@test isbday(:BrazilBMF, Date(2013, 05, 29)) == true # wednesday
@test isbday(:BrazilBMF, Date(2013, 05, 30)) == false # Corpus Christi (National Holiday)
@test isbday(:BrazilBMF, Date(2013, 05, 31)) == true # friday

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

# TARGET HolidayCalendar tests
@test isbday(targethc, Date(2017, 12, 24)) == false # Sunday
@test isbday(targethc, Date(2017, 12, 25)) == false # Christmas - Monday
@test isbday(targethc, Date(2017, 12, 26)) == false # Day of Goodwill - Tuesday
@test isbday(targethc, Date(2017, 12, 27)) == true  # Wednesday

@test isbday(targethc, Date(2017, 04, 16)) == false # Easter Sunday
@test isbday(targethc, Date(2017, 04, 17)) == false # Easter Monday
@test isbday(targethc, Date(2017, 04, 18)) == true # Tuesday

@test isbday(targethc, Date(2001, 12, 31)) == false # End of year
@test isbday(targethc, Date(2002, 12, 31)) == true # End of year

@test isbday(targethc, Date(2016, 1, 1)) == false # New Year's Day
@test isbday(targethc, Date(2017, 5, 1)) == false # Labour Day
@test isbday(targethc, Date(1998, 5, 1)) == true # Labour Day before 2000

# Symbol
@test isbday(:TARGET, Date(2017, 04, 16)) == false # Easter Sunday
@test isbday(:TARGET, Date(2017, 04, 17)) == false # Easter Monday
@test isbday(:TARGET, Date(2017, 04, 18)) == true # Tuesday

# String
@test isbday("TARGET", Date(2017, 04, 16)) == false # Easter Sunday
@test isbday("TARGET", Date(2017, 04, 17)) == false # Easter Monday
@test isbday("TARGET", Date(2017, 04, 18)) == true # Tuesday

# TARGET synonyms
@test isbday("TARGET2", Date(2017, 04, 18)) == isbday("TARGET", Date(2017, 04, 18))
@test isbday("EuroZone", Date(2017, 04, 18)) == isbday("TARGET", Date(2017, 04, 18))

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


# Canada

tsxdates16 = [
    Date(2016, 1, 1),
    Date(2016, 2, 15),
    Date(2016, 3, 25),
    Date(2016, 5, 23),
    Date(2016, 7, 1),
    Date(2016, 8, 1),
    Date(2016, 9, 5),
    Date(2016, 10, 10),
    Date(2016, 12, 26),
    Date(2016, 12, 27)
]

alldates16 = collect(Date(2016,1,1):Day(1):Date(2016, 12,31))
for i in alldates16
    if contains(==, tsxdates16, i)
        @test isholiday(hc_canadatsx, i) == true
    else
        @test isholiday(hc_canadatsx, i) == false
    end
end

tsxdates17 = [
    Date(2017, 1, 2),
    Date(2017, 2, 20),
    Date(2017, 4, 14),
    Date(2017, 5, 22),
    Date(2017, 7, 3),
    Date(2017, 8, 7),
    Date(2017, 9, 4),
    Date(2017, 10, 9),
    Date(2017, 12, 25),
    Date(2017, 12, 26)
]
alldates17 = collect(Date(2017,1,1):Day(1):Date(2017, 12,31))

for i in alldates17
    if contains(==, tsxdates17, i)
        @test isholiday(hc_canadatsx, i) == true
    else
        @test isholiday(hc_canadatsx, i) == false
    end
end

canadaDates16 = [
    Date(2016, 1, 1),
    Date(2016, 2, 15),
    Date(2016, 3, 25),
    Date(2016, 5, 23),
    Date(2016, 7, 1),
    Date(2016, 8, 1),
    Date(2016, 9, 5),
    Date(2016, 10, 10),
    Date(2016, 11, 11),
    Date(2016, 12, 26),
    Date(2016, 12, 27)
]

for i in alldates16
    if contains(==, canadaDates16, i)
        @test isholiday(hc_canada, i) == true
    else
        @test isholiday(hc_canada, i) == false
    end
end

# Issue #8
@test isbday(hc_canada, Date(2011,1,3)) == true
@test isbday(hc_canadatsx, Date(2008, 2, 18)) == false


# Australian Stock Exchange (ASX)
christmasday = Date(2018,12, 25)
boxingday    = Date(2018,12, 26)
asxdates18 = Set([
    Date(2018, 1,  1),  # New year's day
    Date(2018, 1, 26),  # Australia Day
    Date(2018, 3, 30),  # Good Friday
    Date(2018, 4,  2),  # Easter Monday
    Date(2018, 4, 25),  # ANZAC Day
    Date(2018, 6, 11),  # Queen's Birthday holiday
    christmasday,
    boxingday
])
for dt in Date(2018,1,1):Day(1):Date(2018,12,31)
    if in(dt, asxdates18)
        dt != boxingday && @test isholiday(hc_australiaasx, dt-Day(1)) == false
        @test isholiday(hc_australiaasx, dt) == true
        dt != christmasday && @test isholiday(hc_australiaasx, dt+Day(1)) == false
    else
        @test isholiday(hc_australiaasx, dt) == false
    end
end

# Australian states and territories
@test_throws MethodError bd.Australia()         # State/territory not specified
@test_throws ErrorException bd.Australia(:XXX)  # Invalid state/territory

# The Australian Capital Territory (ACT)
actdates18 = Set([
    Date(2018,  1,  1),  # New year's day
    Date(2018,  1, 26),  # Australia Day
    Date(2018,  3, 12),  # Canberra Day
    Date(2018,  3, 30),  # Good Friday
    Date(2018,  3, 31),  # Easter Saturday
    Date(2018,  4,  1),  # Easter Sunday 
    Date(2018,  4,  2),  # Easter Monday
    Date(2018,  4, 25),  # ANZAC Day
    Date(2018,  5, 28),  # Reconciliation Day
    Date(2018,  6, 11),  # Queen's Birthday holiday
    Date(2018, 10,  1),  # Labour Day
    christmasday,
    boxingday
])
for dt in Date(2018,1,1):Day(1):Date(2018,12,31)
    if in(dt, actdates18)
        @test isholiday(hc_australiaact, dt) == true
    else
        @test isholiday(hc_australiaact, dt) == false
    end
end

# The state of New South Wales (NSW), Australia
nswdates18 = Set([
    Date(2018,  1,  1),  # New year's day
    Date(2018,  1, 26),  # Australia Day
    Date(2018,  3, 30),  # Good Friday
    Date(2018,  3, 31),  # Easter Saturday
    Date(2018,  4,  1),  # Easter Sunday 
    Date(2018,  4,  2),  # Easter Monday
    Date(2018,  4, 25),  # ANZAC Day
    Date(2018,  6, 11),  # Queen's Birthday holiday
    Date(2018,  8,  6),  # Bank Holiday
    Date(2018, 10,  1),  # Labour Day
    christmasday,
    boxingday
])
for dt in Date(2018,1,1):Day(1):Date(2018,12,31)
    if in(dt, nswdates18)
        @test isholiday(hc_australiansw, dt) == true
    else
        @test isholiday(hc_australiansw, dt) == false
    end
end

# The Northern Territory (NT), Australia
ntdates18 = Set([
    Date(2018,  1,  1),  # New year's day
    Date(2018,  1, 26),  # Australia Day
    Date(2018,  3, 30),  # Good Friday
    Date(2018,  3, 31),  # Easter Saturday
    Date(2018,  4,  2),  # Easter Monday
    Date(2018,  4, 25),  # ANZAC Day
    Date(2018,  5,  7),  # May Day
    Date(2018,  6, 11),  # Queen's Birthday holiday
    Date(2018,  8,  6),  # Picnic Day
    christmasday,
    boxingday
])
for dt in Date(2018,1,1):Day(1):Date(2018,12,31)
    if in(dt, ntdates18)
        @test isholiday(hc_australiant, dt) == true
    else
        @test isholiday(hc_australiant, dt) == false
    end
end

# The state of Queensland (QLD), Australia
qlddates18 = Set([
    Date(2018,  1,  1),  # New year's day
    Date(2018,  1, 26),  # Australia Day
    Date(2018,  3, 30),  # Good Friday
    Date(2018,  3, 31),  # Easter Saturday
    Date(2018,  4,  1),  # Easter Sunday 
    Date(2018,  4,  2),  # Easter Monday
    Date(2018,  4, 25),  # ANZAC Day
    Date(2018,  5,  7),  # Labour Day
    Date(2018,  8, 15),  # Royal Brisbane Show (brisbane area only)
    Date(2018, 10,  1),  # Queen's Birthday holiday
    christmasday,
    boxingday
])
for dt in Date(2018,1,1):Day(1):Date(2018,12,31)
    if in(dt, qlddates18)
        @test isholiday(hc_australiaqld, dt) == true
    else
        @test isholiday(hc_australiaqld, dt) == false
    end
end

# The state of South Australia (SA)
sadates18 = Set([
    Date(2018,  1,  1),  # New year's day
    Date(2018,  1, 26),  # Australia Day
    Date(2018,  3, 12),  # March public Holiday
    Date(2018,  3, 30),  # Good Friday
    Date(2018,  3, 31),  # Easter Saturday
    Date(2018,  4,  2),  # Easter Monday
    Date(2018,  4, 25),  # ANZAC Day
    Date(2018,  6, 11),  # Queen's Birthday holiday
    Date(2018, 10,  1),  # Labour Day
    christmasday,
    boxingday
])
for dt in Date(2018,1,1):Day(1):Date(2018,12,31)
    if in(dt, sadates18)
        @test isholiday(hc_australiasa, dt) == true
    else
        @test isholiday(hc_australiasa, dt) == false
    end
end

# The state of Tasmania (TAS), Australia
tasdates18 = Set([
    Date(2018,  1,  1),  # New year's day
    Date(2018,  1, 26),  # Australia Day
    Date(2018,  2, 12),  # Royal Hobart Regatta
    Date(2018,  3, 12),  # Labour Day
    Date(2018,  3, 30),  # Good Friday
    Date(2018,  4,  2),  # Easter Monday
    Date(2018,  4, 25),  # ANZAC Day
    Date(2018,  6, 11),  # Queen's Birthday holiday
    Date(2018, 11,  5),  # Recreation Day
    christmasday,
    boxingday
])
for dt in Date(2018,1,1):Day(1):Date(2018,12,31)
    if in(dt, tasdates18)
        @test isholiday(hc_australiatas, dt) == true
    else
        @test isholiday(hc_australiatas, dt) == false
    end
end

# The state of Western Australia (WA)
wadates18 = Set([
    Date(2018,  1,  1),  # New year's day
    Date(2018,  1, 26),  # Australia Day
    Date(2018,  3,  5),  # Labour Day
    Date(2018,  3, 30),  # Good Friday
    Date(2018,  4,  2),  # Easter Monday
    Date(2018,  4, 25),  # ANZAC Day
    Date(2018,  6,  4),  # Western Australia Day
    Date(2018,  9, 24),  # Queen's Birthday holiday
    christmasday,
    boxingday
])
for dt in Date(2018,1,1):Day(1):Date(2018,12,31)
    if in(dt, wadates18)
        @test isholiday(hc_australiawa, dt) == true
    else
        @test isholiday(hc_australiawa, dt) == false
    end
end

# The state of Victoria (VIC), Australia
vicdates18 = Set([
    Date(2018,  1,  1),  # New year's day
    Date(2018,  1, 26),  # Australia Day
    Date(2018,  3, 12),  # Labour Day
    Date(2018,  3, 30),  # Good Friday
    Date(2018,  3, 31),  # Easter Saturday
    Date(2018,  4,  1),  # Easter Sunday 
    Date(2018,  4,  2),  # Easter Monday
    Date(2018,  4, 25),  # ANZAC Day
    Date(2018,  6, 11),  # Queen's Birthday holiday
    Date(2018,  9, 28),  # AFL Grand Final Eve holiday
    Date(2018, 11,  6),  # Melbourne Cup holiday
    christmasday,
    boxingday
])
for dt in Date(2018,1,1):Day(1):Date(2018,12,31)
    if in(dt, vicdates18)
        @test isholiday(hc_australiavic, dt) == true
    else
        @test isholiday(hc_australiavic, dt) == false
    end
end


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
    @time x = bd._create_bdays_cache_arrays(hc_brazil, dInicio, dFim)
end

if usecache
    println("a million...")
    @time for i in 1:1000000 bdays(hc_brazil, d0, d2) end
end

# Vector functions
d0 = Date(2000,01,04)
d1 = Date(2020,01,04)

d1vec = collect(d0:d1)
d0vec = fill(d0, length(d1vec))

r = bdays(hc_brazil, d0vec, d1vec)
b = isbday(hc_brazil, d0vec)
b2 = isbday(:Brazil, d0vec)
b3 = isbday("Brazil", d0vec)
@test tobday([hc_brazil, hc_usa], [Date(2015,11,11), Date(2015,11,11)]) == [Date(2015,11,11), Date(2015,11,12)]
@test tobday([:Brazil, :USSettlement], [Date(2015,11,11), Date(2015,11,11)]) == [Date(2015,11,11), Date(2015,11,12)]
@test tobday(["Brazil", "USSettlement"], [Date(2015,11,11), Date(2015,11,11)]) == [Date(2015,11,11), Date(2015,11,12)]

# Vector with different sizes
@test_throws AssertionError bdays(hc_brazil, fill(d0, length(d1vec)+1), d1vec)
@test_throws AssertionError bdays([hc_brazil, hc_usa], [Date(2015,11,11)], [Date(2015,11,11),Date(2015,11,11)])
@test_throws AssertionError tobday([hc_brazil, hc_usa], fill(d0, 3))
@test_throws AssertionError isbday( [hc_brazil, hc_usa, hc_uk], [Date(2015,01,01), Date(2015,01,01)])

println("Timing vectorized functions (vector length $(length(d0vec)))")
@time bdays(hc_brazil, d0vec, d1vec)
@time bdays(:Brazil, d0vec, d1vec)
@time bdays("Brazil", d0vec, d1vec)
@time isbday(hc_brazil, d0vec)
@time isbday(:Brazil, d0vec)
@time isbday("Brazil", d0vec)

d2001 = collect(Date(2001,01,01):Date(2001,01,15))

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

@test bdays(:Brazil, Date(2016,11,1), [Date(2016,11,3), Date(2016,11,7), Date(2016,11,4)]) == [Day(1), Day(3), Day(2)]
