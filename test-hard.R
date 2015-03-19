library(dplyr)
library(ggplot2)
library(testthat)

# load simulated tree data
setwd("~/Projects/plotly-tests")
trees <- read.csv("sim_trees.csv") %>% 
  tbl_df() %>% 
  mutate(location = factor(location, levels = c("LEF", "BZN")), 
         loc_site = paste(location, site, sep = "_"))

# the plot
p1 <- qplot(site, m_c, data = trees, colour = elevation, facets = ~location) + 
  ylab("Wood Water Content")

# tests -----------------------------------------------

# structure of plot
test_that("Class of plot", {
  expect_output(str(p1), "List of 9")
  expect_equal(class(p1), c("gg", "ggplot"))
})

# checking labels
test_that("Correct labels", {
  expect_equal(p1$labels$y, "Wood Water Content")
  expect_equal(p1$labels$x, "site")
  expect_equal(p1$labels$colour, "elevation")
})

# checking that it's facetted by location
test_that("Correct facets", {
  expect_true(length(p1$facet) > 1)
  expect_equal(names(p1$facet$facets), "location")
})