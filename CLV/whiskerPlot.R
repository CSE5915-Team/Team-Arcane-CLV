whiskerPlot <- function(data) {
  churn_data <- subset(data, churn_flag = "Churn")
  not_churn_data <- subset(data, churn_flag = "Not Churn")
  a <- churn_data[["income_1_avg"]]
  b <- not_churn_data[["income_2_avg"]]
  c <- churn_data[["nght_cnt"]]
  d <- not_churn_data[["nght_cnt"]]
    
  aframe <- list(a, b, c, d)
  
  # We call boxplot with single vector
  whiskerPlot <- boxplot(aframe, horizontal=FALSE, varwidth=TRUE, notch=FALSE, range=1.5,
          outline=TRUE, 
          names=c("Churn Tot Income","Not Churn Tot Income","Churn Night Cnt",
                  "Not Churn Night Cnt"),
          boxwex=0.3, border=c("blue"), col=c("red"))
  
  return(whiskerPlot)
}