# part of BusinessDays module

# returns Rata Die number as Int64, Algo R http://www.linuxtopia.org/online_books/programming_books/python_programming/python_ch38.html
function easter_rata(y::Year)

	local c::Int64
	local e::Int64
	local p::Int64

     # Algo R only works after 1582
     if y.value < 1582
          # Are you using this? Send me a postcard!
          error("Year cannot be less than 1582. Provided: $(y.value).")
     end

	# Century
     c = div( y.value , 100) + 1

     # Shifted Epact
     e = mod( ( 14 + 11*(mod(y.value,19)) - div(3*c, 4) + div( (5+8*c), 25 )), 30)

     # Adjust Epact
     if (e == 0) || (  (e == 1) && ( 10 < mod(y.value, 19)) )
     	e += 1
     end

     # Paschal Moon
     p = Date(y.value, 4, 19).instant.periods.value - e

     # Easter: locate the Sunday after the Paschal Moon
     return p + 7 - mod(p, 7)
end

# Returns Date
function easter_date(y::Year)
	# Compute the gregorian date for Rata Die number
     return Date(Dates.rata2datetime( easter_rata(y) ))
end
