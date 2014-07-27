# Ben de Haan - Exploratory Data Analysis, Coursera

# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
# Using the base plotting system, make a plot showing the total PM2.5 emission from 
# all sources for each of the years 1999, 2002, 2005, and 2008

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

# Aggregate total Emissions per year
UnitedStatesEmissionsPerYear <- aggregate(Emissions ~ year, data = NEI, sum)

# Generate graph on screen
UnitedStatesEmissionsPerYearGraph <- plot(UnitedStatesEmissionsPerYear$year, 
     UnitedStatesEmissionsPerYear$Emissions, 
     type = "l",
     main = "Total US PM2.5 emission per year",
     xlab = "Year",
     ylab = "Total PM2.5 emission in tons")


# Generate PNG
png("plot1.png")

UnitedStatesEmissionsPerYearGraph <- plot(UnitedStatesEmissionsPerYear$year, 
                                          UnitedStatesEmissionsPerYear$Emissions, 
                                          type = "l",
                                          main = "Total US PM2.5 emission per year",
                                          xlab = "Year",
                                          ylab = "Total PM2.5 emission in tons")

dev.off()
