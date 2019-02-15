setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

library(readr)
library(dplyr)
library(plotly)
library(broom)


avocados <- read_csv("../data/avocado.csv") %>%
  filter(region=="Albany") %>% 
  filter(type=="conventional")







###### PLOT #######

avocados %>% mutate(estimates = predict(IndsætModelHer,data = .)) %>% 
  select(AveragePrice,`Total Volume`,estimates) %>% 
  plot_ly(x= ~`Total Volume`, y = ~AveragePrice, mode="markers") %>%
  add_trace(y = ~estimates, mode = 'lines', name = "Estimate") %>% 
  add_trace(y = ~AveragePrice, mode = 'markers', name = "Actual")