library(jpeg)
library(ggplot2)
library(grid)
require(gridExtra)

# Load Image.jpg
# Ensure that your Image.jpg file is in your working directory
# You can modify the working directory using setwd(), e.g.
# setwd("~/Desktop/MATH336/Project/")
img <- readJPEG("Image.jpg") # Read the image
img <- readJPEG("Image3.jpg")

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
#kMeans <- kmeans(imgRGB[, c("R", "G", "B")], centers = k) 
kmeans1 = function(dataset, number_of_clusters){
  #D <- imgRGB[, c("R", "G", "B")]
  #k=3
  #initialize
  k <- number_of_clusters
  D <- dataset
  D_size <- nrow(D)
  index <- sample(nrow(D),k)
  centroids <- D[index, ]
  #new_centroid <- matrix(ncol=3)
  new_centroids <- data.frame(R=double(),G=double(),B=double())
  
  
  #!centroids.equals(new_centroids)
  while (!identical(centroids,new_centroids)){
    # cluster is the centroid datapoint is assigned to
    cluster = c()
    for(i in 1:D_size){
      # initialize empty label vector 
      
      # set min distance to the first centroid of that datapoint
      min_dist = dist(rbind(centroids[1, ],D[i, ]), method = "euclidean")
      #min_dist = sqrt(sum((centroids[1,]-D[i,])^2))
      # the min distance set for centroid 1 as defult
      cluster[i] = 1
      # for each centroid...
      for(j in 1:k){
        # calc euclidean dist between it and the datapoints
        current_dist = dist(rbind(centroids[j, ],D[i, ]), method = "euclidean")
        # if its the smallest dist...
        if(current_dist <= min_dist){
          # update the min distance of that datapoint
          min_dist = current_dist
          # add the cluster to vector of labels corresponding to each datapoint
          cluster[i] = j
          #eg: 1,2,3,2,2,1,2,3
        }
      }
    }
    #head(cluster)
    #tail(cluster)
    
    # update centroids if we have changed new centroid
    #any(!is.na(new_centroid))
    if(dim(new_centroids)[1] != 0){
      centroids = new_centroids
    }
    
    for(j in 1:k){
      cPoints = c()
      # index of the datapoints in cluster k
      cPoints <- which(cluster %in% j)
      
      # set mean to be new centroid of cluster 
      #new_centroid[k,] <- colMeans(x[cPoints,])
      new_centroids[j, ] <- colMeans(D[cPoints,])
    }
    
  }
  
  # only need to return clusters and centers(centroids)
  km <- list(cluster = cluster,centers = centroids)
  
  return(km)
}

kmeans3 <- kmeans1(imgRGB[, c("R", "G", "B")],number_of_clusters =3)
kmeans16 <- kmeans1(imgRGB[, c("R", "G", "B")],number_of_clusters =16)
kmeans20 <- kmeans1(imgRGB[, c("R", "G", "B")],number_of_clusters =20)

num.of.colours3 <- rgb(kmeans3$centers[kmeans3$cluster, ])
num.of.colours16 <- rgb(kmeans16$centers[kmeans16$cluster, ])
num.of.colours20 <- rgb(kmeans20$centers[kmeans20$cluster, ])

# Obtain a plot of the compressed image
plotCompressed3 <-ggplot(data = imgRGB, aes(x = x, y = y)) + 
  geom_point(colour = num.of.colours3) + 
  labs(title = paste("k-Means Clustering of ", 3, " Colours"))

plotCompressed16 <-ggplot(data = imgRGB, aes(x = x, y = y)) + 
  geom_point(colour = num.of.colours16) + 
  labs(title = paste("k-Means Clustering of ", 16, " Colours"))

plotCompressed20 <-ggplot(data = imgRGB, aes(x = x, y = y)) + 
  geom_point(colour = num.of.colours20) + 
  labs(title = paste("k-Means Clustering of ", 20, " Colours"))



# Plot the original and compressed image side by side
grid.arrange(plotOriginal, plotCompressed3, plotCompressed16,plotCompressed20,  nrow = 2)  

