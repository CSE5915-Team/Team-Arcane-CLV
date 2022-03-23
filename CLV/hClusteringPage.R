library("shinycssloaders")
h_clustering_page <- function() {
  fluidPage(
    titlePanel("Hierarchical Clustering"),
    fluidRow(
      plotOutput("h_cluster_plot") %>% withSpinner(type = 5)
    )
    )
}