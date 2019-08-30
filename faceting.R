library(tidyverse)
library(dslabs)

# compare 1962 and 2012 life_expectancy vs fertility
ds_theme_set()
filter(gapminder, year %in% c(1962, 2012)) %>%
  ggplot(aes(fertility, life_expectancy, col = continent)) +
  geom_point() +
  facet_grid(continent~year)
ggsave('figs/faceting-1.png')

# facet by only 'year' in above plot
filter(gapminder, year%in%c(1962, 2012)) %>%
  ggplot(aes(fertility, life_expectancy, col = continent)) +
  geom_point() +
  facet_grid(. ~ year)
ggsave('figs/faceting-2.png')

# facet_wrap() to display each plots with own viewable dimensions
years <- c(1962, 1980, 1990, 2000, 2012)
continents <- c("Europe", "Asia")
gapminder %>% 
  filter(year %in% years & continent %in% continents) %>%
  ggplot( aes(fertility, life_expectancy, col = continent)) +
  geom_point() +
  facet_wrap(~year) 
ggsave('figs/faceting-3.png')
