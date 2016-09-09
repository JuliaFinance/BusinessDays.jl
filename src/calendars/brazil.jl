
# Brazilian Banking Holidays
function isholiday(::Brazil, dt::Date)

    const yy = Dates.year(dt)
    const mm = Dates.month(dt)
    const dd = Dates.day(dt)

    # Bisection
    if mm >= 8
        # Fixed holidays
        if (
                # Independencia do Brasil
                ((mm == 9) && (dd == 7))
                ||
                # Nossa Senhora Aparecida
                ((mm == 10) && (dd == 12))
                ||
                # Finados
                ((mm == 11) && (dd == 2))
                ||
                # Proclamacao da Republica
                ((mm == 11) && (dd == 15))
                ||
                # Natal
                ((mm == 12) && (dd == 25))
            )
            return true
        end 
    else
        # mm < 8
        # Fixed holidays
        if (
                # Confraternizacao Universal
                ((mm == 1) && (dd == 1))
                ||
                # Tiradentes
                ((mm == 4) && (dd == 21))
                ||
                # Dia do Trabalho   
                ((mm == 5) && (dd == 1))
            )
            return true
        end

        # Easter occurs up to April, so Corpus Christi will be up to July in the worst case, which is before August (mm < 8). See test/easter-min-max.jl .
        # Holidays based on easter date
        const dt_rata::Int = Dates.days(dt)
        const e_rata::Int = easter_rata(Dates.Year(yy))

        if (
                # Segunda de Carnaval
                (  dt_rata == (  e_rata - 48  )   )
                ||
                # Terca de Carnaval
                ( dt_rata == (  e_rata - 47 )     )
                ||
                # Sexta-feira Santa
                ( dt_rata == ( e_rata - 2 )       )
                ||
                # Corpus Christi
                ( dt_rata == ( e_rata + 60)       )
            )
            return true
        end
    end

    return false
end
