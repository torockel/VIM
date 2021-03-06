# some basic tests for hotdeck
# 
# Author: alex
###############################################################################
set.seed(104)
df <- data.frame(unit_id=101:104, state=rep("NSW",4), wages01=c(NA,NA,NA,229305),r=runif(4))
df2 <- data.frame(unit_id=c(NA,101:104), state=rep("NSW",5), wages01=c(NA,NA,NA,2434,229305),r=runif(5),
                  fac=c(NA,NA,"a","b","c"))

test_that("hotdeck should fill all values", {
  df.out <- hotdeck(df, variable="wages01", domain_var="state")
  expect_identical(df.out,na.omit(df.out))
})

test_that("matchImpute should fill all values", {
  set.seed(104)
  df.out2 <- matchImpute(df, variable="wages01",match_var="state")
  expect_identical(df.out2,na.omit(df.out2))
})

test_that("hotdeck should fill all values but give a warning", {
  set.seed(104)
  expect_warning(df.out <- hotdeck(df, variable="wages01", domain_var="state",ord_var = "r"))
  expect_identical(df.out,na.omit(df.out))
})

test_that("hotdeck with colnames starting with a number", {
  df = data.frame(Id = 1:3, x = c(NA, 0.2, 0.3))
  set.seed(1)
  dfi <- hotdeck(df)
  names(df) = c("Id", "1x")
  set.seed(1)
  dfi2 <- hotdeck(df)
  colnames(dfi) <- colnames(dfi2)
  expect_identical(dfi,dfi2)
})

## Test for missings at the beginning of the data set
test_that("hotdeck should fill all values including the first one", {
  df.out <- hotdeck(df2, variable=c("unit_id","wages01","fac"))
  expect_identical(df.out,na.omit(df.out))
})

test_that("hotdeck should fill all values including the first one - domain_var", {
  df.out <- hotdeck(df2, variable=c("unit_id","wages01","fac"), domain_var="state")
  expect_identical(df.out,na.omit(df.out))
})

test_that("hotdeck should fill all values including the first one - ord_var", {
  df.out <- hotdeck(df2, variable=c("unit_id","wages01","fac"), ord_var="r")
  expect_identical(df.out,na.omit(df.out))
})

test_that("hotdeck should fill all values including the first one - ord_var", {
  df.out <- hotdeck(df2, variable=c("fac"), ord_var="r")
  expect_identical(df.out$fac,na.omit(df.out$fac))
})

