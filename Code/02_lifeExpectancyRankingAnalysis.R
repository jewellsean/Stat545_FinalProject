# all just placeholders for now...need to implement actual code

library(plyr)

# linear regression with coefficients

yearMin <- min(gDat$year)
jFun <- function(x) {
  estCoefs <- coef(lm(lifeExp ~ I(year - yearMin), x))
  names(estCoefs) <- c("intercept", "slope")
  return(estCoefs)
}
jCoefs <- ddply(gDat, ~country + continent, jFun)
str(jCoefs)


file.remove(list.files(pattern = "^jCoef"))