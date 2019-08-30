library(tidyverse)
load('rdas/gapminder.rda')

# fertility vs time scatter plot for 'United States'
gapminder %>% 
  filter(country == "United States") %>% 
  ggplot(aes(year, fertility)) +
  geom_point()
ggsave('figs/time_series-1.png')

# fertility vs time line plot for 'United States' 
gapminder %>% 
  filter(country == "United States") %>% 
  ggplot(aes(year, fertility)) +
  geom_line()
ggsave('figs/time_series-2.png')

# time series line plot for 'South Korea' and 'Germany'
countries <- c("South Korea","Germany")
gapminder %>% filter(country %in% countries & !is.na(fertility)) %>% 
  ggplot(aes(year,fertility, col = country)) +
  geom_line()
ggsave('figs/time_series-3.png')