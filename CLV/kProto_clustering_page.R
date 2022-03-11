k_proto_clustering_page <- function() {
  fluidPage(
    titlePanel("K Prototype Clustering"),
    fluidRow(
      plotOutput("k_proto_cluster_plot") %>% withSpinner(type = 5)
    ),
    fluidRow(
      sliderInput("kProto_cluster_num",
                  label = "Number of Clusters",
                  min = 1,
                  max = 20,
                  value = 4,
                  width = "100%")
    )
  )
}
