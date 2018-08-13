
library(RQuantLib)
library(stringr)

d0 <- as.Date("1960-01-04")
d1 <- seq(d0, as.Date("2100-01-04"), by="days")
l <- length(d1)
d0 <- rep(d0, l)

cals = c( "Canada", "Canada/Settlement", "Canada/TSX", "Germany", "Germany/FrankfurtStockExchange",
          "Germany/Settlement", "Germany/Xetra", "Germany/Eurex", "Italy", "Italy/Settlement", "Italy/Exchange",
          "Japan", "UnitedKingdom", "UnitedKingdom/Settlement", "UnitedKingdom/Exchange", "UnitedKingdom/Metals",
          "UnitedStates", "UnitedStates/Settlement", "UnitedStates/NYSE", "UnitedStates/GovernmentBond",
          "UnitedStates/NERC", "Brazil", "TARGET")

dir.create('csv')

for (cal in cals) {
  res <- isBusinessDay(cal, d1)
  df <- data.frame(d=d1, isbday=res)
  write.csv(df, file=paste0( "csv/QuantLib-isbday-",   str_replace(cal, "/", "-")   , ".csv"), row.names=FALSE)
}
