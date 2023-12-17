# Compare emissions from motor vehicle sources in Baltimore City with emissions 
# from motor vehicle sources in Los Angeles County, California (fips == "06037")
# Which city has seen greater changes over time in motor vehicle emissions?

# LA

setwd('~/Documents/coursera_ds_r_specialization/EDA/proj2')

NEI <- readRDS('summarySCC_PM25.rds')
SCC <- readRDS('Source_Classification_Code.rds')

head(NEI)
head(SCC)

baltimore.la <- subset(NEI, fips == '24510' | fips == '06037')

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

# subset df SCC by EI.Sector == mobile.vehicles to get SCC numbers for later subsetting baltimore/LA
mobile.vehicles.SCC <- subset(SCC, EI.Sector %in% mobile.vehicles)
dim(mobile.vehicles.SCC) # 1,138/11,717 are motor vehicles in SCC

# subset df baltimore.la by SCC == mobile.vehicles.SCC$SCC
mobile.vehicles.btla <- subset(baltimore.la, SCC %in% mobile.vehicles.SCC$SCC)
dim(mobile.vehicles.btla) # 2,099/6,497,651 are motor vehicles in LA and Baltimore combined

head(mobile.vehicles.btla)

emis.btla <- mobile.vehicles.btla |>
  group_by(fips, year) |>
  summarise(Emissions = sum(Emissions))
head(emis.btla)

ggplot(emis.btla, aes(x = year, y = Emissions, group = fips, color = fips)) +
  geom_line() +
  labs(title = 'Total Emissions in Baltimore/LA by Motor Vehicles per Year') +
  scale_color_discrete(name="Locations",
                      breaks=c('06037', '24510'),
                      labels=c("LA County", "Baltimore"))

dev.print(png, 'plot6.png', width = 480, height = 480)
dev.off()