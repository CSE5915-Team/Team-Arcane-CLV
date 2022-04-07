k_proto_cluster <- function(input, output, session, df) {
  # can play around with changing what variables are facotors or numerics
  
  k_proto_cluster <- kproto(df, k = input$kProto_cluster_num, iter.max = 10)
  k_proto_cluster_plot <- clusplot(df, k_proto_cluster$cluster,
                                  color = TRUE, shade = TRUE, lines = 2,
                                  span = TRUE, stand = TRUE, labels = 1)
  
  

  x <- k_proto_cluster$cluster
  write.csv(x, "kproto.csv")
  
  return(k_proto_cluster_plot)
}

k_proto_df <- function(data){
  x1 <- as.factor(data$hshold_lifestage_last)
  x2 <- as.numeric(data$income_1_avg)
  x3 <- as.numeric(data$income_2_avg)
  x4 <- as.numeric(data$networth_1_avg)
  x5 <- as.numeric(data$networth_2_avg)
  x8 <- as.numeric(data$nght_cnt)
  x9 <- as.numeric(data$tot_amt)
  x10 <- as.numeric(data$customer_lifetime)
  df <- data.frame(x1, x2, x3, x4, x5, x8, x9, x10)
  
  return(df)
}