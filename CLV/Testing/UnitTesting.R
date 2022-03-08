
# make sure that testthat is installed before running install.packages("testthat")
library(testthat)
library(lintr)
library(dplyr)
library(lubridate)


# example of setup can be found at https://www.johndcook.com/blog/2013/06/12/example-of-unit-testing-r-code-with-testthat/

# give testthat the name of the file being tested
#source(")

source("~/College Courses/SP22/Capstone 5915/Team-Arcane-CLV/CLV/funcs_for_churning_data.R", local=TRUE)

test_that("modified dataframe 1", {

  max_arvl_dt <- c(ymd(20190829), ymd(20131029), ymd(20000407))
  diff_btwn_dates_in_days <- c(7083, 4953, 0)
  df = data.frame(max_arvl_dt)
  expect_equal(modify_data_for_ecdf(df)$diff_btwn_dates_in_days, diff_btwn_dates_in_days)
  
})

test_that("modified dataframe 2", {

  max_arvl_dt <- c(ymd(20000407))
  diff_btwn_dates_in_days <- c(0)
  df = data.frame(max_arvl_dt)
  expect_equal(modify_data_for_ecdf(df)$diff_btwn_dates_in_days, diff_btwn_dates_in_days)

})

test_that("add churn flag 1", {

  diff_btwn_dates_in_days <- c(7083, 4953, 0)
  ecdf_probabilities <- c(1.00000000, 0.66666667, 0.33333333)
  churn_flag <- c("Not Churn", "Not Churn", "Not Churn")
  df = data.frame(diff_btwn_dates_in_days)
  expect_equal(add_churn_flag(df)$churn_flag, churn_flag)
  expect_equal(add_churn_flag(df)$ecdf_probabilities, ecdf_probabilities)
  
})

test_that("add churn flag 2", {

  diff_btwn_dates_in_days <- c(10000, 7083, 8829, 4953, 0, 234, 20, 10232)
  ecdf_probabilities <- c(0.875, 0.625, 0.750, 0.500, 0.125, 0.375, 0.250, 1.000)
  churn_flag <- c("Not Churn", "Not Churn", "Not Churn", "Not Churn", "Churn", "Not Churn", "Not Churn", "Not Churn")
  df = data.frame(diff_btwn_dates_in_days)
  expect_equal(add_churn_flag(df)$churn_flag, churn_flag)
  expect_equal(add_churn_flag(df)$ecdf_probabilities, ecdf_probabilities)
  
})



test_that("generate churn data 1", {

  customer_id <- c(3, 1, 2)
  max_arvl_dt <- c(ymd(20190829), ymd(20131029), ymd(20000407))
  diff_btwn_dates_in_days <- c(7083, 4953, 0)
  churn_probabilities <- c((1-1.00000000), (1-0.66666667), (1-0.33333333))
  ecdf_probabilities <- c(1.00000000, 0.66666667, 0.33333333)
  churn_flag <- c("Not Churn", "Not Churn", "Not Churn")
  df = data.frame(customer_id, max_arvl_dt)
  modified_df = data.frame(customer_id, max_arvl_dt, diff_btwn_dates_in_days, churn_probabilities,
                           ecdf_probabilities, churn_flag)
  expect_equal(generate_after_churn_new_data(df), modified_df)
  
})

test_that("generate churn data 2", {
  
  customer_id <- c(1)
  max_arvl_dt <- c(ymd(20190829))
  diff_btwn_dates_in_days <- c(0)
  churn_probabilities <- c(0)
  ecdf_probabilities <- c(1.00000000)
  churn_flag <- c("Not Churn")
  df = data.frame(customer_id, max_arvl_dt)
  modified_df = data.frame(customer_id, max_arvl_dt, diff_btwn_dates_in_days, churn_probabilities,
                           ecdf_probabilities, churn_flag)
  expect_equal(generate_after_churn_new_data(df), modified_df)
  
})


