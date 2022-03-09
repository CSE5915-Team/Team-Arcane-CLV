library("shinycssloaders")
kMode_clustering_page <- function() {
  fluidPage(
    titlePanel("K Mode Clustering"),
    fluidRow(
      plotOutput("kMode_Cluster_Plot") %>% withSpinner(type = 5)
    ),
    fluidRow(
      sliderInput("kMode_cluster_num",
                  label = "Number of Clusters",
                  min = 1,
                  max = 20,
                  value = 4,
                  width = "100%")
    )
  )
}