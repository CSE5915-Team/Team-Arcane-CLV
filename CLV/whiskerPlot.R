whiskerPlot <- function(data) {
  a <- data[["income_1_avg"]]
  b <- data[["income_2_avg"]]
  c <- data[["nght_cnt"]]
  d <- data[["nght_cnt"]]
  #a <- subset(data, select = c(income_1_avg))
  #b <- subset(data, select = c(income_1_avg))
  #c <- subset(data, select = c(nght_cnt))
  #d <- subset(data, select = c(nght_cnt))
    
  aframe <- list(a, b, c, d)
  
  # We call boxplot with single vector
  whiskerPlot <- boxplot(aframe, horizontal=FALSE, varwidth=TRUE, notch=FALSE, range=1.5,
          outline=TRUE, 
          names=c("Churned Tot Income","Non-Churned Tot Income","Churned Night Count",
                  "Non-Churned Night Count"),
          boxwex=0.3, border=c("blue"), col=c("red"))
  
  return(whiskerPlot)
}