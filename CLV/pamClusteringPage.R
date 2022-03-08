pamClusteringPage <- function() {
  fluidPage(
    titlePanel("PAM Clustering"),
    fluidRow(
      plotOutput("pam_cluster_plot")
    )
  )
}