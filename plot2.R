##Changes of PM2.5 from all sources in US(using base plotting)

##data load
NEI <- readRDS('summarySCC_PM25.rds')
SCC <- readRDS('Source_Classification_Code.rds')

##subset only data of baltimore city
Baltimore <- subset(NEI, fips == '24510')

##Caculate Mean for each year in Baltimore City
Emit_Baltimore <- tapply(Baltimore$Emissions, Baltimore$year, sum)

##plotting graph in PNG file
png(filename='plot2.png', width = 480, height = 480)
plot(names(Emit_Baltimore), Emit_Baltimore, pch=19,
     xlab = 'Year',
     ylab='Total Emissions from PM2.5 in Baltimore(Tons)')

x0 <- as.integer(names(Emit_Baltimore)[1:3])
y0 <- Emit_Baltimore[1:3]
x1 <- as.integer(names(Emit_Baltimore)[2:4])
y1 <- Emit_Baltimore[2:4]
segments(x0, y0, x1, y1)
dev.off()

