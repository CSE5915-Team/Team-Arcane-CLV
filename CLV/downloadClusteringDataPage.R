#layout for download button
      
downloadClusterDataPage <- function(){
  
  fluidPage(
    downloadButton("downloadData", label = "Download Clustering Data")
  )
  
}      
      
      
