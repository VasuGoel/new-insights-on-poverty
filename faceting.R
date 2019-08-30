library(tidyverse)
library(dslabs)

# compare 1962 and 2012 life_expectancy vs fertility
ds_theme_set()
filter(gapminder, year %in% c(1962, 2012)) %>%
  ggplot(aes(fertility, life_expectancy, col = continent)) +
  geom_point() +
  facet_grid(continent~year)