library(tidyverse)

grp1 <- anscombe %>% select(x = x1, y = y1) %>% mutate(group = "Group 1")
grp2 <- anscombe %>% select(x = x2, y = y2) %>% mutate(group = "Group 2")
grp3 <- anscombe %>% select(x = x3, y = y3) %>% mutate(group = "Group 3")
grp4 <- anscombe %>% select(x = x4, y = y4) %>% mutate(group = "Group 4")

data <- bind_rows(grp1, grp2, grp3, grp4) %>%
  as_tibble() %>%
  mutate(group = as_factor(group))

rm(grp1, grp2, grp3, grp4)

# numerical summaries
intercept <- function(x, y) {
  model <- lm(y ~ x)
  coefficients(model)[1]
}

slope <- function(x, y) {
  model <- lm(y ~ x)
  coefficients(model)[2]
}

data %>%
  group_by(group) %>%
  summarise(mean_x    = mean(x)         %>% round(1),
            var_x     = var(x)          %>% round(1),
            mean_y    = mean(y)         %>% round(1),
            var_y     = var(y)          %>% round(1),
            corr      = cor(x, y)       %>% round(1),
            intercept = intercept(x, y) %>% round(1),
            slope     = slope(x, y)     %>% round(1))

# plot
ggplot(data, aes(x = x, y = y)) +
  ggtitle("Anscombe Quadruplets") +
  geom_point(size = 2) +
  geom_smooth(method = "lm", se = FALSE, color = "red", fullrange = TRUE) +
  facet_wrap(vars(group)) +
  theme(axis.title.x = element_blank(), axis.title.y = element_blank())
