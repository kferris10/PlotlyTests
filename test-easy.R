library(dplyr)
library(ggplot2)
library(plotly)

# load simulated tree data
setwd("~/Projects/plotly-tests")
trees <- read.csv("sim_trees.csv") %>% 
  tbl_df() %>% 
  mutate(location = factor(location, levels = c("LEF", "BZN")), 
         loc_site = paste(location, site, sep = "_"))

# plotting
p1 <- qplot(site, m_c, data = trees, colour = elevation, facets = ~location) + 
  ylab("Wood Water Content")
p1
ggsave("trees-ggplot.png", p1, width = 6, height = 4, units = "in")

# sending to plotly
py1 <- plotly()
py1$ggplotly(kwargs = list(filename="test-easy", fileopt="overwrite"))

