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

# labelled fertility vs time plot for 'South Korea' and 'Germany'
labels <- data.frame(country = countries, x = c(1975,1965), y = c(60,72))
gapminder %>% 
  filter(country %in% countries) %>% 
  ggplot(aes(year, life_expectancy, col = country)) +
  geom_line() +
  geom_text(data = labels, aes(x, y, label = country), size = 5) +
  theme(legend.position = "none")
ggsave('figs/time_series-4.png')