k_mode_clustering_page <- function() {
  fluidPage(
    titlePanel("K Mode Clustering"),
    fluidRow(
      plotOutput("k_mode_cluster_plot") %>% withSpinner(type = 5)
    ),
    fluidRow(
      sliderInput("kMode_cluster_num",
                  label = "Number of Clusters",
                  min = 1,
                  max = 20,
                  value = 4,
                  width = "100%")
    ),
    fluidRow(
      h2("Churn ratios per cluster")
    ),
    fluidRow(
      tableOutput("kmode_table_plot")
    )
  )
}
