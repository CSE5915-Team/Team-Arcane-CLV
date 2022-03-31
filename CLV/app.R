#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(plotly)
library(hrbrthemes)
library(showtext)
library(tidyverse)
library(lintr)
library(cluster)
library(klaR)
library(fpc)
library(shinycssloaders)
library(shinytest)
library(factoextra)
library(clustMixType)
library(lintr)
font_add("Arial Narrow", regular = "ARIALN.TTF")
font_add("Arial", regular = "arial.ttf")
showtext_auto()

source("preprocess.R", local = TRUE)
# generate clean data
generate_clean_data()

source("edaPage.R", local = TRUE)
source("aboutPage.R", local = TRUE)
source("edaAfterChurnPage.R", local = TRUE)
source("kmeansClusteringPage.R", local = TRUE)
source("pamClusteringPage.R", local = TRUE)
source("kMode_clustering_page.R", local = TRUE)
source("kProto_clustering_page.R", local = TRUE)
source("corrolationMatrixWhiskerPage.R", local = TRUE)
source("hClusteringPage.R", local = TRUE)

source("eda_plot1_func.R", local = TRUE)
source("eda_plot2_func.R", local = TRUE)
source("eda_plot3_func.R", local = TRUE)

source("funcs_for_churning_data.R", local = TRUE)
source("churn_eda_plot1_func.R", local = TRUE)
source("churn_eda_plot2_func.R", local = TRUE)
source("churn_eda_plot3_func.R", local = TRUE)
source("corrolationMatrix.R", local = TRUE)
source("kMeans_Clustering.R", local = TRUE)
source("kmeans_Cluster_analysis.R", local = TRUE)
source("kProto_Clustering.R", local = TRUE)
source("kproto_Cluster_analysis.R", local = TRUE)
source("pam_Clustering.R", local = TRUE)
source("pam_Cluster_analysis.R", local = TRUE)
source("kMode_Clustering.R", local = TRUE)
source("kmode_cluster_analysis.R", local = TRUE)
source("kMeans_Clustering_Elbow.R", local = TRUE)
source("churn_vs_not_churn_plot_render.R", local = TRUE)
source("ecdf_plot_func.R", local = TRUE)
source("h_clustering.R", local = TRUE)
source("whiskerPlot.R", local = TRUE)
source("downloadClusteringDataPage.R", local = TRUE)


data <- read.csv("Cleandata.csv")
generate_after_churn_new_data(data, 0.2)
churned_data <- read.csv("Cleandata_after_churn.csv")

# Define UI for application that draws a histogram
ui <- navbarPage("Customer Lifetime Value",
  tabPanel("About", about_page()),
  tabPanel("EDA", eda_page()),
  tabPanel("EDA After Churn", eda_after_churn_page()),
  tabPanel("Correlation", corrolation_matrix_whisker_page()),
  navbarMenu("Clustering",
    tabPanel("K Means", kmeansClusteringPage()),
    tabPanel("PAM", pam_clustering_page()),
    tabPanel("K Mode", k_mode_clustering_page()),
    tabPanel("K Proto", k_proto_clustering_page()),
    tabPanel("K Hierarchical", h_clustering_page()),
    tabPanel("Download Clustering Data Page", downloadClusterDataPage())
  )
)
  

# Define server logic required to draw a histogram
server <- function(input, output, session) {
  print("Plot Rendering Beginning.")
  output$plot_render_1 <- plot1_server(input, output, session)
  output$plot_render_2 <- plot2_server(input, output, session)
  output$plot_render_3 <- plot3_server(input, output, session)

  #modify data to add churn metrics
  output$ecdf_plot_render <- ecdf_plot_server(churned_data)
  output$churn_vs_not_churn_plot_render <-
    churn_vs_not_churn_plot_server(churned_data)

  #Plots for all the graphs based on the churned data
  output$churn_lifetime <-
    churn_plot1_server(input, output, session, churned_data)
  output$churn_amount <-
    churn_plot2_server(input, output, session, churned_data)
  output$churn_night_cnt <-
    churn_plot3_server(input, output, session, churned_data)
  #Plots correlation matrix/whisker plots
  output$corrolation_matrix <- renderPlot(corrolationMatrix(churned_data))
  output$whisker_plot <- renderPlot(whiskerPlot(churned_data))
  
  
  #plots for clustering
  output$elbow_plot <-
    renderPlot(kMeansElbow(input, output, session, churned_data))
  output$kmeans_cluster_plot <-
    renderPlot(k_means_cluster(input, output, session, churned_data))
  output$kmeans_table_plot <- 
    renderTable(kmeans_cluster_table(input, output, session, churned_data))
  
  output$pam_cluster_plot <-
    renderPlot(pam_cluster(input, output, session, churned_data))
  output$pam_table_plot <- 
    renderTable(pam_cluster_table(input, output, session, churned_data))
  
  output$k_mode_cluster_plot <-
    renderPlot(k_mode_cluster(input, output, session, churned_data))
  output$kmode_table_plot <- 
    renderTable(kmode_cluster_table(input, output, session, churned_data))
  
  output$k_proto_cluster_plot <-
    renderPlot(k_proto_cluster(input, output, session, churned_data))
  output$kproto_table_plot <- 
    renderTable(kproto_cluster_table(input, output, session, churned_data))
  
  output$h_cluster_plot <-
    renderPlot(h_cluster(input, output, session, churned_data))
  
  # files for each cluster
  pam <- read.csv("pam.csv")
  colnames(pam) <- c('ID','Pam Cluster')  
  kmeans <- read.csv("kmeans.csv")
  colnames(kmeans) <- c('ID','K Means')
  kmode <- read.csv("kmode.csv")
  colnames(kmode) <- c('ID','K Modes')
  kproto <- read.csv("kproto.csv")
  colnames(kproto) <- c('ID','K Prototype')
  
  
  # combined into one cluster dataframe
  cluster_data <- downloadClusterData(kmeans, pam, kmode, kproto)
  
  #create download button
  output$downloadData <- downloadHandler(
    filename = function() {
      paste('data-', Sys.Date(), '.csv', sep='')
    },
    content = function(file) {
      write.csv(cluster_data, file)
    }
  )
  
  print("Plot Rendering Done.")
}

# Run the application
shinyApp(ui, server)
