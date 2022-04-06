# Cox Regression Script
library("survival")
library("survminer")

print("Working")

cox_regression <- function() {
  # Fix churned_data
  flag <- c(gsub("Not 1", "0", gsub("Churn", "1", churned_data$churn_flag)))
  flag <- c("1", "0", "0", "0", "1")
  
  fixed_data <- with(churned_data, 
                      data.frame(
                        customer_lifetime = c(churned_data$customer_lifetime),
                        churn_flag = map(flag, strtoi)
                      ) 
                    )  
  
  print(fixed_data$churn_flag)
  print(c(1, 0, 0, 0, 1))
  
  res.cox <- coxph(Surv(customer_lifetime, churn_flag) ~ 1, data = fixed_data) 
  ggsurvplot(survfit(res.cox, data = fixed_data), color = "#2E9FDF", ggtheme = theme_minimal())
  print("DONE")
}