# Currently no self-defined functions are used for this project.
# please feel free to add in any for research purpose or convenience.
# Here is the file to set up any tests for the self-defined functions.
library(testthat)
print(getwd())
context('Test for selfDefineFunctions.R functions')

source('../functions/normalize.R')
context('Test for normailze function')

test_that('Test for proper functions', {
  x = c(0:10)
  ans = normalize(x, 0, 100)
  expect_equal(ans, seq.int(0, 100, 10))
  expect_length(ans, length(x))
  expect_type(ans, 'double')
})

test_that('Test for NA', {
  x = c(0:10, NA, NA)
  ans = normalize(x, 0, 100)
  expect_equal(ans, c(seq.int(0, 100, 10), NA, NA))
  expect_length(ans, length(x))
  expect_type(ans, 'double')
})

test_that('Test for incompatible type', {
  x = letters[1:5]
  expect_that(normalize(x), throws_error())
})

