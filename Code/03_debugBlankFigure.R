## Examine the plotting behaviour of ggsave and png() to try and determine
## why the plot will generate when sourced and run interactively in console, but 
## not through R CMD BATCH

## Here is an illustration of the problem 
library(ggplot2)
library(plyr)

dat <- read.delim("Data/gapminder_clean.tsv")
lifeExpLM_extremes <- read.delim("Results/lifeExpLM_extremes.tsv")
yearMin <- min(dat$year)

lifeExpLM_extremesAgg <- merge(dat, lifeExpLM_extremes)
lifeExpLM_extremesAgg1 <- within(lifeExpLM_extremesAgg, country <- reorder(country, -maxResid))

## With this command sequence the first plot should generate a blank image
d_ply(lifeExpLM_extremesAgg, ~ continent, function(z){
  sContinent <- z$continent[1]
  p <- ggplot() + geom_point(data = subset(lifeExpLM_extremesAgg, continent == sContinent),
                             aes(x = year, y = lifeExp, color = extreme))
  p <- p + geom_abline(aes(intercept = int - m * yearMin, slope = m), 
                       data = subset(lifeExpLM_extremesAgg, continent == sContinent)) + 
    facet_wrap(~country) + 
    ggtitle(paste("Extreme Life Expectancy Trends in ", sContinent, sep = ""))  
  ggsave(filename = paste("res_extremeLifeExpectancy_",sContinent,".png", sep = ""), 
         plot = p, path = "Figures/Debug", width = 14.4, height = 10.9)
})

## Strange! This is a different resut than the same set of commands in an earlier file. 
## The only difference is the input data, where in the first file it was been sorted on a levels
## basis, however here there is no sorting. Levels and factors are evil. This still does not
## provide an answer for why in-console or console sourcing the other file works, whereas 
## R CMD BATCH fails...on the same file! Are the levels handled differently in different 
## environments? Does RStudio not use the same environment as R base? Afterall, RStudio should
## sit ontop of the base installation. 

## I have tired to implement a reorder in the other file but that has failed as well. 
## Since I have isolated the error to some data/levels/factor issue I don't think
## it is necessary to implement a base R graphics version of these charts. 


## Test for another continent outside of the d_ply call with ggsave 
## Note: including the plot argument, and not printing the image before

sContinent <- "Europe"

p <- ggplot() + geom_point(data = subset(lifeExpLM_extremesAgg, continent == sContinent),
                           aes(x = year, y = lifeExp, color = extreme))
p <- p + geom_abline(aes(intercept = int - m * yearMin, slope = m), 
                     data = subset(lifeExpLM_extremesAgg, continent == sContinent)) + 
  facet_wrap(~country) + 
  ggtitle(paste("Extreme Life Expectancy Trends in ", sContinent, sep = ""))  

ggsave(filename = paste("res_extremeLifeExpectancy_ggsave_noLoop",sContinent,".png", sep = ""), 
       plot = p, path = "Figures/Debug", width = 14.4, height = 10.9)

## Try with png

png(filename = paste("Figures/Debug/res_extremeLifeExpectancy_pngSaveOnlyPrint_noLoop",
                     sContinent,".png", sep = ""))  
print(p)
dev.off()

## Try with png, create the ggplot within the png call

png(filename = paste("Figures/Debug/res_extremeLifeExpectancy_pngGenerateInPNG_noLoop",
                     sContinent,".png", sep = ""))  
p <- ggplot() + geom_point(data = subset(lifeExpLM_extremesAgg, continent == sContinent),
                           aes(x = year, y = lifeExp, color = extreme))
p <- p + geom_abline(aes(intercept = int - m * yearMin, slope = m), 
                     data = subset(lifeExpLM_extremesAgg, continent == sContinent)) + 
  facet_wrap(~country) + 
  ggtitle(paste("Extreme Life Expectancy Trends in ", sContinent, sep = ""))  
print(p)
dev.off()



