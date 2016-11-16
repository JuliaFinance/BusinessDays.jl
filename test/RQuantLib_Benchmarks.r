
library(RQuantLib)
library(microbenchmark)

from <- as.Date("2015-06-29")
to <- as.Date("2100-12-20")

microbenchmark ( businessDaysBetween("Brazil", from, to) )

from_vect <- rep(from, 1000000)
to_vect <- rep(to, 1000000)

microbenchmark( businessDaysBetween("Brazil", from_vect, to_vect), times=1)
