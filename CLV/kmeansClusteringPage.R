kmeansClusteringPage <- function() {
  fluidPage(
    # Application title
    titlePanel("K Means Clustering"),
    fluidRow(
      column(6,
             plotOutput("elbow_plot")
      ),
      column(6,
             plotOutput("cluster_plot")
      )
    )
  )
}