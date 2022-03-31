library("shinycssloaders")
h_clustering_page <- function() {
  fluidPage(
    titlePanel("Hierarchical Clustering"),
    fluidRow(
      plotOutput("h_cluster_plot") %>% withSpinner(type = 5)
    ),
    fluidRow(
      sliderInput("H_cluster_num",
                  label = "Number of Clusters",
                  min = 1,
                  max = 20,
                  value = 4,
                  width = "100%")
    )
  )
}