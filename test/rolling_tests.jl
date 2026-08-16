
# Assertions that must hold whether or not the calendar cache is enabled.
# `cal` is expected to resolve to USSettlement.
function test_rolling_conventions(cal)

    # 2015-01-31 is a saturday at the end of the month:
    # rolling forward would leave january, so the modified conventions roll back.
    @test tobday(cal, Dates.Date(2015, 1, 31), BusinessDays.Unadjusted())                 == Dates.Date(2015, 1, 31)
    @test tobday(cal, Dates.Date(2015, 1, 31), BusinessDays.Following())                  == Dates.Date(2015, 2, 2)
    @test tobday(cal, Dates.Date(2015, 1, 31), BusinessDays.ModifiedFollowing())          == Dates.Date(2015, 1, 30)
    @test tobday(cal, Dates.Date(2015, 1, 31), BusinessDays.Preceding())                  == Dates.Date(2015, 1, 30)
    @test tobday(cal, Dates.Date(2015, 1, 31), BusinessDays.ModifiedPreceding())          == Dates.Date(2015, 1, 30)
    @test tobday(cal, Dates.Date(2015, 1, 31), BusinessDays.HalfMonthModifiedFollowing()) == Dates.Date(2015, 1, 30)
    @test tobday(cal, Dates.Date(2015, 1, 31), BusinessDays.Nearest())                    == Dates.Date(2015, 1, 30)

    # 2015-02-01 is a sunday at the start of the month:
    # rolling back would leave february, so ModifiedPreceding rolls forward.
    @test tobday(cal, Dates.Date(2015, 2, 1), BusinessDays.Unadjusted())                 == Dates.Date(2015, 2, 1)
    @test tobday(cal, Dates.Date(2015, 2, 1), BusinessDays.Following())                  == Dates.Date(2015, 2, 2)
    @test tobday(cal, Dates.Date(2015, 2, 1), BusinessDays.ModifiedFollowing())          == Dates.Date(2015, 2, 2)
    @test tobday(cal, Dates.Date(2015, 2, 1), BusinessDays.Preceding())                  == Dates.Date(2015, 1, 30)
    @test tobday(cal, Dates.Date(2015, 2, 1), BusinessDays.ModifiedPreceding())          == Dates.Date(2015, 2, 2)
    @test tobday(cal, Dates.Date(2015, 2, 1), BusinessDays.HalfMonthModifiedFollowing()) == Dates.Date(2015, 2, 2)
    @test tobday(cal, Dates.Date(2015, 2, 1), BusinessDays.Nearest())                    == Dates.Date(2015, 2, 2)

    # 2015-01-01 is New Year's Day (a thursday holiday). The month comparison
    # must be year aware: rolling back lands on 2014-12-31.
    @test tobday(cal, Dates.Date(2015, 1, 1), BusinessDays.Unadjusted())                 == Dates.Date(2015, 1, 1)
    @test tobday(cal, Dates.Date(2015, 1, 1), BusinessDays.Following())                  == Dates.Date(2015, 1, 2)
    @test tobday(cal, Dates.Date(2015, 1, 1), BusinessDays.ModifiedFollowing())          == Dates.Date(2015, 1, 2)
    @test tobday(cal, Dates.Date(2015, 1, 1), BusinessDays.Preceding())                  == Dates.Date(2014, 12, 31)
    @test tobday(cal, Dates.Date(2015, 1, 1), BusinessDays.ModifiedPreceding())          == Dates.Date(2015, 1, 2)
    @test tobday(cal, Dates.Date(2015, 1, 1), BusinessDays.HalfMonthModifiedFollowing()) == Dates.Date(2015, 1, 2)
    @test tobday(cal, Dates.Date(2015, 1, 1), BusinessDays.Nearest())                    == Dates.Date(2015, 1, 2)

    # 2021-12-31 is a friday, but it is New Year's Day observed (2022-01-01
    # falls on a saturday). Rolling forward crosses into the next year, so the
    # modified conventions must roll back and stay in december.
    @test tobday(cal, Dates.Date(2021, 12, 31), BusinessDays.Unadjusted())                 == Dates.Date(2021, 12, 31)
    @test tobday(cal, Dates.Date(2021, 12, 31), BusinessDays.Following())                  == Dates.Date(2022, 1, 3)
    @test tobday(cal, Dates.Date(2021, 12, 31), BusinessDays.ModifiedFollowing())          == Dates.Date(2021, 12, 30)
    @test tobday(cal, Dates.Date(2021, 12, 31), BusinessDays.Preceding())                  == Dates.Date(2021, 12, 30)
    @test tobday(cal, Dates.Date(2021, 12, 31), BusinessDays.ModifiedPreceding())          == Dates.Date(2021, 12, 30)
    @test tobday(cal, Dates.Date(2021, 12, 31), BusinessDays.HalfMonthModifiedFollowing()) == Dates.Date(2021, 12, 30)
    @test tobday(cal, Dates.Date(2021, 12, 31), BusinessDays.Nearest())                    == Dates.Date(2021, 12, 30)

    # HalfMonthModifiedFollowing: 2015-03-15 is a sunday on the mid-month
    # boundary. Following gives the 16th, which crosses the 15th, so it rolls
    # back to the 13th. This is where it diverges from ModifiedFollowing.
    @test tobday(cal, Dates.Date(2015, 3, 15), BusinessDays.Following())                  == Dates.Date(2015, 3, 16)
    @test tobday(cal, Dates.Date(2015, 3, 15), BusinessDays.ModifiedFollowing())          == Dates.Date(2015, 3, 16)
    @test tobday(cal, Dates.Date(2015, 3, 15), BusinessDays.HalfMonthModifiedFollowing()) == Dates.Date(2015, 3, 13)

    # A weekend fully after the 15th must not trigger the half month rule.
    @test tobday(cal, Dates.Date(2015, 3, 21), BusinessDays.ModifiedFollowing())          == Dates.Date(2015, 3, 23)
    @test tobday(cal, Dates.Date(2015, 3, 21), BusinessDays.HalfMonthModifiedFollowing()) == Dates.Date(2015, 3, 23)

    # Business days are never adjusted by any convention.
    for dt in (Dates.Date(2015, 1, 2), Dates.Date(2015, 3, 16), Dates.Date(2015, 6, 15))
        for conv in (BusinessDays.Unadjusted(), BusinessDays.Following(), BusinessDays.ModifiedFollowing(), BusinessDays.Preceding(),
                     BusinessDays.ModifiedPreceding(), BusinessDays.HalfMonthModifiedFollowing(), BusinessDays.Nearest())
            @test tobday(cal, dt, conv) == dt
        end
    end

    # Backwards compatibility: the new conventions must agree with the old
    # `forward` keyword over a long sweep.
    for dt in Dates.Date(1990, 1, 1):Dates.Day(1):Dates.Date(2050, 12, 31)
        @test tobday(cal, dt) == tobday(cal, dt, BusinessDays.Following())
        @test tobday(cal, dt; forward=false) == tobday(cal, dt, BusinessDays.Preceding())
    end

    nothing
