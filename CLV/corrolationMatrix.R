library("PerformanceAnalytics")

corrolationMatrix <- function(input, output, session, data) {
  numericData <- subset(data,
                        select = c(income_1_avg, income_2_avg, networth_1_avg,
                                   networth_2_avg, nght_cnt, tot_amt,
                                   gst_cnt_sum, customer_lifetime,
                                   churn_probabilities))
  chart.Correlation(numericData, histogram=TRUE, pch="+")
}
