pam_clustering_page <- function() {
  fluidPage(
    titlePanel("PAM Clustering"),
    fluidRow(
      plotOutput("pam_cluster_plot") %>% withSpinner(type = 5)
    ),
    fluidRow(
      sliderInput("pam_cluster_num",
                  label = "Number of Clusters",
                  min = 1,
                  max = 20,
                  value = 4,
                  width = "100%")
    )
  )
}