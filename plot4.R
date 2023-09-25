##Changes of PM2.5 from coal combustion-related sources in US

##load needed package
install.packages('ggplot2')
install.packages('tidyverse')
library(ggplot2)
library(tidyverse)

##data load
NEI <- readRDS('summarySCC_PM25.rds')
SCC <- readRDS('Source_Classification_Code.rds')

##find SCC of coal combustion-related sources
contain <- str_detect(SCC$EI.Sector, 'Coal') & str_detect(SCC$EI.Sector, 'Comb')
SCC_of_comb_coal <- SCC$SCC[contain]

##extract only coal combustion-related data
true <- NEI$SCC %in% SCC_of_comb_coal
comb_coal_NEI <- NEI[true,]

##calculating sum of emission of PM2.5 for each years
Emit_each_year <- tapply(comb_coal_NEI$Emissions, comb_coal_NEI$year, sum)

##plotting graph in PNG file
x0 <- as.integer(names(Emit_each_year)[1:3])
x1 <- as.integer(names(Emit_each_year)[2:4])
y0 <- Emit_each_year[1:3]
y1 <- Emit_each_year[2:4]
png(filename='plot4.png', width = 480, height = 480)
plot(names(Emit_each_year), Emit_each_year, pch=19, main = 'Total Emission of PM2.5
     from coal combustion-related sources in US',
     ylab = 'Emission(tons)', xlab = 'Year')
segments(x0, y0, x1, y1)

dev.off()

