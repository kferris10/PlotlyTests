library(dplyr)
library(ggplot2)
library(plotly)

# load simulated tree data
setwd("~/Projects/plotly-tests")
trees <- read.csv("sim_trees.csv") %>% 
  tbl_df() %>% 
  mutate(location = factor(location, levels = c("LEF", "BZN")), 
         loc_site = paste(location, site, sep = "_"))

# subset data
lef_H <- trees %>% filter(location == "LEF", elevation == "H")
lef_L <- trees %>% filter(location == "LEF", elevation == "L")
bzn <- trees %>% filter(location == "BZN")

# the plot
p1 <- qplot(site, m_c, data = trees, colour = elevation, facets = ~location) + 
  ylab("Wood Water Content")

# JSON data -----------------------------------------

trace1 <- list(
  x = lef_H$site, 
  y = lef_H$m_c, 
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
  x = lef_L$site, 
  y = lef_L$m_c, 
  mode = "markers", 
  name = "L", 
  type = "scatter", 
  marker = list(
    size = 10, 
    color = "rgb(0,191,196)", 
    symbol = "circle"
  ), 
  xaxis = "x1", 
  yaxis = "y1"
)
trace3 <- list(
  x = bzn$site,  
  y = bzn$m_c, 
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

# sending to plotly
py <- plotly()
response <- py$plotly(dat, kwargs=list(layout = layout, filename="test-medium", fileopt="overwrite"))
browseURL(response$url)
