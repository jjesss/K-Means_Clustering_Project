# K-Means_Clustering_Project
I have included a R file of my K-Means function to compress an image to k=16 colours.

## Description of the Model
K-Means clustering is an unsupervised learning algorithm characterized by its iterative process. It begins with an unlabeled dataset as input. Additionally, we define a set of points \(m_1, m_2, ..., m_k\) which represent the initial centroids. These centroids determine the number of "clusters" required.
Each data point is then assigned to the cluster with the nearest centroid, calculated using Euclidean distance. The Euclidean distance between two points, \(p\) and \(q\), on a real line is defined as:

d(p, q) = sqrt((p - q)^2)

This process continues iteratively, recalculating the centroids for the observations assigned to each cluster, until convergence is reached. Convergence occurs when the clustering no longer changes.

## Pseudo-code

**Input**: dataset, number of clusters

**Output**: labels of the data points, mean of label classes

1. Set the number of clusters, `k`, to the specified value.
2. Initialize `D` with the given dataset.
3. Determine the size of `D` and store it in `D_size`.
4. Randomly select `k` indices from `D` and assign them to `index`.
5. Initialize `centroids` with the corresponding rows from `D`.
6. Initialize an empty DataFrame `new_centroids`.
7. **While** `centroids` is not equal to `new_centroids`:
   1. Initialize an empty list `cluster`.
   2. **For** each data point `i` in `D`:
      - Calculate the minimum distance `min_dist` between the first centroid and `D[i]` using the Euclidean distance.
      - Assign `cluster[i]` as 1.
      - **For** each centroid `j` from 1 to `k`:
         - Calculate the current distance `current_dist` between `centroids[j]` and `D[i]` using the Euclidean distance.
         - **If** `current_dist` is less than or equal to `min_dist`:
            - Update `min_dist` to `current_dist`.
            - Assign `cluster[i]` as `j`.
   3. **If** the number of rows in `new_centroids` is not zero:
      - Copy the values from `new_centroids` to `centroids`.
   4. **For** each centroid `j` from 1 to `k`:
      - Initialize an empty list `cPoints`.
      - Find the indices of elements in `cluster` that belong to cluster `j` and store them in `cPoints`.
      - Calculate the mean of the corresponding rows in `D` and update `new_centroids[j]` with these values.
8. Store the clustering results and centroids in a list `km`.
9. **Return** `km`.

## Clustering As An Image Compression Tool
Image compression is an application of the K-means algorithm, used to reduce the dimension of an image and its storage space, without excessively deteriorating it. It works by taking the pixels of an image and applying the K-means algorithm to find k colours and assigning the data points(pixels) to these.

![image](https://github.com/jjesss/K-Means_Clustering_Project/assets/77901330/51d38965-ec9c-4af2-83fe-9c82797826d0)

As we can see from the above image, as k increases, the compression quality is higher as compared to when k is lower. For example with k = 30, the image quality is much better than when k = 3 or k = 16.
Since the human eye cannot differentiate all the different intensity values of RGB colours, we
can choose a k that is significantly smaller than the 24-bit (16.7 million colour valued) original image without noticing such a big difference in image quality. Consequently, by reducing the amount of colours in the image, we can reduce the size of the file and maintain the quality.

## Conclusion
In conclusion the K-Means algorithm is a simple clustering algorithm we can use in finding groups which have not been explicitly labelled in the data. This means it can be useful in many business situations such as giving businesses’ insight on the types of groups that exist or even identify unknown groups in complex data sets. As we have seen above, we can use k-means as an image compression tool. This can help web owners reduce image file sizes resulting in web pages loading much quicker. Website optimization through image compression is important especially with an increase in technology and social media. More and more people are becoming accustomed to fast loading sites and for this reason it is key to ecommerce success and directly influences engine rankings. Image compression is not the only type of grouping k-means can do. In fact k-means is very versatile and can group any type of data.

From this project, we have learnt how K-means has both advantages and disadvantages. K-means
is more efficient compared to some other algorithms due to it not having to compute the distances between all pairs of data points like some others do. Although there exists methods in finding an accurate estimate of k, such as the elbow point method as explained before, there is no method for determining the exact value. Thus possibly giving you an outcome that is misleading. Therefore, there should be consideration of use of other algorithms such as the BIRCH algorithm which is a hierarchical clustering algorithm that does not require you to pre-specify the number of clusters like k-means does.
