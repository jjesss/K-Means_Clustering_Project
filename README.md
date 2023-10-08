# K-Means_Clustering_Project
Within this report we will be discussing clustering and more specifically, K-means clustering and the use of this model for image compression. K-means clustering is used in order “to get an intuition about the structure of the data,” and is an unsupervised learning algorithm because we do not know the labels of the training data. “The goal is to therefore learn to detect patterns in the data and exploit them.”. This works by “following a simple procedure of classifying a given data set into a number of k-clusters.”. This is so we can understand more about the data provided, by separating it into k different groups. This report will also include a discussion on the benefits and shortcomings of K-means clustering, along with a pseudocode, description of the model and how it works. We will also include an application of K-means clustering to compress an image to k=16 colours through the implementation of two R codes; one which performs K-means with one iteration
and the second which converges.

## Benefits and Shortcomings of K-means Clustering
### Advantages
K-Means is known for being a relatively simple algorithm, not too complex to implement. This
is because it uses only a distance-calculation method (Euclidean distance usually) and the data
set. The algorithm is also suitable for large data sets, being faster than other methods (such as
hierarchical algorithms). This can be proved by considering K-means time complexity, which is
linear, compared to other clustering methods

| Clustering Method | Time Complexity | Notations  |
| :-----------: | :------------: | :------------: |
| K-means       |    O(n*k*l) = O(n)      |n = no. of samples, k = no. of clusters, l = no. of iterations|
|Hierarchical      |    O(n^3)     |         |
|The Expectation Maximization     |    O(m*n^3)     |      m = no. of iterations, n = no. of parameters   |
|K-medoid     |    O(n^2)     |         |
<figure 1>
  <figcaption>Figure 1: Time Complexity of Clustering Methods </figcaption>
</figure>

### Disadvantages
The K-means algorithm is sensitive when it comes to picking the initial clusters, sometimes leading to the variance of the outcome being high (e.g.: one cluster might include too many data points, while another cluster less). Thus, the algorithm needs to be performed again in order to obtain a better variance. The idea behind this is that even though K-means always converges, it only
reaches a local minimum . Thus, it might never reach a global minimum because considering
all the possible combinations of initial clusters is time consuming. This is another disadvantage as the results might be wrong due to the dependence on the initial clusters. For example, the cen-
troids are too close to each other. Therefore, after several iterations, the algorithm could reach a state which completely contradicts the apparent clusters. To avoid this, there can be some condi-
tions we can have on choosing the initial centroids, such as a minimum distance between the clusters.

Another disadvantage is that it can be difficult to pick the number of clusters. This is an assumption of the K-means algorithm that might, or might not, prove successful. Picking a too large or a too small number of clusters might fail to accomplish the whole objective of the algorithm: to gather data points with similar characteristics, analyse them and use them to make future predictions. For example, if we have a data set containing characteristics of a virus and assuming there are only three variants of the virus, when there are actually four.
Therefore prior knowledge of the dataset such as the number of clusters is needed to be most
accurate as we can choose the wrong k and get inaccurate results. To choose k, we can use the
Elbow method. This method calculates the k-means algorithm with different values of k and looks
for an abrupt change in the results. However it may not always work for datasets that are not very clustered and are evenly distributed. The curve in this case will be smooth and it will be difficult to decide on what k to choose. Other alternative methods are available such as the silhouette coefficient of the gap statistic.

## Description of the Model
K-Means clustering is an unsupervised learning algorithm characterized by its iterative process. It begins with an unlabeled dataset as input. Additionally, we define a set of k means \(m_1, m_2, ..., m_k\) which represent the initial centroids. These centroids determine the number of "clusters" required.

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
Image compression is an application of the K-means algorithm, used to reduce the dimension of an
image and its storage space, without excessively deteriorating it. It works by taking the pixels of an image and applying the K-means algorithm to find k colours and assigning the data points(pixels) to these.

![image](https://github.com/jjesss/K-Means_Clustering_Project/assets/77901330/51d38965-ec9c-4af2-83fe-9c82797826d0)

As we can see from the above image, as k increases, the compression quality is higher as compared to when k is lower. For example with k = 30, the image quality is much better than when k = 3 or k = 16.
Since the human eye cannot differentiate all the different intensity values of RGB colours, we
can choose a k that is significantly smaller than the 24-bit (16.7 million colour valued) original image without noticing such a big difference in image quality. Consequently, by reducing the amount of colours in the image, we can reduce the size of the file and maintain the quality.

## Conclusion
In conclusion the K-Means algorithm is a simple clustering algorithm we can use in finding groups which have not been explicitly labelled in the data. This means it can be useful in many business situations such as giving businesses’ insight on the types of groups that exist or even identify unknown groups in complex data sets. As we have seen above, we can use k-means as an image compression tool. This can help web owners reduce image file sizes resulting in web pages loading much quicker. Website optimization through image compression is important especially with an increase in technology and social media. More and more people are becoming accustomed to fast loading sites and for this reason it is key to ecommerce success and directly influences engine rankings. Image compression is not the only type of grouping k-means can do. In fact k-means is very versatile and can group any type of data.

From this project, we have learnt how K-means has both advantages and disadvantages. K-means
is more efficient compared to some other algorithms due to it not having to compute the distances between all pairs of data points like some others do. Although there exists methods in finding an accurate estimate of k, such as the elbow point method as explained before, there is no method for determining the exact value. Thus possibly giving you an outcome that is misleading. Therefore, there should be consideration of use of other algorithms such as the BIRCH algorithm which is a hierarchical clustering algorithm that does not require you to pre-specify the number of clusters like k-means does.
