
using BusinessDays
using Test

# lets find out minimum and maximum month for easter
function find_easter_min_max()
    y = 1582
    easter_1582 = BusinessDays.easter_date(Dates.Year(1582))
    month_min = Dates.month(easter_1582)
    date_min = easter_1582
    month_max = Dates.month(easter_1582)
    date_max = easter_1582

    while y <= 2100
        e_date = BusinessDays.easter_date(Dates.Year(y))
        m_e_date = Dates.month(e_date)
        month_min = min(month_min, m_e_date)
        month_max = max(month_max, m_e_date)

        if month_min == m_e_date
            date_min = e_date
        end

        if month_max == m_e_date
            date_max = e_date
        end

        y += 1
    end

    return (month_min, month_max)
end

month_min, month_max = find_easter_min_max()

@test month_min >= 3
@test month_max <= 4
