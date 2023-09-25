##Changes of PM2.5 from motor vehicle sources in Baltimore City.

##load needed package
install.packages('ggplot2')
install.packages('tidyverse')
library(ggplot2)
library(tidyverse)

##data load
NEI <- readRDS('summarySCC_PM25.rds')
SCC <- readRDS('Source_Classification_Code.rds')

##find SCC of motor vehicle sources
contain <- str_detect(SCC$EI.Sector, 'Mobile')
SCC_of_Mobile <- SCC$SCC[contain]

##extract data in Baltimore city
Baltimore <- subset(NEI, fips == '24510')

##extract only data from motor vehicle sources in Baltimore City
motor_baltimore <- subset(Baltimore, SCC %in% SCC_of_Mobile)

##calculating sum of emission of PM2.5 for each years
Emit_each_year <- tapply(motor_baltimore$Emissions, motor_baltimore$year, mean)

##plotting graph in PNG file
x0 <- as.integer(names(Emit_each_year)[1:3])
x1 <- as.integer(names(Emit_each_year)[2:4])
y0 <- Emit_each_year[1:3]
y1 <- Emit_each_year[2:4]
png(filename='plot4.png', width = 480, height = 480)
plot(names(Emit_each_year), Emit_each_year, pch=19, main = 'Average Emission of PM2.5
     from motor vehicle sources in Baltimore City',
     ylab = 'Emission(tons)', xlab = 'Year')
segments(x0, y0, x1, y1)

dev.off()

