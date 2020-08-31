setwd("C:/Users/tandi/OneDrive/Desktop/Coursera/EDA W4/course project data")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
Baltimore.NEI <- subset(NEI, fips=="24510" & type=="ON-ROAD")

# Aggregate emissions
Baltimore.Emissions.motor <- aggregate(Baltimore.NEI$Emissions, 
                                       by=list(Baltimore.NEI$year), 
                                       FUN=sum)
names(Baltimore.Emissions.motor)[1] <- "year"

# Make the plot with histogram
png("plot5.png", width = 700, height = 400)
ggplot(Baltimore.Emissions.motor,
       aes(as.factor(year), x,
           label = round(x,digits = 0),
           fill = as.factor(year)))+
  xlab("Year") +
  ylab("PM2.5 emissions") +
  ggtitle("Total vehicle PM 2.5 emission from 1998 to 2008\nBaltimore, MD") +
  geom_histogram(stat = "identity") +
  geom_text(vjust = 2) +
  scale_fill_discrete(name = "Year")
dev.off()
