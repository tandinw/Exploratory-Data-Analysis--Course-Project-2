setwd("C:/Users/tandi/OneDrive/Desktop/Coursera/EDA W4/course project data")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
library(ggplot2)
### Only Baltimore, fips=="24510" and divide emission by "type"
Baltimore.NEI <- subset(NEI, fips=="24510")

# Aggregate emissions
Baltimore.Emissions <- aggregate(Baltimore.NEI$Emissions, 
                                 by=list(Baltimore.NEI$year), 
                                 FUN=sum)
names(Baltimore.Emissions)[1] <- "year"

# Make the plot and divide emission by "type"
png("plot3.png", width = 700, height = 400)
ggplot(Baltimore.NEI, aes(as.factor(year), log(Emissions), fill = type)) +
  xlab("Year") +
  ylab("log PM2.5 emissions") +
  ggtitle("PM 2.5 emission from 1998 to 2008 per type\n Baltimore City, MD") +
  geom_jitter(alpha=0.1) +
  geom_boxplot() +
  labs(fill = "Type") +
  facet_grid(. ~ type)
dev.off()
