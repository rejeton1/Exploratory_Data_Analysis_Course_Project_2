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

##extract data in 2 cities
Baltimore <- subset(NEI, fips == '24510')
LA <- subset(NEI, fips == '06037')

##extract only data from motor vehicle sources in 2 Cities
motor_baltimore <- subset(Baltimore, SCC %in% SCC_of_Mobile)
motor_LA <- subset(LA, SCC %in% SCC_of_Mobile)

##calculating sum of emission of PM2.5 for each years
Emit_Baltimore <- tapply(motor_baltimore$Emissions, motor_baltimore$year, sum)
Emit_LA <- tapply(motor_LA$Emissions, motor_LA$year, sum)

##plotting graph in PNG file
s0 <- 1:3
s1 <- 2:4

png(filename='plot6.png', width = 960, height = 480)

par(mfrow = c(1,2), mar=c(4,4,6,4))
plot(names(Emit_Baltimore), Emit_Baltimore, pch=19, main = 'Baltimore City',
     ylab = 'Emission(tons)', xlab = 'Year')
segments(as.integer(names(Emit_Baltimore))[s0], (Emit_Baltimore)[s0], 
         as.integer(names(Emit_Baltimore))[s1], (Emit_Baltimore)[s1])

plot(names(Emit_LA), Emit_LA, pch=19, main = 'Los Angeles',
     ylab = 'Emission(tons)', xlab = 'Year')
segments(as.integer(names(Emit_LA))[s0], (Emit_LA)[s0], 
         as.integer(names(Emit_LA))[s1], (Emit_LA)[s1])
mtext('Total Emission of PM2.5 from motor vehicle sources in 2 Cities',
      side= 3, line = -2, outer = TRUE, cex = 1.5)


dev.off()

