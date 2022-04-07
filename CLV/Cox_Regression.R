# Cox Regression Script
library("survival")
library("survminer")

cox_regression <- function(data) {
  res.cox <- coxph(Surv(customer_lifetime, churn_flag) ~ 1, data = churned_data) 
  coxPlot <- ggsurvplot(survfit(res.cox), data = churned_data, palette = "#2E9FDF", ggtheme = theme_minimal())
  
  #res.cox <- coxph(Surv(time, status) ~ 1, data = lung) 
  #coxPlot <- ggsurvplot(survfit(res.cox), data = lung, palette = "#2E9FDF", ggtheme = theme_minimal())
 
  return(coxPlot) 
}