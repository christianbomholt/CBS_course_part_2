setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

library(readr)
library(dplyr)
library(fst)
library(rpart)
library(plotly)
library(visNetwork)


train <- read.fst("../data/bitcoin_train.fst")
test <- read.fst("../data/bitcoin_test.fst")

plot_ly(train,
  x = ~Timestamp,
  y = ~Open,
  type = "scatter",
  mode = "lines"
)
