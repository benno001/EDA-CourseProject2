# Ben de Haan - Exploratory Data Analysis, Coursera

# Compare emissions from motor vehicle sources in Baltimore City with emissions 
# from motor vehicle sources in Los Angeles County, California (fips == "06037"). 
# Which city has seen greater changes over time in motor vehicle emissions?

# Initialize ggplot2 library
library(ggplot2)

# Download data
if(!file.exists("FNEI_data.zip")){
    download.file(
        url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", 
        destfile =   "FNEI_data.zip", 
        method = "curl")
}

# Unzip the data
if(!file.exists("Source_Classification_Code.rds")){
    unzip("FNEI_data.zip")    
}

# Read in the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Create vector for vehicle related emissions
SCC$isVehicleRelated <- (grepl("..Vehicle", SCC$EI.Sector, ignore.case = TRUE) | 
                             grepl("Vehicle..", SCC$EI.Sector, ignore.case = TRUE) | 
                             grepl("..Vehicle", SCC$EI.Sector, ignore.case = TRUE))

# Merge the two dataframes
NEI.Baltimore.LA.SCC <- merge(NEI[NEI$fips == "24510" | NEI$fips == "06037",], SCC)

# Select vehicle related emissions
vehicleEmissions <- NEI.Baltimore.LA.SCC[NEI.Baltimore.LA.SCC$isVehicleRelated,]

# Aggregate total Baltimore city and LA emissions from vehicle related sources per year
BaltimoreCityLAVehicleEmissionsPerYear <- aggregate(Emissions ~ year + fips, 
                                                    data = vehicleEmissions, 
                                                    sum)

# Generate graph on screen
qplot(year, 
      Emissions, 
      main = "Total Baltimore City and LA PM2.5 vehicle related emission per year",
      xlab = "Year",
      ylab = "Total PM2.5 emission in tons",
      data = BaltimoreCityLAVehicleEmissionsPerYear,
      color= fips,
      geom = "line",
) + scale_colour_discrete(name = "County", labels= c("Baltimore City","Los Angeles"))



# Generate PNG
png("plot6.png", width = 600)

# Generate graph
qplot(year, 
      Emissions, 
      main = "Total Baltimore City and LA PM2.5 vehicle related emission per year",
      xlab = "Year",
      ylab = "Total PM2.5 emission in tons",
      data = BaltimoreCityLAVehicleEmissionsPerYear,
      color= fips,
      geom = "line",
) + scale_colour_discrete(name = "County", labels= c("Baltimore City","Los Angeles"))



dev.off()
