##Changes of PM2.5 from each sources in Baltimore City(using ggplot2)

##load needed package
install.packages('ggplot2')
library(ggplot2)

##data load
NEI <- readRDS('summarySCC_PM25.rds')
SCC <- readRDS('Source_Classification_Code.rds')

##subset only data of baltimore city
Baltimore <- subset(NEI, fips == '24510')

##subset data for each type of sources
Point <- subset(Baltimore, type == 'POINT')
NonPoint <- subset(Baltimore, type == 'NONPOINT')
OnRoad <- subset(Baltimore, type == 'ON-ROAD')
NonRoad <- subset(Baltimore, type == 'NON-ROAD')

##Caculate Mean for each source and year in Baltimore City
Emit_Point <- tapply(Point$Emissions, Point$year, sum)
Emit_NonPoint <- tapply(NonPoint$Emissions, NonPoint$year, sum)
Emit_OnRoad <- tapply(OnRoad$Emissions, OnRoad$year, sum)
Emit_NonRoad <- tapply(NonRoad$Emissions, NonRoad$year, sum)

##Make dataframe containing Emission for each sources and years
Baltimore_sum <- as.data.frame(matrix(nrow=16, ncol=3))
names(Baltimore_sum) <- c('Type', 'Emissions', 'Year')
Types <- c('Point', 'NonPoint', 'OnRoad', 'NonRoad')
Baltimore_sum$Type <- rep(Types, each=4)
Baltimore_sum$Year <- rep(c(1999, 2002, 2005, 2008),4)
Baltimore_sum$Emissions <- c(Emit_Point, Emit_NonPoint,
                             Emit_OnRoad, Emit_NonRoad)

##plotting graph in PNG file
png(filename='plot3.png', width = 960, height = 480)

par('mfrow'=c(1,4))
g <- ggplot(Baltimore_sum, aes(Year, Emissions))
g + geom_line(mapping = aes(group=Type)) + 
geom_point() + facet_grid(.~Type) + 
labs(title = 'Total Emssion of PM2.5 for 4 types of source 
                                    in Baltimore City') +
labs(x = 'Year', y = 'Total Emission(Tons)') + 
theme(plot.title=element_text(hjust=0.5))

dev.off()

