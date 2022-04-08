cluster_df <- function(data){
  df <- subset(data,
               select = c(income_1_avg, income_2_avg, networth_1_avg,
                          networth_2_avg, nght_cnt, tot_amt,
                          gst_cnt_sum, new_lifestage_id, churn_flag))
  return(df)
}