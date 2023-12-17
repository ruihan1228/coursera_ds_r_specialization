# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland
# (fips == "24510") from 1999 to 2008? Use the base plotting system
# to make a plot answering this question.

# Yes they have in general.

setwd('~/Documents/coursera_ds_r_specialization/EDA/proj2')

NEI <- readRDS('summarySCC_PM25.rds')
SCC <- readRDS('Source_Classification_Code.rds')

head(NEI)

baltimore <- subset(NEI, fips == '24510')
bt.emis.year <- tapply(baltimore$Emissions, baltimore$year, sum)

plot(names(bt.emis.year), bt.emis.year,
     type = 'l',
     xlab = "Year",
     ylab = "Total Emissions",
     main = "Total Emissions by Year in Baltimore")

dev.print(png, 'plot2.png', width = 480, height = 480)
dev.off()
