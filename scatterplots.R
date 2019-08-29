library(tidyverse)
library(dslabs)

# load data from gapminder object stored in .rda file
load('rdas/gapminder.rda')

# scatterplot of life_expectancy vs fertility rate from 1962 
ds_theme_set()
gapminder %>% filter(year == 1962) %>%
  ggplot(aes(fertility, life_expectancy)) + geom_point()
ggsave('figs/scatterplot-1.png')

# scatterplot from above colored by continent
gapminder %>% filter(year == 1962) %>% 
  ggplot(aes(fertility, life_expectancy, color = continent)) + geom_point()
ggsave('figs/scatterplot-2.png')