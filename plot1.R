##Changes of PM2.5 from all sources in US(using base plotting)

##data load
NEI <- readRDS('summarySCC_PM25.rds')
SCC <- readRDS('Source_Classification_Code.rds')

##Caculate Mean for each year
Emit_each_year <- tapply(NEI$Emissions, NEI$year, sum)

##plotting graph in PNG file
png(filename='plot1.png', width = 480, height = 480)
plot(names(Emit_each_year), Emit_each_year, pch=19,
     xlab = 'Year',
     ylab='Total Emissions from PM2.5(Tons)')

x0 <- as.integer(names(Emit_each_year)[1:3])
y0 <- Emit_each_year[1:3]
x1 <- as.integer(names(Emit_each_year)[2:4])
y1 <- Emit_each_year[2:4]
segments(x0, y0, x1, y1)
dev.off()

