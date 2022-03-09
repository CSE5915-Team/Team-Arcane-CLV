library("shinycssloaders")
kmeansClusteringPage <- function() {
  fluidPage(
    # Application title
    titlePanel("K Means Clustering"),
    fluidRow(
      column(6,
             plotOutput("elbow_plot") %>% withSpinner(type = 5)
      ),
      column(6,
             plotOutput("kmeans_cluster_plot") %>% withSpinner(type = 5)
      )
    ),
    fluidRow(
      sliderInput("kmeans_cluster_num",
                  label = "Number of Clusters",
                  min = 1,
                  max = 20,
                  value = 4,
                  width = "100%")
    )
  )
}
