# make sure that testthat is installed before running install.packages("shinytest")
library("shinytest")

# to test, call recordTest() with path to the app
recordTest("edaPage")

