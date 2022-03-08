pam_clustering_page <- function() {
  fluidPage(
    titlePanel("PAM Clustering"),
    fluidRow(
      plotOutput("pam_cluster_plot")
    )
  )
}