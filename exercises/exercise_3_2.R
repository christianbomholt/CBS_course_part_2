setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

library(readxl)
library(glmnet)

df <- read_excel('../data/xl/R.xlsx',col_names = T)
df$Date <- as.Date(df$Date,origin = '1970-01-01')

train <- df %>% filter(Date<'2013-01-01')
test <- df %>% filter(Date>='2013-01-01')


# Evaluer

mae <- function(fx,y){
  sum(abs(fx-y))
}

mae(test$Yield-predictions)