# Set our directory
setwd("")

library(raster)
require(sp)
require(geodata)
library(maps) # To add political divisions
library(terra)


clim <- worldclim_global(var = "bio", res = 5, path = "")
clim

# Convert SpatRaster to RasterStack (RasterLayer for each variable)
clim_raster <- stack(clim)

# Read coordinates data
data <- read.csv(file="DataWithDecimalCoordinates.csv", header=TRUE)
attach(data)

# Extracting the latitude and longitude of each of the data points
lats <- data$Latitude
lons <- data$Longitude

# Creating a data frame with the latitude and longitude data
coords <- data.frame(x = lons, y = lats)

# This creates a object of class SpatialPoints from the coordinates data frame
points <- SpatialPoints(coords, proj4string = clim_raster@crs)

# Here we extract the data from WorldClim for the coordinates
values <- extract(clim_raster, points)

# Merge the extracted bio data with the coordinates
df <- cbind.data.frame(coordinates(points), values)

# Save the WoeldClim data in a new file
write.csv(df, "bio_data.csv")

# Shee some lines of the data file to check if everything is fine
head(df)


## here we merge together the bio data and the coordinates
    # df <- cbind.data.frame(coordinates(points), values)
    # write.csv(df, "bio_data.csv")

tempcol <- colorRampPalette(c("purple", "blue", "skyblue", "green", "lightgreen", 
                              "yellow", "orange", "red", "darkred"))


## Plotting the maps

#pdf("bio1_5_6.pdf", height = 10, width = 6)
  #par(mfrow = c(3, 1), mar = c(4.5, 4.5, 4.5, 4.5))

# xlim = Longitude and ylim = Latitude
plot(clim[[1]], xlim = c(-85, -66), ylim = c(0, 8),
     col = tempcol(100), main = "Bio 1", cex.main = 2, cex.axis = 1.2, cex.lab = 1.5,
     xlab = "Longitude", ylab = "Latitude")
map("world", add = TRUE, lwd = 1.5) # Use this function if you want to add the political divisions
plot(points, add = T)

