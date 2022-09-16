library(tidyverse)

group_1 <- anscombe %>% select(x = x1, y = y1) %>% mutate(group = "Group_1")
group_2 <- anscombe %>% select(x = x2, y = y2) %>% mutate(group = "Group_2")
group_3 <- anscombe %>% select(x = x3, y = y3) %>% mutate(group = "Group_3")
group_4 <- anscombe %>% select(x = x4, y = y4) %>% mutate(group = "Group_4")

data <- bind_rows(group_1, group_2, group_3, group_4) %>% as_tibble()

rm(group_1, group_2, group_3, group_4)

data %>% write_csv(file = "anscombe.csv")
