library(lintr)
library(dplyr)
library(lubridate)

max_arvl_dt <- c(ymd(20190829), ymd(20131029), ymd(20000407))
diff_btwn_dates_in_days <- c(7083, 4953, 0)
df = data.frame(max_arvl_dt)
modify_data_for_ecdf(df)


diff_btwn_dates_in_days <- c(7083, 4953, 0)
ecdf_probabilities <- c(1.00000000, 0.66666667, 0.33333333)
churn_flag <- c(0, 0, 0)
df = data.frame(diff_btwn_dates_in_days)
add_churn_flag(df)

customer_id <- c(3, 1, 2)
max_arvl_dt <- c(ymd(20190829), ymd(20131029), ymd(20000407))
diff_btwn_dates_in_days <- c(7083, 4953, 0)
churn_probabilities <- c((1-1.00000000), (1-0.66666667), (1-0.33333333))
ecdf_probabilities <- c(1.00000000, 0.66666667, 0.33333333)
churn_flag <- c(0, 0, 0)
df = data.frame(customer_id, max_arvl_dt)
generate_after_churn_new_data(df)



