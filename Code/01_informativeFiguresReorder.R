library(ggplot2)
library(plyr)

gDat <- read.delim("Data/gapminderDataFiveYear.txt")
# Check that data import went successfully
tail(gDat)

# Informative plot: life expectancy vs. GDP per capita for a particular year
q1 <- ggplot(gDat, aes(x = gdpPercap, y = lifeExp)) + geom_point() +
  scale_x_log10() + facet_wrap(~ continent) + geom_smooth(method = loess) + 
  ggtitle("Life Expectancy vs. GDP per Capita")

ggsave(filename = "inform_lifeExpectancyVsGdpPerCap_all_loessSmooth.pdf", plot = q1, path = "Figures", width = 14.4, height = 10.9)

# Another informative plot
sCountry <- c("United States", "Canada", "Mexico") # North America

q2 <- ggplot(data = within(subset(gDat, country %in% sCountry), country <- reorder(country, lifeExp))
             , aes(x = country, y = lifeExp)) + geom_boxplot() + geom_jitter() +
  ggtitle("Life Expectancy measures of spread for select countries")
ggsave(filename = "inform_lifeExpectancy_measuresOfSpread.pdf", plot = q1, path = "Figures", width = 14.4, height = 10.9)


# Informative plot: look at a particular year per continent
sYear <- 2002

q3 <- ggplot(subset(gDat, year == sYear),
            aes(x = gdpPercap, y = lifeExp)) + scale_x_log10()

q3 <- q3 + geom_point(aes(size = sqrt(pop/pi), fill = continent), pch = 21, show_guide = FALSE) +
            scale_size_continuous(range = c(1,40)) + facet_wrap(~continent) + 
            ggtitle(paste("Life Expectancy vs. GDP per Capita in ", sYear, sep = ""))

ggsave(filename = paste("inform_lifeExpectancyVsGdpPerCap_",sYear,".pdf", sep = ""), plot = q3, path = "Figures", width = 14.4, height = 10.9)

# Reorder the continents based on life expectancy, and clean data to remove Oceania 
cleanData <- droplevels(subset(gDat, continent != "Oceania"))
table(cleanData$continent)  #ensure that the factor has been dropped

cleanData <- within(cleanData, continent <- reorder(continent, lifeExp))
table(cleanData$continent)  #ensure that the factor has been reordered on lifeExp

# rearrange actual data
cleanData <- arrange(cleanData, continent)
write.table(cleanData, "Data/gapminder_clean.tsv", quote = FALSE, sep = "\t", row.names = FALSE) 

sessionInfo()
Sys.time()
