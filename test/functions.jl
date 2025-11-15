function test_bdays(cal, d0::Dates.Date, d1::Dates.Date, expected_result::Integer)
    @test bdays(cal, d0, d1) == Dates.Day(expected_result)
    if d0 != d1
        @test bdays(cal, d1, d0) == Dates.Day(-expected_result)
    end
    nothing
end

function test_bdays(cal,
        d0::Tuple{Int, Int, Int},
        d1::Tuple{Int, Int, Int},
        expected_result::Integer)

    test_bdays(cal, Dates.Date(d0[1], d0[2], d0[3]), Dates.Date(d1[1], d1[2], d1[3]), expected_result)
end