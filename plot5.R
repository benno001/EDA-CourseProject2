# Ben de Haan - Exploratory Data Analysis, Coursera

# How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

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
NEI.Baltimore.SCC <- merge(NEI[NEI$fips == "24510",], SCC)

# Select vehicle related emissions
vehicleEmissions <- NEI.Baltimore.SCC[NEI.Baltimore.SCC$isVehicleRelated,]

# Aggregate total Baltimore City emissions from vehicle related sources per year
BaltimoreCityVehicleEmissionsPerYear <- aggregate(Emissions ~ year, 
                                                        data = vehicleEmissions, 
                                                        sum)

# Generate graph on screen
qplot(year, 
      Emissions, 
      main = "Total Baltimore City PM2.5 vehicle related emission per year",
      xlab = "Year",
      ylab = "Total PM2.5 emission in tons",
      data = BaltimoreCityVehicleEmissionsPerYear,
      geom = "line")


# Generate PNG
png("plot5.png")

# Generate graph
qplot(year, 
      Emissions, 
      main = "Total Baltimore City PM2.5 vehicle related emission per year",
      xlab = "Year",
      ylab = "Total PM2.5 emission in tons",
      data = BaltimoreCityVehicleEmissionsPerYear,
      geom = "line")

dev.off()
