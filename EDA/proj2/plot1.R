# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
# Using the base plotting system, make a plot showing the total PM2.5 emission 
# from all sources for each of the years 1999, 2002, 2005, and 2008.

# Yes they have decreased.

setwd('~/Documents/coursera_ds_r_specialization/EDA/proj2')

NEI <- readRDS('summarySCC_PM25.rds')
SCC <- readRDS('Source_Classification_Code.rds')

head(NEI)

emis.year <- tapply(NEI$Emission, NEI$year, sum)

plot(names(emis.year), emis.year,
     type = 'l',
     xlab = 'Year',
     ylab = 'Total Emissions',
     main = 'Total Emissions by Year')

dev.print(png, 'plot1.png', width = 480, height = 480)
dev.off()

