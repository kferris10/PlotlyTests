library(dplyr)
library(ggplot2)
library(plotly)

# load simulated tree data
setwd("~/Projects/plotly-tests")
trees <- read.csv("sim_trees.csv") %>% 
  tbl_df() %>% 
  mutate(location = factor(location, levels = c("LEF", "BZN")), 
         loc_site = paste(location, site, sep = "_"))

# the plot
p1 <- qplot(site, m_c, data = trees, colour = elevation, facets = ~location) + 
  ylab("Wood Water Content")

# JSON data -----------------------------------------

trace1 <- list(
  x = c(rep("S1", 12), rep("S2", 12)), 
  y = c(5.9, 6.1, 6.8, 6.9, 5.6, 4.2, 4.9, 5.4, 4.8, 3.9, 4.2, 
        6, 6.5, 5.6, 5, 5.1, 4.8, 7.5, 6.2, 4.7, 6.5, 5.1, 6), 
  mode = "markers", 
  name = "H", 
  type = "scatter", 
  marker = list(
    size = 10, 
    color = "rgb(248,118,109)", 
    symbol = "circle"
  ), 
  xaxis = "x1", 
  yaxis = "y1"
)
trace2 <- list(
  x = c(rep("S3", 12), rep("S4", 12)), 
  y = c(3.8, 2.6, 4.3, 3.6, 3, 4.5, 5.4, 5.2, 4.8, 6.3, 5.2, 6, 
        3.9, 3.8, 4.8, 4, 4.5, 3.7, 5.4, 5.8, 4, 4.4, 5.6), 
  mode = "markers", 
  name = "L", 
  type = "scatter", 
  marker = list(
    size = 10, 
    color = "rgb(0,191,196)", 
    symbol = "circle"
  )
  xaxis = "x1", 
  yaxis = "y1"
)
trace3 <- list(
  x = c(rep("S1", 32), rep("S2", 32)),  
  y = c(3, 3.6, 1.9, 3, 2.8, 3.4, 4.2, 5.3, 2.7, 2.6, 3.3, 2.9, 4.4, 2.9, 5.4, 3.3, 3.3, 3.9, 4.4, 4.2, 2.5, 3.6, 4.1, 4.7, 4.3, 4.2, 4.7, 5.7, 5.3, 4.5, 3.8, 5.4, 
        2.8, 2.8, 2.6, 4.1, 4.3, 4.4, 3.2, 3.1, 5.1, 3.3, 3.7, 3.6, 3.8, 5.4, 3.3, 4.4, 3.3, 3.2, 2.1, 3.8, 3.5, 2.9, 3.4, 3.7, 3.1, 2.5, 1.4, 2.2, 3.1, 3.1, 3.4, 3.2), 
  mode = "markers", 
  name = "H", 
  type = "scatter", 
  marker = list(
    size = 10, 
    color = "rgb(248,118,109)", 
    symbol = "circle"
  ), 
  xaxis = "x2", 
  yaxis = "y1"
)
dat <- list(trace1, trace3, trace2)

# creating a layout for facets
layout <- list(
  xaxis = list(
    domain = c(0, 0.47)
  ), 
  xaxis2 = list(
    domain = c(0.52, 0.97)
  ), 
  plot_bgcolor = "rgb(229,229,229)"
)

response <- py$plotly(dat, kwargs=list(layout = layout, filename="test-medium", fileopt="overwrite"))
browseURL(response$url)
