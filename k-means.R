#################################################################################################
## Image compression using k-means clustering ##
#################################################################################################

# install.packages("jpeg")
# install.packages("gridExtra")
# install.packages("ggplot2")

library(jpeg)
library(ggplot2)
library(grid)
require(gridExtra)

# Load Image.jpg
img <- readJPEG("Image.jpg") # Read the image

# Obtain Image dimension
imgDm <- dim(img)

# Assign RGB channels to data frame 
imgRGB <- data.frame(
  x = rep(1:imgDm[2], each = imgDm[1]),
  y = rep(imgDm[1]:1, imgDm[2]),
  R = as.vector(img[ , , 1]),
  G = as.vector(img[ , , 2]),
  B = as.vector(img[ , , 3])
)

# Obtain a plot of the original image
plotOriginal <- ggplot(data = imgRGB, aes(x = x, y = y)) + 
  geom_point(colour = rgb(imgRGB[c("R", "G", "B")])) + 
  labs(title = "Original Image")

# Compress the image using k-means clustering 
k <- 3 # Number of clusters, you can play with it to obtain different compression levels!
kMeans <- kmeans(imgRGB[, c("R", "G", "B")], centers = k) 
num.of.colours <- rgb(kMeans$centers[kMeans$cluster, ])

# Obtain a plot of the compressed image
plotCompressed <-ggplot(data = imgRGB, aes(x = x, y = y)) + 
  geom_point(colour = num.of.colours) + 
  labs(title = paste("k-Means Clustering of ", k, " Colours"))

# Plot the original and compressed image side by side
grid.arrange(plotOriginal, plotCompressed, nrow = 2)  
