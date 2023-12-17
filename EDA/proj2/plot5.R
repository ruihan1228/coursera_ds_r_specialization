# How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

# They have decreased by a lot.

setwd('~/Documents/coursera_ds_r_specialization/EDA/proj2')

NEI <- readRDS('summarySCC_PM25.rds')
SCC <- readRDS('Source_Classification_Code.rds')

head(NEI)
head(SCC)

baltimore <- subset(NEI, fips == '24510')

# get numbering in 'EI.Sector' for motor vehicle by finding both 'Mobile' and 'Vehicles',
# numbers are [21, 22, 23, 24] in 'unique(SCC$EI.Sector)' stored in 'both'
unique(SCC$EI.Sector)
mobile <- grep('Mobile',unique(SCC$EI.Sector))
vehicles <- grep('Vehicles',unique(SCC$EI.Sector))
both <- intersect(mobile, vehicles)

# get characters that are at numbering [21, 22, 23, 24] in 'unique(SCC$EI.Sector)'
# stored in 'mobile.vehicles', which are
# "Mobile - On-Road Gasoline Light Duty Vehicles" 
# "Mobile - On-Road Gasoline Heavy Duty Vehicles"
# "Mobile - On-Road Diesel Light Duty Vehicles"
# "Mobile - On-Road Diesel Heavy Duty Vehicles"  
mobile.vehicles <- unique(SCC$EI.Sector)[both]
mobile.vehicles <- as.character(mobile.vehicles)
mobile.vehicles 

# subset df SCC by EI.Sector == mobile.vehicles to get SCC numbers for later subsetting baltimore
mobile.vehicles.SCC <- subset(SCC, EI.Sector %in% mobile.vehicles)
dim(mobile.vehicles.SCC) # 1,138/11,717 are motor vehicles in SCC

# subset df baltimore by SCC == mobile.vehicles.SCC$SCC
mobile.vehicles.bt <- subset(baltimore, SCC %in% mobile.vehicles.SCC$SCC)
dim(mobile.vehicles.bt) # 1,119/6,497,651 are motor vehicles in baltimore

head(mobile.vehicles.bt)

p <- tapply(mobile.vehicles.bt$Emissions, mobile.vehicles.bt$year, sum)

plot(names(p), p,
     type = 'l',
     xlab = 'Year',
     ylab = 'Emissions',
     main = 'Total Emissions in Baltimore by Motor Vehicles per Year')

dev.print(png, 'plot5.png', width = 480, height = 480)
dev.off()