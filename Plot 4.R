setwd("C:/Users/tandi/OneDrive/Desktop/Coursera/EDA W4/course project data")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
SCC.coal = SCC[(grepl(x = SCC$Short.Name, pattern = "Coal", ignore.case=TRUE)),]
NEI.coal = merge(NEI, SCC.coal, by = "SCC")

# Aggregate emissions
Emissions.coal <- aggregate(NEI.coal$Emissions, 
                            by=list(NEI.coal$year), 
                            FUN=sum)
names(Emissions.coal) = c("year","x")
Emissions.coal$group=rep("coal",nrow(Emissions.coal))

# Make the plot
png("plot4.png", width = 700, height = 400)
ggplot(Emissions.coal, aes(as.factor(year), x,
                           group = group,
                           label = round(x,digits = 0)))+
  xlab("Year") +
  ylab("PM2.5 emissions") +
  ggtitle("Total Coal-sourced PM 2.5 emission from 1998 to 2008") +
  geom_point(size = 3, shape = 2, show.legend  = TRUE) +
  geom_line(col="red", linetype = 2) +
  geom_text(check_overlap = TRUE, vjust = 1.2, hjust = 1.2)
dev.off()
