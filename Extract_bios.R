setwd("C:/Users/jhanc/Box/Investigacion/Investigaciones/Side projects/Anolis/CT/For_WorldClim")

require(raster)
require(sp)
require(geodata)

## Extracting the WorldClim data
clim <- getData('worldclim', var = 'bio', res = 5)
clim


## CT data
ct_data <- read.csv("Data_Coordinate_Oct_04_2021.csv", header = 1)

## Extracting the latitude and longitude of each of the data points
lats <- ct_data$LAT
lons <- ct_data$LONG

## Creating a data frame with the latitude and longitude data
coords <- data.frame(x = lons, y = lats)
coords

## This creates a object of class SpatialPoints from the coordinates data frame
points <- SpatialPoints(coords, proj4string = clim@crs)

# Here we extract the data from WorldClim for the coordinates
values <- extract(clim, points)

## here we merge together the bio data and the coordinates
    # df <- cbind.data.frame(coordinates(points), values)
    # write.csv(df, "bio_data.csv")

tempcol <- colorRampPalette(c("purple", "blue", "skyblue", "green", "lightgreen", 
                              "yellow", "orange", "red", "darkred"))


## Ploting the maps

#pdf("bio1_5_6.pdf", height = 10, width = 6)
  #par(mfrow = c(3, 1), mar = c(4.5, 4.5, 4.5, 4.5))

# xlim = Longitude and ylim = Latitude
plot(clim[[1]], xlim = c(-85, -66), ylim = c(0, 8),
     col = tempcol(100), main="Bio 1", cex.main = 2, cex.axis = 1.2, cex.lab = 1.5,
     xlab = "Longitude", ylab = "Latitude")
plot(points, add = T)