end

# Invariants every adjusting convention must satisfy over a long date range.
function test_rolling_invariants(cal)
    for conv in (BusinessDays.Following(), BusinessDays.ModifiedFollowing(), BusinessDays.Preceding(),
                 BusinessDays.ModifiedPreceding(), BusinessDays.HalfMonthModifiedFollowing(), BusinessDays.Nearest())

        all_bdays = true
        all_close = true
        all_modified_in_month = true

        for dt in Dates.Date(1990, 1, 1):Dates.Day(1):Dates.Date(2050, 12, 31)
            result = tobday(cal, dt, conv)
            all_bdays &= isbday(cal, result)
            all_close &= abs(Dates.value(result - dt)) <= 7

            if conv === BusinessDays.ModifiedFollowing() || conv === BusinessDays.ModifiedPreceding() || conv === BusinessDays.HalfMonthModifiedFollowing()
                all_modified_in_month &= Dates.yearmonth(result) == Dates.yearmonth(dt)
            end
        end

        @test all_bdays
        @test all_close
        @test all_modified_in_month
    end

    nothing
end

@testset "Date Rolling Conventions" begin

    @testset "Type hierarchy" begin
        for conv in (BusinessDays.Unadjusted(), BusinessDays.Following(), BusinessDays.ModifiedFollowing(), BusinessDays.Preceding(),
                     BusinessDays.ModifiedPreceding(), BusinessDays.HalfMonthModifiedFollowing(), BusinessDays.Nearest())
            @test conv isa BusinessDays.DateRollingConvention
        end

        # singletons: two instances are the same object
        @test BusinessDays.ModifiedFollowing() === BusinessDays.ModifiedFollowing()
    end

    @testset "Conventions without cache" begin
        BusinessDays.cleancache(BusinessDays.USSettlement())
        test_rolling_conventions(BusinessDays.USSettlement())
        test_rolling_invariants(BusinessDays.USSettlement())
    end

    @testset "Conventions with cache" begin
        BusinessDays.initcache(BusinessDays.USSettlement())
        test_rolling_conventions(BusinessDays.USSettlement())
        test_rolling_invariants(BusinessDays.USSettlement())
        BusinessDays.cleancache(BusinessDays.USSettlement())
    end

    @testset "Calendar given as Symbol and String" begin
        test_rolling_conventions(:USSettlement)
        test_rolling_conventions("USSettlement")
    end

    @testset "Nearest tie break" begin
        # 2020-01-07 sits between two holidays, so forward and backward are
        # equidistant. Ties resolve in favor of the next business day.
        gen = GenericHolidayCalendar(
            Set([Dates.Date(2020, 1, 6), Dates.Date(2020, 1, 7), Dates.Date(2020, 1, 8)]),
            Dates.Date(2019, 12, 1),
            Dates.Date(2020, 2, 1))

        @test tobday(gen, Dates.Date(2020, 1, 7), BusinessDays.Nearest()) == Dates.Date(2020, 1, 9)

        # 2020-01-06 is also a tie: 2020-01-03 (friday) and 2020-01-09 are both
        # three days away, because the weekend blocks the backward search.
        @test tobday(gen, Dates.Date(2020, 1, 6), BusinessDays.Nearest()) == Dates.Date(2020, 1, 9)

        # not a tie: forward is closer
        @test tobday(gen, Dates.Date(2020, 1, 8), BusinessDays.Nearest()) == Dates.Date(2020, 1, 9)

        # a plain weekend: saturday is nearer to friday, sunday to monday
        @test tobday(BusinessDays.WeekendsOnly(), Dates.Date(2019, 8, 31), BusinessDays.Nearest()) == Dates.Date(2019, 8, 30)
        @test tobday(BusinessDays.WeekendsOnly(), Dates.Date(2019, 9, 1), BusinessDays.Nearest())  == Dates.Date(2019, 9, 2)
    end

    @testset "Vector and broadcast forms" begin
        dt_vec = [Dates.Date(2015, 1, 31), Dates.Date(2015, 2, 1), Dates.Date(2015, 1, 1)]
        expected = [Dates.Date(2015, 1, 30), Dates.Date(2015, 2, 2), Dates.Date(2015, 1, 2)]

        @test tobday(BusinessDays.USSettlement(), dt_vec, BusinessDays.ModifiedFollowing()) == expected
        @test tobday(:USSettlement, dt_vec, BusinessDays.ModifiedFollowing()) == expected
        @test tobday("USSettlement", dt_vec, BusinessDays.ModifiedFollowing()) == expected

        # zipped calendar vector
        hc_vec = HolidayCalendar[BusinessDays.USSettlement(), BusinessDays.USSettlement(), BusinessDays.USSettlement()]
        @test tobday(hc_vec, dt_vec, BusinessDays.ModifiedFollowing()) == expected
        @test tobday([:USSettlement, :USSettlement, :USSettlement], dt_vec, BusinessDays.ModifiedFollowing()) == expected

        @test_throws AssertionError tobday(hc_vec, dt_vec[1:2], BusinessDays.ModifiedFollowing())

        # broadcasting works because conventions and calendars are scalars
        @test tobday.(BusinessDays.USSettlement(), dt_vec, BusinessDays.ModifiedFollowing()) == expected
    end

    @testset "Type stability" begin
        hc = BusinessDays.USSettlement()
        dt = Dates.Date(2015, 1, 31)

        for conv in (BusinessDays.Unadjusted(), BusinessDays.Following(), BusinessDays.ModifiedFollowing(), BusinessDays.Preceding(),
                     BusinessDays.ModifiedPreceding(), BusinessDays.HalfMonthModifiedFollowing(), BusinessDays.Nearest())
            @test (@inferred tobday(hc, dt, conv)) isa Dates.Date
        end
    end

    @testset "dt must be a Date" begin
        # Same guarantee as the two argument `tobday`: anything that is not a
        # `Dates.Date` is a MethodError, never a StackOverflowError.
        for calendar in Any[:USNYSE, "USNYSE", BusinessDays.USNYSE()]
            for dt in Any["2026-03-14", Dates.DateTime(2026, 3, 14, 10, 30)]
                @test_throws MethodError tobday(calendar, dt, BusinessDays.ModifiedFollowing())
            end
        end
    end

    @testset "Composition with calendar periods" begin
        # The documented idiom for "advance by a period, then roll".
        @test tobday(:USSettlement, Dates.Date(2015, 1, 31) + Dates.Month(3), BusinessDays.ModifiedFollowing()) == Dates.Date(2015, 4, 30)
        @test tobday(:USSettlement, Dates.Date(2014, 11, 30) + Dates.Month(2), BusinessDays.ModifiedFollowing()) == Dates.Date(2015, 1, 30)
    end
end
