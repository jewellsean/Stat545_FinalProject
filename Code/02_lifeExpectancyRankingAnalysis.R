library(ggplot2)
library(plyr)

dat <- read.delim("Data/gapminder_clean.tsv")
tail(dat)
## infer order of continent from order in file
dat <-
  within(dat, {
    continent <- factor(as.character(continent), levels = unique(dat$continent))
    })
## JB's warning on this method for reordering factors: 
## WARNING: probably not a safe long-run strategy for communicating factor level
## order with plain text data files; I see no guarantees that unique() return 
## value will be in any particular order; I have just noticed anecdotally that
## return value is in order of appearance

table(dat$continent) # ensure that the ordering is still in place

## linear regression with coefficients
yearMin <- min(dat$year)
LifeExpRegression <- function(x) {
  fit <- lm(lifeExp ~ I(year - yearMin), x)
  estCoefs <- fit$coefficients
  return(data.frame(int = estCoefs[1], m = estCoefs[2], 
                    sd = sqrt(deviance(fit)/df.residual(fit)), 
                    maxResid = max(abs(resid(fit)))))
}

lifeExpLM_all <- ddply(dat, ~country + continent, LifeExpRegression)
write.table(lifeExpLM_all, "Results/lifeExpLM_all.tsv", quote = FALSE, sep = "\t", row.names = FALSE) 

## what are the 3-4 best and worst countries for each contient
## I use the same metric that we used in class, namely the max resid 
## (there are some problems with this approach, but that is not the purpose of this assignment)

Extremes <- function(x) {
  m <- 3   #number of extreme values to take from the tails
  n <- nrow(x)
  id <- sort(x$maxResid, index.return= T)$ix
  best <- data.frame(x[id[(n - m + 1) : n], ], extreme = "worst")
  worst <- data.frame(x[id[1 : m], ], extreme = "best")
  return(rbind(best,worst))
}

lifeExpLM_extremes <- ddply(lifeExpLM_all, ~ continent, Extremes)

write.table(lifeExpLM_extremes, "Results/lifeExpLM_extremes.tsv", quote = FALSE, sep = "\t", row.names = FALSE) 

## single page figures for each continent from those extreme countries and write to file. 
lifeExpLM_extremesAgg <- merge(dat, lifeExpLM_extremes)
lifeExpLM_extremesAgg <- within(lifeExpLM_extremesAgg, country <- reorder(country, -maxResid))

for (sContinent in lifeExpLM_extremes$continent){
  p <- ggplot() + geom_point(data = subset(lifeExpLM_extremesAgg, continent == sContinent),
                             aes(x = year, y = lifeExp, color = extreme))
  p <- p + geom_abline(aes(intercept = int - m * yearMin, slope = m), 
                       data = subset(lifeExpLM_extremesAgg, continent == sContinent)) + 
    facet_wrap(~country) + 
    ggtitle(paste("Extreme Life Expectancy Trends in ", sContinent, sep = ""))
  
  ggsave(filename = paste("res_extremeLifeExpectancy_",sContinent,".pdf", sep = ""), 
         plot = p, path = "Figures", width = 14.4, height = 10.9)
}

sessionInfo()
Sys.time()