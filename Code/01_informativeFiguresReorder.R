library(ggplot2)

gDat <- read.delim("Data/gapminderDataFiveYear.txt")
# Check that data import went successfully
tail(gDat)

# First informative plot: life expectancy vs. GDP per capita for a particular year
jYear <- 2002

q <- ggplot(subset(gDat, year == jYear),
            aes(x = gdpPercap, y = lifeExp)) + scale_x_log10()

q <- q + geom_point(aes(size = sqrt(pop/pi), fill = continent), pch = 21, show_guide = FALSE) +
            scale_size_continuous(range = c(1,40)) + facet_wrap(~continent) + 
            ggtitle(paste("Life Expectancy vs. GDP per Capita in ", jYear, sep = ""))

ggsave(filename = paste("inform_lifeExpectancyVsGdpPerCap_",jYear,".pdf", sep = ""), plot = q, path = "Figures")

# Second informative plot:

# look at some of the plots we have done in the past. 

# Reorder the continents based on life expectancy, and clean data to remove Oceania 
cleanData <- droplevels(subset(gDat, continent != "Oceania"))
table(cleanData$continent)  #ensure that the factor has been dropped

cleanData <- within(cleanData, continent <- reorder(continent, lifeExp))
table(cleanData$continent)  #ensure that the factor has been reordered on lifeExp


Write the sorted data to file for future use
write.table(cleanData, "Data/gapminder_clean.tsv", quote = FALSE, sep = "\t", row.names = FALSE) 

sessionInfo()
Sys.time()
