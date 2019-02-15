diamonds <- ggplot2::diamonds %>%
  mutate(value = if_else(price >= 4000,  "high", "low")) %>%
  mutate(id = row_number())
#Create training set
train <- diamonds  %>% sample_frac(.70)
#Create test set
test  <- anti_join(diamonds, train, by = 'id')


pred <- predict(tree_model,test, type = 'class')
mean(pred==test$value)