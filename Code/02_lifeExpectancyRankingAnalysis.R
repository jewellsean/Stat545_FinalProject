library(ggplot2)
library(plyr)

dat <- read.delim("Data/gapminder_clean.tsv")
tail(dat)
## infer order of continent from order in file
dat <-
  within(dat, {
    continent <- factor(as.character(continent), levels = unique(dat$continent))
    })
# JB's warning on this method for reordering factors: 
# WARNING: probably not a safe long-run strategy for communicating factor level
# order with plain text data files; I see no guarantees that unique() return 
# value will be in any particular order; I have just noticed anecdotally that
# return value is in order of appearance

table(dat$continent) # ensure that the ordering is still in place

# linear regression with coefficients
yearMin <- min(dat$year)
LifeExpRegression <- function(x) {
  fit <- lm(lifeExp ~ I(year - yearMin), x)
  estCoefs <- fit$coefficients
  return(data.frame(int = estCoefs[1], m = estCoefs[2], sd = sqrt(deviance(fit)/df.residual(fit))))
}

lifeExpLM_all <- ddply(dat, ~country + continent, LifeExpRegression)
write.table(lifeExpLM_all, "Results/lifeExpLM_all.tsv", quote = FALSE, sep = "\t", row.names = FALSE) 

# what are the 3-4 best and worst countries for each contient
Extremes <- function(x) {
  m <- 3   #number of extreme values to take from the tails
  n <- nrow(x)
  id <- sort(x$m, index.return= T)$ix
  best <- data.frame(x[id[(n - m + 1) : n], ], extreme = "best")
  worst <- data.frame(x[id[1 : m], ], extreme = "worst")
  return(rbind(best,worst))
}

lifeExpLM_extremes <- ddply(lifeExpLM_all, ~ continent, Extremes)
write.table(lifeExpLM_extremes, "Results/lifeExpLM_extremes.tsv", quote = FALSE, sep = "\t", row.names = FALSE) 

# single page figures for each continent from those extreme countries and write to file. one file per contient with a good name
sContinent <- "Africa"
ggplot() + geom_point(data = subset(dat, continent == sContinent & country %in% lifeExpLM_extremes$country),
                      aes(x = year, y = lifeExp)) + 
  geom_abline(aes(intercept = int, slope = m), data = subset(lifeExpLM_extremes, continent == sContinent)) + 
                facet_wrap(~country)

## This was annoying to do, and the easier way is to use the built in smooth functions in ggplot2
## however, there may be instances in the future when I will need this functionality
## This helped in the debugging: http://stackoverflow.com/questions/11846295/how-to-add-different-lines-for-facets
## error in having the factor level with the same name as the mapping in aes


# give scatterplots of life exp vs year :: panelling/facetting on country, fitted line overlaid.

sessionInfo()
Sys.time()